
const mysql = require("mysql");
const express = require("express");
const { query } = require("express");

const app = express();
app.use(express.urlencoded());
const port = 8000;

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "f1f1",
    database: "memomec_users"
});

con.connect(function(error){ //connecting to database
    if(!!error){
        console.log("Couldnt connect to databank!");
    }
    else{
        console.log("Connected to databank!");
    }    
});

app.post("/", (req, res) => {  // checks if username and password are correct.

    var data = req.body;
    console.log(data);
    con.query('SELECT *  FROM users WHERE Username = ?', [data["Username"]], (err, result) => {

        if(result.length<= 0){ // result = [] if we dont fine any record with sended username.
            console.log("Recived wrong username.");
            res.sendStatus(404);
            return;
        }
        else{
            if(data["Password"] == result[0]["Password"]){ // compares given pass with pass in database.
                console.log("Password is correct.");


                con.query('INSERT INTO loginrecord (LoginDate, UserID) VALUES (?, ?)', [data["Date"], result[0]["UserID"]], (err, iresult) => { // if pass and username are correct we create new login record.
                   if(err){
                       console.log("Couldnt create new record for loginrecord table.");
                       console.log(iresult);                    
                   }
                   else{
                       console.log("record created for loginrecord table!");
                       console.log(iresult.insertId);
                       res.json(iresult); // sending iresult back to client to know the rows id, so that we can post login duration later.

                   }
                });
            }
            else{
                console.log("Recived wrong password.");
                res.sendStatus(404);
            }
        }
    });
});

app.post("/dur", (req, res) => {
    var data = req.body;
    con.query("UPDATE loginrecord SET LoginDuration = ? WHERE RecordID = ?", [data["Duration"],data["RecordID"]], (err, result) => { // find the record and add login duration.
        if(err) throw err;
        res.sendStatus(200);
    });
});

app.listen(port, () =>{
    console.log("Listening on port: " + port);
});