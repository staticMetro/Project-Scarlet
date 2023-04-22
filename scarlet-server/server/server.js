const mongoose = require('mongoose');
const dotenv = require('dotenv');
dotenv.config({ path: './config.env' })
const app = require('./app');



const DB = process.env.DATABASE.replace('<password>', process.env.DATABASE_PASSWORD)
    .replace('<username>', process.env.DATABASE_USERNAME)

mongoose.connect(DB).then(() => console.log("You have connected to the database"))

const PORT = process.env.PORT

app.listen(PORT, () => {
    console.log(`App running on.... ${PORT}`)
})