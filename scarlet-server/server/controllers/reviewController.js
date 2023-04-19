const Review = require('./../models/reviewModel')

exports.getAllReviews = (request, response) => {

}

exports.getReview = async (request, response) => {

    const id = request.params.id * 1;

    const review = await Review.find(id);
}

exports.updateReview = (request, response) => {

}

exports.deleteReview = (request, response) => {


}

exports.createReview = async (request, response) => {

    try {
        const newReview = await Review.create(request.body);

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