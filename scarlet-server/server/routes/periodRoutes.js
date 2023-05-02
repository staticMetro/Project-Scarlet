const express = require('express');
const periodController = require('./../controllers/periodController')
const authController = require('./../controllers/authController')
const router = express.Router();



router
    .route('/')
    .get(authController.protect, authController.restrictTo("admin"), periodController.getAllPeriods)
    .post(periodController.createPeriod)

router
    .route('/:id')
    .get(periodController.getPeriod)
    .patch(periodController.updatePeriod)
    .delete(periodController.deletePeriod);

module.exports = router;