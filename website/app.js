'use strict';

// NOTE: Don't change the port number
const PORT = 3000;

var express = require('express');
var mysql = require('./database/dbcon');
var bodyParser = require('body-parser');

var app = express();
var handlebars = require('express-handlebars').create({
        defaultLayout:'main',
        });

// Configure Express to handle JSON and form data
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.engine('handlebars', handlebars.engine);
app.use(express.static(__dirname + '/public'));
app.set('view engine', 'handlebars');

app.set('mysql', mysql);

app.get('/', function (req, res) {
    res.render('index');
});

app.get("/order", function(req, res){
    res.render('order');
});

app.get("/customer", function(req, res){
    res.render('customer');
});

app.get("/affiliation", function(req, res){
    res.render('affiliation');
});

app.get("/drink", function(req, res){
    res.render('drink');
});

app.get("/customer_order", function(req, res){
    res.render('customer_order');
});

app.get("/drink_order", function(req, res){
    res.render('drink_order');
});

app.use(function(req,res){
    res.status(404);
    res.render('404');
  });
  
  app.use(function(err, req, res, next){
    console.error(err.stack);
    res.status(500);
    res.render('500');
  });
  
app.listen(PORT, function(){
    console.log('Express started on http://localhost:' + PORT + '; press Ctrl-C to terminate.');
  });