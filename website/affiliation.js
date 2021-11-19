module.exports = function(){
    var express = require('express');
    var router = express.Router();
    var mysql = require('./database/dbcon');

    // Gets a list of all affiliations
    function getAffiliations(res, mysql, context, complete){
        let query1 = `SELECT * FROM Affiliations`;
        mysql.pool.query(query1, function(error, affiliations, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                context.affiliation_info = affiliations;
                complete();
            }
        });
    }

    // returns all entrees that match the given filter
    function getSearch(res, mysql, context, row, filter , complete){
        var query1
        if (row === "galactic_id" || row === "bounty"){
            query1 = `SELECT * FROM Affiliations WHERE ? = ?`;
        } else{
            query1 = `SELECT * FROM Affiliations WHERE ? LIKE ?`;
            filter = filter+"%" //ignore case
        }

        var data = [row, filter];
        mysql.pool.query(query1, data, function(error, affiliations, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else{
                console.log(query1, row, filter);
                console.log(affiliations);
                context.affiliation_info = affiliations;
                complete();
            }
        });
    }


    // Webpage routes
    
    // base affiliation page
    router.get('/', function(req, res){
        var callBackCount = 0;
        var context = {};

        getAffiliations(res, mysql, context, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.render('affiliation', context);
            }
        }
    });

    // filter affiliations
    router.get('/search', function(req, res){
        var callBackCount = 0;
        var context = {};

        getSearch(res, mysql, context, req.query.row, req.query.filter, complete);
        function complete(){
            callBackCount++;
            if(callBackCount >= 1){
                res.status(200);
                res.render('affiliation', context);
            }
        }
    });

    // insert to table
    router.post('/', function(req, res){
        let query1 = `INSERT INTO Affiliations (id, galactic_id, affiliation) 
                        VALUES (NULL, ?, ?);`;
        var inserts = [req.body.galactic_id, req.body.affiliation];
        mysql.pool.query(query1, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            else {
                res.redirect('/affiliation');
            }
        });
    });

    return router;
}();