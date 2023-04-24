const mongoose = require('mongoose');
const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: [true, "You must input your first name"],
        maxLength: [20, "First name must have less than 20 characters"]
    },
    lastName: {
        type: String,
        required: [true, "You must input your last name"],
        maxLength: [20, "Last name must have less than 20 characters"]
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

module.exports = User;