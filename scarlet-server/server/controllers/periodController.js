const Period = require('./../models/periodModel.js')

exports.getAllPeriods = (request, response) => {

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