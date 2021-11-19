module.exports = function(){
    var express = require('express');
    var router = express.Router();
    var mysql = require('./database/dbcon');

    // Gets a list of all orders
    function getOrders(res, mysql, context, complete){
        let query1 = `SELECT * FROM Orders`;
        mysql.pool.query(query1, function(error, orders, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                context.order_info = orders;
                complete();
            }
        });
    }

    // returns all entrees that match the given filter
    function getSearch(res, mysql, context, row, filter , complete){
        var query1
        if (row === "galactic_id" || row === "bounty"){
            query1 = `SELECT * FROM Orders WHERE ? = ?`;
        } else{
            query1 = `SELECT * FROM Orders WHERE ? LIKE ?`;
            filter = filter+"%" //ignore case
        }

        var data = [row, filter];
        mysql.pool.query(query1, data, function(error, orders, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                console.log(query1, row, filter);
                console.log(orders);
                context.order_info = orders;
                complete();
            }
        });
    }


    // Webpage routes
    
    // base order page
    router.get('/', function(req, res){
        var callBackCount = 0;
        var context = {};

        getOrders(res, mysql, context, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.render('order', context);
            }
        }
    });

    // filter orders
    router.get('/search', function(req, res){
        var callBackCount = 0;
        var context = {};

        getSearch(res, mysql, context, req.query.row, req.query.filter, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.status(200);
                res.render('order', context);
            }
        }
    });

    // insert to table
    router.post('/', function(req, res){
        let query1 = `INSERT INTO Orders (galactic_id, order_name, species, planet, bounty) 
                        VALUES (NULL, ?, ?, ?, ?);`;
        var inserts = [req.body.order_name, req.body.species,req.body.planet,req.body.bounty];
        mysql.pool.query(query1, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else {
                res.redirect('/order');
            }
        });
    });

    return router;
}();