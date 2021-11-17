var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_handelae',
  password        : 'tythub-pYkquw-3gibvu',
  database        : 'cs340_handelae'
});
module.exports.pool = pool;
