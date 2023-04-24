const express = require('express');
const compression = require('compression')
const cors = require('cors')
const morgan = require('morgan')

const AppError = require('./utils/appError')
const userRouter = require("./routes/userRoutes")
const periodRouter = require("./routes/periodRoutes");
const reviewRouter = require("./routes/reviewRoutes");

const app = express();


app.use(compression());
app.use(cors());

//Body Parser
app.use(express.json());

if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
}



app.get("/", function (request, response, next) {
    response.status(200).json({
        status: "success",
        message: "You have made a get request"
    })
})
app.use("/api/v1/users", userRouter);
app.use("/api/v1/periods", periodRouter);
app.use("/api/v1/reviews", reviewRouter);
app.all("*", function (request, response, next) {
    next(new AppError(`Can not find ${request.originalUrl} on this server`))
})

app.use((err, req, res, next) => {
    err.statusCode = err.statusCode ?? 500;
    err.status = err.status ?? 'error';

    res.status(err.statusCode).json({
        status: err.status,
        message: err.message
    })
})
module.exports = app;