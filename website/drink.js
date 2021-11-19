module.exports = function(){
    var express = require('express');
    var router = express.Router();
    var mysql = require('./database/dbcon');

    // Gets a list of all drinks
    function getDrinks(res, mysql, context, complete){
        let query1 = `SELECT * FROM Drinks`;
        mysql.pool.query(query1, function(error, drinks, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                context.drink_info = drinks;
                complete();
            }
        });
    }

    // returns all entrees that match the given filter
    function getSearch(res, mysql, context, row, filter , complete){
        var query1
        if (row === "galactic_id" || row === "bounty"){
            query1 = `SELECT * FROM Drinks WHERE ? = ?`;
        } else{
            query1 = `SELECT * FROM Drinks WHERE ? LIKE ?`;
            filter = filter+"%" //ignore case
        }

        var data = [row, filter];
        mysql.pool.query(query1, data, function(error, drinks, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                console.log(query1, row, filter);
                console.log(drinks);
                context.drink_info = drinks;
                complete();
            }
        });
    }


    // Webpage routes
    
    // base drink page
    router.get('/', function(req, res){
        var callBackCount = 0;
        var context = {};

        getDrinks(res, mysql, context, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.render('drink', context);
            }
        }
    });

    // filter drinks
    router.get('/search', function(req, res){
        var callBackCount = 0;
        var context = {};

        getSearch(res, mysql, context, req.query.row, req.query.filter, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.status(200);
                res.render('drink', context);
            }
        }
    });

    // insert to table
    router.post('/', function(req, res){
        let query1 = `INSERT INTO Drinks (galactic_id, drink_name, species, planet, bounty) 
                        VALUES (NULL, ?, ?, ?, ?);`;
        var inserts = [req.body.drink_name, req.body.species,req.body.planet,req.body.bounty];
        mysql.pool.query(query1, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else {
                res.redirect('/drink');
            }
        });
    });

    return router;
}();