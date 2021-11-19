module.exports = function(){
    var express = require('express');
    var router = express.Router();
    var mysql = require('./database/dbcon');

    // Gets a list of all customers
    function getCustomers(res, mysql, context, complete){
        let query1 = `SELECT * FROM Customers`;
        mysql.pool.query(query1, function(error, customers, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                context.customer_info = customers;
                complete();
            }
        });
    }

    // Gets a single customer with the given id
    function getCustomer(res, mysql, context, galactic_id, complete){
        var responses = 0;
        let query1 = `SELECT * FROM Customers WHERE galactic_id = ?`;
        var data = [galactic_id];
        mysql.pool.query(query1, data, function(error, customers, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else {
                context.customer_info = customers[0];
                getDropDowns(res, mysql, context, hasUpdateContext);
                getRelations(res, mysql, context, galactic_id, hasUpdateContext);

                // Only continue the update pre-population once drop-down options selected
                function hasUpdateContext(){
                    responses++;
                    if(responses >= 2){
                        complete();
                    }
                }
            }
        });
    }

    // returns all entrees that match the given filter
    function getSearch(res, mysql, context, row, filter , complete){
        var query1
        if (row === "galactic_id" || row === "bounty"){
            query1 = `SELECT * FROM Customers WHERE ? = ?`;
        } else{
            query1 = `SELECT * FROM Customers WHERE ? LIKE ?`;
            filter = filter+"%" //ignore case
        }

        var data = [row, filter];
        mysql.pool.query(query1, data, function(error, customers, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                console.log(query1, row, filter);
                console.log(customers);
                context.customer_info = customers;
                complete();
            }
        });
    }


    // Webpage routes
    
    // base customer page
    router.get('/', function(req, res){
        var callBackCount = 0;
        var context = {};

        getCustomers(res, mysql, context, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.render('customer', context);
            }
        }
    });

    // filter customers
    router.get('/search', function(req, res){
        var callBackCount = 0;
        var context = {};

        getSearch(res, mysql, context, req.query.row, req.query.filter, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.status(200);
                res.render('customer', context);
            }
        }
    });

    // insert to table
    router.post('/', function(req, res){
        let query1 = `INSERT INTO Customers (galactic_id, customer_name, species, planet, bounty) 
                        VALUES (NULL, ?, ?, ?, ?);`;
        var inserts = [req.body.customer_name, req.body.species,req.body.planet,req.body.bounty];
        mysql.pool.query(query1, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else {
                res.redirect('/customer');
            }
        });
    });

    return router;
}();