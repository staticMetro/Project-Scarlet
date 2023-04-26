const AppError = require('./../utils/appError')

const handleCastErrorDB = (error) => {

    const message = `Invalide ${error.path}: ${error.value}`;
    return new AppError(message, 400);
}

const handleDuplicateErrorDB = (error) => {
    let value = '';
    for (const [key, val] of Object.entries(error.keyValue)) {
        value += `${key}: ${val} `
    }
    const message = `Duplicate field value: ${value}. Please use another value!`;
    return new AppError(message, 400);
}

const handleValidationErrorDB = error => {

    const errors = Object.values(err.errors).map(val => val.message)

    const message = `Invalid input data: ${errors.join('. ')}`
    return new AppError(message, 400);

}

const sendErrorDev = (err, response) => {
    response.status(err.statusCode).json({
        status: err.status,
        message: err.message,
        error: err,
        stack: err.stack
    })
}

const sendErrorProd = (err, response) => {

    if (err.isOperational) {

        response.status(err.statusCode).json({
            status: err.status,
            message: err.message,
        })
    } else {
        console.error(err);
        response.status(500).json({
            status: 'error',
            message: 'Something went very wrong!'
        })
    }
}

module.exports = (err, request, response, next) => {
    err.statusCode = err.statusCode ?? 500;
    err.status = err.status ?? 'error';

    if (process.env.NODE_ENV === 'development') {
        sendErrorDev(err, response)
    } else if (process.env.NODE_ENV === "production") {
        let error = { ...err };

        if (error.name === "CastError") error = handleCastErrorDB(error);
        if (error.code === 11000) error = handleDuplicateErrorDB(error);
        if (error.name === "ValidationError") error = handleValidationErrorDB(error);
        sendErrorProd(error, response)


    }
    
}