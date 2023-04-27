const User = require('./../models/userModel')
const catchAsync = require('./../utils/catchAsync')
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