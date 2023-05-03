const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcryptjs')
const crypto = require('crypto');
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
    role: {
        type: String,
        enum: ["admin", "user"],
    },
    active: {
        type: Boolean,
        default: true
    },
    passwordChangedAt: {
        type: Date,
        select: false
    },
    passwordResetToken: {
        type: "String",
        select: false
    },
    passwordResetExpires: {
        type: Date,
        select: false
    }
    
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

userSchema.methods.changedPasswordAfter = function (JWTTimestamp) {
    if (this.passwordChangedAt) {
        const changedTimestamp = parseInt(this.passwordChangedAt.getTime() / 1000, 10)

        return JWTTimestamp < changedTimestamp; 
    }

    return false;
}

userSchema.methods.createPasswordResetToken = function () {
    const resetToken = crypto.randomBytes(32).toString('hex');

    this.passwordResetToken = crypto.createHash('sha256').update(resetToken).digest('hex');

    this.passwordResetExpires = Date.now() + 10 * 60 * 1000
    return resetToken;
}

const User = mongoose.model("User", userSchema);

module.exports = User;