const APIFeatures = require('./../utils/apiFeatures')
const AppError = require('./../utils/appError');
const catchAsync = require('./../utils/catchAsync');

exports.getAll = Model => catchAsync(async (request, response, next) => {
    let filter = {};
    if (request.params.id) filter = { user: request.params.id }
    const features = new APIFeatures(Model.find(filter), request.query).filter().sort().paginate().limitFields()
    const data = await features.query;

    response.status(200).json({
        status: "status",
        data: {
            data
        }
    })
})

exports.getOne = Model => catchAsync(async (request, response, next) => {
    const data = await Model.findById(request.params.id);

    if (!data) {
        return next(new AppError('No resource found with that Id'))
    }
    response.status(200).json({
        status: "success",
        data: {
            data
        }
    })
})

exports.createOne = Model => catchAsync(async (request, response, next) => {

    const data = await Model.create(request.body)

    response.status(201).json({
        status: "success",
        data: {
            data
        }
    })
})

exports.updateOne = Model => catchAsync(async (request, response, next) => {
    const data = await Model.findByIdAndUpdate(request.params.id, request.body, {
        new: true,
        runValidators: true
    });

    if (!data) {
        return next(new AppError('No resource found with that Id'))
    }

    response.status(200).json({
        status: "success",
        data: {
            data
        }
    })
})

exports.deleteOne = Model => catchAsync(async (request, response, next) => {

    await Model.findByIdAndDelete(request.params.id);

    response.status(204).json({
        status: "success",
        data: null
    })
})