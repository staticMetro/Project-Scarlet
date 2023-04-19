const mongoose = require('mongoose');

const periodSchema = new mongoose.Schema({
    periodStart: {
        type: Date,
        default: Date.now()
    },
    periodEnd: {
        type: Date,
    },
    nextPeriod: {
        type: Date,
    },
    fertileWindowStart: {
        type: Date,
    },
    fertileWindowEnd: {
        type: Date
    },
    futurePeriods: Array,
    sexuallyActive: {
        type: Boolean,
        required: [true, "You must input whether you are sexually active"]
    },
    flow: {
        type: String,
        enum: ["heavy", "medium", "low"]
    },
    chanceOfPregnancy: {
        type: Number,
    }
})

const Period = mongoose.model("Period", periodSchema)

module.exports = Period;