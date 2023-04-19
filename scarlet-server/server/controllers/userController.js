const User = require('./../models/userModel.js')

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

exports.createPeriod = (request, response) => {

}