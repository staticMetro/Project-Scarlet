const Period = require('./../models/periodModel')
const APIFeatures = require('./../utils/apiFeatures')
const catchAsync = require('./../utils/catchAsync')
const AppError = require('./../utils/appError')

exports.getAllPeriods = catchAsync(async (request, response, next) => {
    const features = new APIFeatures(Period.find(), request.query).filter().paginate().limitFields().sort();
    const periods = await features.query;

    response.status(200).json({
        status: "success",
        results: periods.length,
        data: {
            periods
        }
    })
})

exports.getPeriod = catchAsync(async (request, response, next) => {
    const period = await Period.findById(request.params.id);

    if (!period) {
        return next(new AppError('No period found with that Id'))
    }
    response.status(200).json({
        status: "success",
        data: {
            period
        }
    })
})

exports.updatePeriod = catchAsync(async (request, response, next) => {

    const period = await Period.findByIdAndUpdate(request.params.id, request.body, {
        new: true,
        runValidators: true
    });

    if (!period) {
        return next(new AppError('No period found with that Id'))
    }

    response.status(200).json({
        status: "success",
        data: {
            period
        }
    })

})

exports.deletePeriod = catchAsync(async (request, response, next) => {

    const period = await Period.findByIdAndDelete(request.params.id);

    if (!period) {
        return next(new AppError('No period found with that Id'))
    }

    response.status(200).json({
        status: "success",
        data: null
    })

})

exports.createPeriod = catchAsync(async (request, response, next) => {

    const newPeriod = await Period.create(request.body);

    response.status(201).json({
        status: "success",
        data: {
            period: newPeriod
        }
    })

})