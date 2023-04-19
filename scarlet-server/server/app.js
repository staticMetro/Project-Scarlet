const express = require('express');
const compression = require('compression')
const cors = require('cors')
const userRouter = require("./routes/userRoutes")
const periodRouter = require("./routes/periodRoutes");
const reviewRouter = require("./routes/reviewRoutes");
const morgan = require('morgan')
const app = express();

app.use(compression());
app.use(cors());

if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
}




app.use("/api/v1/users", userRouter);
app.use("/api/v1/periods", periodRouter);
app.use("/api/v1/reviews", reviewRouter);
app.use("*", function (request, response, next) {
    console.log('error');
})

module.exports = app;