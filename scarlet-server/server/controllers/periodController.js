const Period = require('./../models/periodModel')

exports.getAllPeriods = async (request, response) => {
    try {
        const periods = await Period.find();

        response.status(200).json({
            status: "success",
            data: {
                periods
            }
        })
    } catch (err) {
        console.log(err);
    }
}

exports.getPeriod = (request, response) => {

    const id = request.params.id * 1;

    const period = Period.find(id);
}

exports.updatePeriod = (request, response) => {

}

exports.deletePeriod = (request, response) => {


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