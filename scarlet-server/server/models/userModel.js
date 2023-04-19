const mongoose = require('mongoose');
const Period = require('./periodModel.js')
const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: [true, "You must input your first name"]
    },
    lastName: {
        type: String,
        required: [true, "You must input your last name"]
    },
    email: {
        type: String,
        required: [true, "You must input your email"],
        unique: true
    },
    password: {
        type: String,
        required: [true, "You must input your password"]
    },
    confirmPassword: {
        type: String,
    },
    periods: {}
})

const User = mongoose.model("User", userSchema);