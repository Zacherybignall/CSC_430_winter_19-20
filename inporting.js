//ZB.
var mysql = require('mysql');
const prompt = require('prompt-sync')();
async function main() {
    //connections to the database and gets the tabel we what  to work with.
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "LatechZachery20!"
    });
    console.log(">>please but in a command from list in {}:\n {see} car sold table table\n {input} car sold info \n {exit} to leave the program");
    const answer = prompt('');
    //console.log(answer);
    if (answer.localeCompare("input") == 0) {
        //r1.question(">>please insert a with the sentax : car_sold_id, 'vin_num', customer_id, agreed_price, date_sold{ex:20/2/23}, empl_id : seperated by commas{,} and spaces \n", function (input) {
        console.log(">>please insert a with the sentax : car_sold_id, 'vin_num', customer_id, agreed_price, date_sold{ex:20/2/23}, empl_id : seperated by commas{,} and spaces");
        var input = prompt('');
        //console.log(input);
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
            console.log("test worked");
        });
    } else if (answer.localeCompare("see") == 0) {
        con.connect(async function (err) {
            if (err) throw err;
            con.query("use R3_TEST", async function (err) {
                if (err) throw err;
                console.log("useing database R3_test");
                con.end();
            });
            con.query("select * from cars_sold", async function (err, result) {
                if (err) throw err;
                console.log(result);
            });
        });
        // has 3 things to look at 2 qureys and a table 
    } else if (answer.localeCompare("see real") == 0) {
        con.connect(async function (err) {
            if (err) throw err;
            con.query("use R3_TEST", async function (err) {
                if (err) throw err;
                console.log("useing database R3_test");
                con.end();
            });
            con.query("select c.empl_id, c.vin_num, c.customer_id from car_sold c, (select loan_price,car_sold_id from car_loan) cr, (select suggest_price,vin_num from cars) ca where cr.car_sold_id = c.car_sold_id and c.vin_num = ca.vin_num and ((c.agreed_price < (cr.loan_price*1.5)) or ((ca.suggest_price) < (cr.loan_price*1.2)) or (c.empl_comission) >= (cr.loan_price*0.02));", async function (err, result) {
                if (err) throw err;
                console.log("returns info below if :\n loan is way more then agreed price or suggest price. And of employee got too much comission\n",result);
            });
            con.query("select (l.loan_price - s.agreed_price),s.empl_id, s.vin_num, s.customer_id from car_loan l, car_sold s where l.car_sold_id = s.car_sold_id and ((l.loan_price*1.5) > s.agreed_price);", async function (err, result) {
                if (err) throw err;
                console.log('returns info below if :\n loan is way bigger then agreed price and shows how much it is off\n',result);
            });
            con.query("select * from admin_table", async function (err, result) {
                if (err) throw err;
                //console.log("");
                console.log('admin_table:\n',result);
            });
        });
        
    }else if (answer.localeCompare("exit") == 0) {
        loop = false;
    };
};
main();
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