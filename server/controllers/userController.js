const User = require('./../models/userModel')
const catchAsync = require('./../utils/catchAsync')
const AppError = require('./../utils/appError');
const factory = require('./handlerFactory')

const filteredObj = (obj, ...allowedFields) => {

    Object.keys(obj).forEach((element, i, array) => {
        if (!allowedFields.includes(element)) {
            delete obj[element]
        }

    })
    return obj;
}

exports.updateMe = catchAsync(async (request, response, next) => {
    if (request.body.password || request.body.passwordConfirm) {
        return next(new AppError('This route is not for updating your password', 400));
    }

    const filteredBody = filteredObj(request.body, 'name', 'email');
    const user = await User.findByIdAndUpdate(request.user.id, filteredBody, {
        new: true,
        runValidators: true
    })

    response.status(200).json({
        status: 'success',
        data: {
            user
        }
    })
})

exports._me = catchAsync(async (request, response, next) => {

    const id = request.user._id;

    const user = await User.findById(id).select("+active").select("+role");

    response.status(200).json({
        status: "success",
        data: {
            user
        }
    })
})

exports.deleteMe = catchAsync(async (request, response, next) => {

    await User.findByIdAndUpdate(request.user.id, { active: false }, { runValidators: true, new: true })

    response.status(204).json({
        status: "success",
        data: null
    })
})

exports.deleteUser = factory.deleteOne(User)
exports.updateUser = factory.updateOne(User);
exports.getUser = factory.getOne(User)
exports.getAllUsers = factory.getAll(User);