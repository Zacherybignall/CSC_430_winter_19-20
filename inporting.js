//ZB.
var mysql = require('mysql');
var readline = require('readline');
async function main() {
    //should only run once a week ( use system clock on program )
    //connections to the database and gets the tabel we what  to work with.
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "LatechZachery20!"
    });
    var r1 = readline.createInterface({
        input: process.stdin,
        output: process.stdout,
        terminal: false
    });
    //console.log(">>please but in a command from list in {}:\n {see} table\n {input} car sold info")
    r1.question(">>please but in a command from list in {}:\n {see} car sold table table\n {input} car sold info \n {exit} to leave the program \n", function (answer) {
        //console.log(answer);
        if (answer.localeCompare("input") == 0) {
            r1.question(">>please insert a with the sentax : car_sold_id, 'vin_num', customer_id, agreed_price, date_sold{ex:20/2/23}, empl_id : seperated by commas{,} and spaces \n", function (input) {
                console.log(input);
                con.connect(function (err) {
                    if (err) throw err;
                    con.query("use R3_TEST", function (err, result) {
                        if (err) throw err;
                        console.log("useing database R3_test");
                        con.end();
                    });
                    con.query(`INSERT INTO Car_sold (car_sold_id, vin_num, customer_id, agreed_price, date_sold, empl_id) VALUES (` + input + `);`, function (err, result) {
                        if (err) throw err;
                        //console.log(result);
                    });
                });
                console.log("test worked");
            });
        } else if (answer.localeCompare("see") == 0) {
            con.connect(function (err) {
                if (err) throw err;
                con.query("use R3_TEST", function (err, result) {
                    if (err) throw err;
                    console.log("useing database R3_test");
                    con.end();
                });
                con.query("select * from car_sold", function (err, result) {
                    if (err) throw err;
                    console.log(result);
                });
            });
        } else if (answer.localeCompare("exit") == 0) {
            break;
        };
    });

    /*
    if (answer.localeCompare("input")) {
        console.log("test worked");
    };
    /*
    //good to go , ie if need to run and update te table
    con.connect(function (err) {
        if (err) throw err;
        con.query("use R3_TEST", function (err, result) {
            if (err) throw err;
            console.log("useing database R3_test");
            con.end();
        });
        con.query(" #TODO ;", function (err, result) {
            if (err) throw err;
            console.log("Table deleted");
        });
    });
    */

};
main();
