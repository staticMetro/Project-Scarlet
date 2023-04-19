const express = require('express');
const periodController = require('./../controllers/userController')

const router = express.Router();

router
    .route('/')
    .get(userController.getAllPeriods)
    .post(userController.createPeriod)

router
    .route('/:id')
    .get(userController.getPeriod)
    .patch(userConctroller.updatePeriod)
    .delete(userController.deletePeriod);

module.exports = router;