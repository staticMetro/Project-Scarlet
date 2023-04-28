const User = require('./../models/userModel')
const catchAsync = require('./../utils/catchAsync')
const { promisify } = require('util')
const jwt = require('jsonwebtoken')
const AppError = require('./../utils/appError')

const signToken = id => {

    return jwt.sign({ id }, process.env.JWT_SECRET, {
        expiresIn: process.env.JWT_EXPIRES_IN
    })
}

exports.signup = catchAsync(async (request, response, next) => {

    const newUser = await User.create({
        firstName: request.body.firstName,
        lastName: request.body.lastName,
        email: request.body.email,
        password: request.body.password,
        passwordConfirm: request.body.passwordConfirm
    })

    const token = signToken(newUser._id);

    response.status(200).json({
        status: "success",
        data: {
            token,
            user: newUser
        }
    })
})

exports.login = catchAsync(async (request, response, next) => {

    const { email, password } = request.body;

    //Check if email and password exist
    if (!email || !password) {
        return next(new AppError("Please provide email and password!", 400))
    }
    //check if the user exists
    const user = await User.findOne({ email }).select('+password')

    if (!user || !(await user.correctPassword(password, user.password))) {
        return next(new AppError("Incorrect email or password", 401))
    }

    const token = signToken(user._id)

    response.status(200).json({
        status: "success",
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
    const freshUser = await User.findById(decoded.id)
    if (!freshUser) {
        return next(new AppError("The user belonging to the token no longer exists", 401));
    }

    //Check if user changed password after the token was issued
    if (freshUser.changedPasswordAfter(decoded.iat)) {
        return next(new AppError ("User recently changed password! Please log in again.", 401))
    }
    
    request.user = freshUser;
    next();
})

exports.restrictTo = catchAsync(async (request, response, next) => {

    return (...roles) => {
        for (const role of roles) {
            if (role === request.user.role) {
                return next();
            }
        }
        return next(new AppError("You are not allowed to access this route", 401))
    }
})