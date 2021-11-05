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

app.get("/order", (req, res) => {
    res.sendFile(__dirname + '/order.html');
});

app.get("/customer", (req, res) => {
    res.sendFile(__dirname + '/customer.html');
});

app.get("/affiliation", (req, res) => {
    res.sendFile(__dirname + '/affiliation.html');
});

app.get("/drink", (req, res) => {
    res.sendFile(__dirname + '/drink.html');
});

app.get("/customer_order", (req, res) => {
    res.sendFile(__dirname + '/customer_order.html');
});

app.get("/drink_order", (req, res) => {
    res.sendFile(__dirname + '/drink_order.html');
});

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}...`);
});