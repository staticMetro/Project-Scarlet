const mongoose = require('mongoose');
const dotenv = require('dotenv');

process.on('uncaughtException', err => {
    console.log(err.name, err.message)
    console.log('UNCAUGHT EXCEPTION! SHUTTING DOWN...')
    process.exit(1);
})

dotenv.config({ path: './config.env' })
const app = require('./app');

const DB = process.env.DATABASE.replace('<password>', process.env.DATABASE_PASSWORD)
    .replace('<username>', process.env.DATABASE_USERNAME)

mongoose.connect(DB).then(() => console.log("You have connected to the database"))

const PORT = process.env.PORT

const server = app.listen(PORT, () => {
    console.log(`App running on.... ${PORT}`)
})

process.on('unhandledRejection', err => {
    console.log(err.name, err.message);
    console.log('UNHANDLED REJECTION! SHUTTING DOWN...')
    server.close(() => {
        process.exit(1)
    })
});

