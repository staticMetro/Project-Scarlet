const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcryptjs')
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
        unique: true,
        lowercase: true,
        validate: [validator.isEmail, "Please provide an email"] 
    },
    password: {
        type: String,
        required: [true, "You must input your password"],
        minLength: [8, "Password must have at least 8 characters"],
        select: false
    },
    //Only works on save;
    passwordConfirm: {
        type: String,
        required: [true, "Please confirm your password"],
        validate: {
            validator: function(el) {
                return this.password === el;
            }
            ,
            message: 'Passwords are not the same!'
        }
    },
    
})

userSchema.pre('save', async function (next) {

    if (!this.isModified('password')) {
        return next();
    } else {
        //Encrypts password
        this.password = await bcrypt.hash(this.password, 12);
        //removes password confirm field
        this.passwordConfirm = undefined;
        next()
    }

})

userSchema.methods.correctPassword = async function (candidatePassword, userPassword) {
    return await bcrypt.compare(candidatePassword, userPassword)
}

const User = mongoose.model("User", userSchema);

module.exports = User;