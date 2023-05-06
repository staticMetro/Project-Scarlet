const mongoose = require('mongoose');

const reviewSchema = new mongoose.Schema({
    createdAt: {
        type: Date,
        default: Date.now()
    },
    rating: {
        type: Number,
        default: 5.0
    },
    review: {
        type: String,
        default: "This is amazing"
    },
    user: {
        type: mongoose.Schema.ObjectId,
        ref: "User"
    }
})

const Review = mongoose.model("Review", reviewSchema);

module.exports = Review;