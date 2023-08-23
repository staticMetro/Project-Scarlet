const User = require('./../models/userModel')
const catchAsync = require('./../utils/catchAsync')
const { promisify } = require('util')
const jwt = require('jsonwebtoken')
const AppError = require('./../utils/appError')
const Email = require('./../utils/email')
const crypto = require('crypto')

const signToken = id => {

    return jwt.sign({ id }, process.env.JWT_SECRET, {
        expiresIn: process.env.JWT_EXPIRES_IN
    })
}

const createAndSendToken = (response, statusCode, user) => {
    const token = signToken(user._id);

    response.status(statusCode).json({
        status: "success",
        data: {
            user
        },
        token
    })
}

exports.signup = catchAsync(async (request, response, next) => {

    const newUser = await User.create({
        firstName: request.body.firstName,
        lastName: request.body.lastName,
        email: request.body.email,
        password: request.body.password,
        passwordConfirm: request.body.passwordConfirm,
    })

    const user = await User.findById(newUser._id.toString())

    const verifyToken = user.verifyUser();
    await user.save({ validateBeforeSave: false });

    const verifyURL = `${request.protocol}//:${request.get('host')}/api/v1/users/verify/${verifyToken}`

    try {
        await new Email(user, verifyURL).sendVerification();;
        response.status(200).json({
            status: 'success',
            message: 'You were sent an email'
        })
    } catch (err) {
        newUser.hashedToken = undefined;
        await user.save({ validateBeforeSave: false });
        return next(new AppError("Something went wrong. Please try again", 500))
    }

})

exports.verifyUser = catchAsync(async (request, response, next) => {

    const verifyToken = request.params.verifyToken;

    const hashedToken = crypto.createHash('sha256').update(verifyToken).digest('hex')

    const newUser = await User.findOne({ hashedToken })

    if (!newUser) {
        return next(new AppError('You could not be verified', 400));
    }

    newUser.active = true;
    newUser.verifyResetExpires = undefined;
    newUser.hashedToken = undefined;

    await newUser.save({ validateBeforeSave: false });
    newUser.active = undefined;
    createAndSendToken(response, 200, newUser)
})

exports.login = catchAsync(async (request, response, next) => {

    const { email, password } = request.body;

    //Check if email and password exist
    if (!email || !password) {
        return next(new AppError("Please provide email and password!", 400))
    }
    //check if the user exists
    const user = await User.findOne({ email }).select('+password').select('+active')

    if (!user.active || !user || !(await user.correctPassword(password, user.password))) {
        return next(new AppError("Incorrect email or password", 401))
    }
    user.active = undefined
    createAndSendToken(response, 200, user)

})

exports.logout = catchAsync(async (request, response, next) => {
    const token = jwt.sign({ "loggedout": "loggedout" }, "Goodbye", {
        expiresIn: "0s"
    })

    response.status(200).json({
        status: 'success',
        message: 'You have been logged out',
        token
    })
})



exports.protect = catchAsync(async (request, response, next) => {
    //Get Token

    let token;
    if (request.headers.authorization && request.headers.authorization.startsWith('Bearer')) {
        token = request.headers.authorization.split(' ')[1];
    }

    if (!token) {
        return next(new AppError('You are not logged in', 401));
    }

    //Verify token
    const decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
    // Check if user still exists
    const freshUser = await User.findById(decoded.id).select('+active').select('+role');
    if (!freshUser.active) {
        return next(new AppError("This user no longer exists", 400));
    }
    if (!freshUser) {
        return next(new AppError("The user belonging to the token no longer exists", 401));
    }
    freshUser.active = undefined;
    //Check if user changed password after the token was issued
    if (freshUser.changedPasswordAfter(decoded.iat)) {
        return next(new AppError("User recently changed password! Please log in again.", 401))
    }

    request.user = freshUser;
    next();
})

exports.restrictTo = (...roles) => {
    return (request, response, next) => {
        if (!roles.includes(request.user.role)) {
            return next(new AppError("You are not allowed to access this route", 401))
        }
        next();
    }
}

exports.forgotPassword = catchAsync(async (request, response, next) => {
    // get user based on email
    const { email } = request.body;
    const user = await User.findOne({ email })

    if (!user) {
        return next(new AppError("There is no user with this email", 401))
    }
    //generate token
    const resetToken = user.createPasswordResetToken();
    await user.save({ validateBeforeSave: false });
    //send to email



    const resetURL = `${request.protocol}://${request.get('host')}/api/v1/users/resetPassword/${resetToken}`

    const options = {
        email: user.email,
        subject: "reset password token",
        message: `Submit a patch request with your new password and passwordConfirm to ${resetURL}`
    }

    try {
        //await sendEmail(options);
        await new Email(user, resetURL).sendPasswordReset();
        response.status(200).json({
            status: "success",
            message: "token sent to the email"
        })
    } catch (err) {
        user.passwordResetToken = undefined;
        user.passwordResetExpires = undefined;
        await user.save({ validateBeforeSave: false })
        return new AppError("There was an error sending the email.. Try again", 500);
    }

})

exports.resetPassword = catchAsync(async (request, response, next) => {

    const { resetToken } = request.params;
    const { password, passwordConfirm } = request.body;

    if (!password) {
        return next(new AppError("Please provide new password!", 400))
    }

    const hashedResetToken = crypto.createHash('sha256').update(resetToken).digest('hex');

    const user = await User.findOne({ passwordResetToken: hashedResetToken, passwordResetExpires: { $gte: Date.now() } });

    if (!user) {
        return next(new AppError("Token is invalid or has expired", 400))
    }

    user.password = password;
    user.passwordConfirm = passwordConfirm;
    user.passwordResetToken = undefined;
    user.passwordResetExpires = undefined;
    await user.save()

    const token = signToken(user._id)

    response.status(200).json({
        status: "success",
        message: "Your password has been changed",
        token
    })
})

exports.updatePassword = catchAsync(async (request, response, next) => {

    const { oldPassword, password, passwordConfirm } = request.body;
    const user = await User.findById(request.user.id).select("+password");

    if (!user || !(await user.correctPassword(oldPassword, user.password))) {
        return next(new AppError("Password is incorrect", 401))
    }

    user.password = password;
    user.passwordConfirm = passwordConfirm;

    await user.save();

    createAndSendToken(response, 200, user);
})