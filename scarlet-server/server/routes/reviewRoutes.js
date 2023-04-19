const express = require('express');
const userController = require('./../controllers/userController')

const router = express.Router();

router
    .route('/')
    .get(reviewController.getAllReviews)
    .post(reviewController.createReview)

router
    .route('/:id')
    .get(reviewController.getReview)
    .patch(reviewConctroller.updateReview)
    .delete(reviewController.deleteReview);

module.exports = router;