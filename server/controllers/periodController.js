const Period = require('./../models/periodModel')
const factory = require('./handlerFactory')

exports.getAllPeriods = factory.getAll(Period);

exports.getPeriod = factory.getOne(Period);

exports.updatePeriod = factory.updateOne(Period);

exports.deletePeriod = factory.deleteOne(Period)

exports.createPeriod = factory.createOne(Period);