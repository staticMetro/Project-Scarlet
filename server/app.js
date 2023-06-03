const express = require('express');
const path = require('path');
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
const viewRouter = require("./routes/viewRoutes");
const app = express();

app.set('views', path.join(__dirname, 'views'));
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
app.use(express.static(path.join(__dirname, "..", "build")));
app.use(express.static(`${__dirname}/public`));
app.use(express.static(path.join(__dirname, "..", "build", "index.html")))
if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
}



app.use('/', viewRouter);
app.use("/api/v1/users", userRouter);
app.use("/api/v1/periods", periodRouter);

app.all("*", function (request, response, next) {
    next(new AppError(`Can not find ${request.originalUrl} on this server`))
})

app.use(globalErrorHandler)
module.exports = app;