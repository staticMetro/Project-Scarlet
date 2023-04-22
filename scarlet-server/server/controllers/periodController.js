const Period = require('./../models/periodModel')
const APIFeatures = require('./../utils/apiFeatures')

exports.getAllPeriods = async (request, response) => {
    try {
        const features = new APIFeatures(Period.find(), request.query).filter().paginate().limitFields().sort();
        const periods = await features.query; 

        response.status(200).json({
            status: "success",
            results: periods.length,
            data: {
                periods
            }
        })
    } catch (err) {
        response.status(400).json({
            status: "fail",
            message: err
        })
    }
}

exports.getPeriod = async (request, response) => {

    try {
        const period = await Period.findById(request.params.id);

        response.status(200).json({
            status: "success",
            data: {
                period
            }
        })
    } catch (err) {
        response.status(400).json({
            status: "fail",
            message: err
        })
    }
}

exports.updatePeriod = async (request, response) => {

    try {
        const period = await Period.findByIdAndUpdate(request.params.id, request.body, {
            new: true,
            runValidators: true});

        response.status(200).json({
            status: "success",
            data: {
                period
            }
        })
    } catch (err) {
        response.status(400).json({
            status: "fail",
            message: err
        })
    }
}

exports.deletePeriod = async (request, response) => {
    try {
        await Period.findByIdAndDelete(request.params.id);

        response.status(200).json({
            status: "success",
            data: null
        })
    } catch (err) {
        response.status(400).json({
            status: "fail",
            message: err
        })
    }

}

exports.createPeriod = async (request, response) => {

    try {
        console.log(request);
        const newPeriod = await Period.create(request.body);

        response.status(201).json({
            status: "success",
            data: {
                period: newPeriod
            }
        })
    } catch (err) {
        response.status(400).json({
            status: "fail",
            message: err
        })
    }
}