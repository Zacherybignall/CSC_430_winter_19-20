-- Database: "R3_test"
/*
by :
Anthony Toussaint
Tracy Samanie
Zachery Bignall 
*/
--
DROP DATABASE if exists R3_TEST;
CREATE DATABASE R3_TEST;
USE R3_TEST;

#can add location where employee manages
# change this to weekly values for emplyoees??ZAB?
create table Employee(
	empl_id int NOT NULL AUTO_INCREMENT,
	e_addr varchar(50) DEFAULT NULL, 
	e_salary DECIMAL(19,9) NOT NULL,
	e_name varchar(25) NOT NULL, -- gotta make this a composite/ multi valued?
	PRIMARY KEY (empl_id)
);

create table Customer(
	customer_id int NOT NULL AUTO_INCREMENT,
	c_addr varchar(50) DEFAULT NULL, 
	c_phone int  NOT NULL,
	c_name varchar(25) NOT NULL, -- gotta make this a composite/ multi valued?
	PRIMARY KEY (customer_id)
);

#can add nmilage, date aquired
create table Cars(
	vin_num varchar(45) not null, 
	new_used enum ('new','used'),
	make varchar(45),
    model varchar(45),
    suggest_price INT NOT NULL,
	PRIMARY key (VIN_NUM)
   );
   
create table Car_sold(
	car_sold_id int not null, 
	vin_num varchar(45),
    customer_id int,
    agreed_price int,
    date_sold date,
    empl_id int,
    empl_comission int,
    primary key (car_sold_id),
	Constraint vin_numFK foreign key (vin_num) references Cars(vin_num),
    Constraint customer_idFK foreign key (customer_id) references Customer(customer_id),
    Constraint empl_idFK foreign key (empl_id) references Employee(empl_id)
    );
    
create table car_loan(
	loan_id int not null,
	car_sold_id int,
	loan_price int, 
	primary key (loan_id),
    constraint loan_idFK2 foreign key (car_sold_id) references Car_sold(car_sold_id)
    );
    

insert into Employee (empl_id, e_addr, e_name, e_salary) values 
	(1, '98 south lane', 'smith,john', 40000), (2, '99 south lane', 'smith,jonny', 60000), (3, '100 south lane', 'Kinddy,Mark', 50000), (4, '101 south lane', 'Oohhun, Lone ', 40000), (5, '102 south lane', 'Sky,Han', 100000);

insert into Customer (customer_id, c_name, c_addr, c_phone) values 
	(101, 'Smith,Lane', 'Address A', 123456789), (102, 'Albert', 'Address B', 234567891);

insert into cars (new_used, make, model, vin_num, suggest_price) values 
	('New', 'Honda', 'CR-V', '22eft57-a', 59999), ('Used', 'Jeep', 'Wrangler', 'ssfj69ij-a', 29999);

insert into Car_sold (car_sold_id, vin_num, customer_id, agreed_price, date_sold, empl_id,empl_comission ) values
	(1, '22eft57-a', 101, 40000, '20-10-9', 1,1200);

insert into car_loan (loan_id, car_sold_id, loan_price) values
	(00001, 1, 60000);
#make this the view ?
select (l.loan_price - s.agreed_price),s.empl_id, s.vin_num, s.customer_id
from car_loan l, car_sold s
where l.car_sold_id = s.car_sold_id and ((l.loan_price*1.5) > s.agreed_price);

select c.empl_id, c.vin_num, c.customer_id
from car_sold c, (select loan_price,car_sold_id from car_loan) cr, (select suggest_price,vin_num from cars) ca
where cr.car_sold_id = c.car_sold_id and c.vin_num = ca.vin_num and ((c.agreed_price < (cr.loan_price*1.5)) or ((ca.suggest_price) < (cr.loan_price*1.2)) or (c.empl_comission) >= (cr.loan_price*0.02));
