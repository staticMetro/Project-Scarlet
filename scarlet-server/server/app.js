const express = require('express');
const compression = require('compression')
const cors = require('cors')
const morgan = require('morgan')
const rateLimit = require("express-rate-limit")
const helmet = require('helmet');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean')
const hpp = require('hpp');

const globalErrorHandler = require('./controllers/errorController')
const AppError = require('./utils/appError')
const userRouter = require("./routes/userRoutes")
const periodRouter = require("./routes/periodRoutes");
const reviewRouter = require("./routes/reviewRoutes");

const app = express();

//HTTP SECURITY HEADERS
app.use(helmet());

//LIMIT REQUEST FROM THE SAME API
const limiter = rateLimit({
    max: 100,
    windowMs: 60 * 60 * 1000,
    message: 'Too many requests from this IP, please try again in an hour!'
});

app.use('/api', limiter);


app.use(compression());
app.use(cors());

//Body Parser
app.use(express.json({ limit: "10kb" }));

//DATA SANITIZATION AGAINST NOSQL QUERY INJECTION
app.use(mongoSanitize());
//DATA SANITIZATION 
app.use(xss());

//PREVENT PARAMETER POLLUTION;
app.use(hpp({
    whitelist: ["flow", "sexuallyActive", "periodStart"]
}));
//SERVING STATIC FILES
app.use(express.static(`${__dirname}/public`));

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

app.use(globalErrorHandler)
module.exports = app;