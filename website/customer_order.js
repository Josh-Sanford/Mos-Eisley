module.exports = function(){
    var express = require('express');
    var router = express.Router();
    var mysql = require('./database/dbcon');

    // Gets a list of all customers_orders
    function getCustomers_Orders(res, mysql, context, complete){
        let query1 = `SELECT * FROM Customer_Orders`;
        mysql.pool.query(query1, function(error, customers_orders, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                context.customers_order_info = customers_orders;
                complete();
            }
        });
    }

    // returns all entrees that match the given filter
    function getSearch(res, mysql, context, row, filter , complete){
        var query1
        if (row === "galactic_id" || row === "bounty"){
            query1 = `SELECT * FROM Customer_Orders WHERE ? = ?`;
        } else{
            query1 = `SELECT * FROM Customer_Orders WHERE ? LIKE ?`;
            filter = filter+"%" //ignore case
        }

        var data = [row, filter];
        mysql.pool.query(query1, data, function(error, customers_orders, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                console.log(query1, row, filter);
                console.log(customers_orders);
                context.customers_order_info = customers_orders;
                complete();
            }
        });
    }


    // Webpage routes
    
    // base customers_orders page
    router.get('/', function(req, res){
        var callBackCount = 0;
        var context = {};

        getCustomers_Orders(res, mysql, context, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.render('customer_order', context);
            }
        }
    });

    // filter customers_orders
    router.get('/search', function(req, res){
        var callBackCount = 0;
        var context = {};

        getSearch(res, mysql, context, req.query.row, req.query.filter, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.status(200);
                res.render('customer_order', context);
            }
        }
    });

    // insert to table
    router.post('/', function(req, res){
        let query1 = `INSERT INTO Customer_Orders (galactic_id, customer_name, species, planet, bounty) 
                        VALUES (NULL, ?, ?, ?, ?);`;
        var inserts = [req.body.customer_name, req.body.species,req.body.planet,req.body.bounty];
        mysql.pool.query(query1, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else {
                res.redirect('/customer_order');
            }
        });
    });

    return router;
}();