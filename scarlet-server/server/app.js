const express = require('express');
const app = express();


app.get('/', (request, response) => {
    response.status(200).json({message: "Hello from the serverside!", app: "project-scarlet"})
})
    .post('/', (request, response) => {
        response.status(200).json({message: "You can post to this endpoint..."})
    })
module.exports = app;