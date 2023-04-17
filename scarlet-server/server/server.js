const mongoose = require('mongoose');
const dotenv = require('dotenv');
const app = require('./app');

dotenv.config({ path: './config.env' })

const DB = process.env.DATABASE.replace('<password>', process.env.DATABASE_PASSWORD)
    .replace('<username>', process.env.DATABASE_USERNAME)

mongoose.connect(DB).then(() => console.log("You have connected to the database"))

const port = process.env.PORT || 5000;

app.listen(port, () => {
    console.log(`App running on.... ${port}`)
})