'use strict';

// NOTE: Don't change the port number
const PORT = 3000;

const express = require("express");
const app = express();


app.use(express.urlencoded({
    extended: true
}));

app.get("/", (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

app.get("/list", (req, res) => {
    res.sendFile(__dirname + '/stock_list.html');
});

app.get("/search", (req, res) => {
    res.sendFile(__dirname + '/stock_search.html');
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}...`);
});