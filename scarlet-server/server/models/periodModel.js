const mongoose = require('mongoose');

const periodSchema = new mongoose.Schema({
    periodStart: {
        type: Date,
        default: Date.now
    },
    periodEnd: {
        type: Date,
        default: Date.now
    },
    nextPeriod: {
        type: Date,
        default: Date.now
    },
    fertileWindowStart: {
        type: Date,
        default: Date.now
    },
    fertileWindowEnd: {
        type: Date,
        default: Date.now
    },
    futurePeriods: Array,
    sexuallyActive: {
        type: Boolean,
        required: [true, "You must input your sexual activity"]
    },
    flow: {
        type: String,
        enum: ["heavy", "medium", "light"]
    },
    chanceOfPregnancy: {
        type: Number,
    },
    user: {
        type: mongoose.Schema.ObjectId,
        ref: "User"
    }
})

const Period = mongoose.model("Period", periodSchema)

module.exports = Period;