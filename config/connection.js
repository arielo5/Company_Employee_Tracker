const mysql = require("mysql");
require('dotenv').config();

//create connection information to sql database
const connection = mysql.createConnection({ 
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    host: 'localhost',
    port: 3306,
    database: process.env.DB_NAME
});

// connection.connect((err) => {
//     if (err) {
//       throw Error(err);
//     }
//     console.log(`connecter on ${connection.threadId}\n`);
//     mainMenu();
  
//   });

module.exports = connection;