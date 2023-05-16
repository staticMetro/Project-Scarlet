const User = require('./../models/userModel')
const catchAsync = require('./../utils/catchAsync')
const AppError = require('./../utils/appError');

const filteredObj = (obj, ...allowedFields) => {

    Object.keys(obj).forEach((element, i, array) => {
        if (!allowedFields.includes(element)) {
            delete obj[element]
        }

    })
    return obj;
}

exports.getAllUsers = catchAsync(async (request, response, next) => {

    const users = await User.find();

    response.status(200).json({
        status: 'success',
        data: {
            users
        }
    })
})

exports.updateMe = catchAsync(async (request, response, next) => {
    console.log('here')
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

exports.getUser = (request, response) => {

    const id = request.params.id * 1;

    const user = User.findById(id);

    if (!user) {

    }
}

exports.updateUser = (request, response) => {

}

exports.deleteUser = catchAsync(async (request, response, next) => {

    await User.findByIdAndDelete(request.params.id);

    response.status(204).json({
        status: "success",
        data: null
    })
})

exports.deleteMe = catchAsync(async (request, response, next) => {
    
    await User.findByIdAndUpdate(request.user.id, { active: false }, { runValidators: true, new: true })

    response.status(204).json({
        status: "success",
        data: null
    })
})

exports.createUser = catchAsync(async (request, response) => {

    const user = await User.create(request.body);
    console.log('here');
    response.status(201).json({
        status: "success",
        data: {
            user
        }
    })
})