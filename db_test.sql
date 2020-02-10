-- Database: "R1_test"
/*
by :
Anthony Toussaint
Tracy Samanie
Zachery Bignall 
*/
--

DROP DATABASE R1_TEST;
CREATE DATABASE R1_TEST;
USE R1_TEST;
 
-- Employee table
create table Employee(
	empl_id int(11) NOT NULL AUTO_INCREMENT,
	e_addr varchar(50) DEFAULT NULL, 
	e_salary DECIMAL(19,9) NOT NULL,
	e_name varchar(25) NOT NULL, -- gotta make this a composite/ multi valued?
	PRIMARY KEY (empl_id)
);

-- Location table 
create table Location(
	l_id int(11) NOT NULL, 
	l_addr varchar(50) DEFAULT NULL, 
	l_phnum varchar(50),
	l_name varchar(50) NOT NULL, 
	l_income DECIMAL(19,9) NOT NULL,
    PRIMARY key (l_id)
);

-- Might need more work for Manages and Works_for relationships
create table Works_for(
	l_id int(11) NOT NULL,
    empl_id int(11) NOT NULL,
    PRIMARY KEY (l_id,empl_id),
    Constraint l_idFK foreign key (l_id) references Location(l_id),
    Constraint empl_idFK foreign key (empl_id) references Employee(empl_id)
    );

# leave out mangers and supervises for now , need to underatand how supervies would work frist 
/*    
create table Manages(
	l_id int(11) NOT NULL,
    empl_id int(11) NOT NULL,
    PRIMARY KEY (l_id,empl_id),
    Constraint l_idFK2 foreign key (l_id) references Location(l_id),
    Constraint empl_idFK2 foreign key (empl_id) references Employee(empl_id)
    );
-- this one needs work/incomplete, confused on if it would pull different names for the supervisor and supervisee
/* create table Supervision(
	empl_id int(11) NOT NULL,
    supevisor varchar(25) NOT NULL, -- gotta make this a composite/ multi valued?
    supervisee varchar(25) NOT NULL, -- gotta make this a composite/ multi valued?
    primary key (empl_id),
    */
    
#TAS this doesnt work, still trying to also figure this out ^^ ignore if needed
/*
 create table Supervisor(
	empl_id int(11) NOT NULL,
    manager_id int not null,
    primary key (empl_id, manager_id),
    Constraint empl_idFK2 foreign key (empl_id) references Employee(empl_id)
    );

create table Manages(
	l_id int(11) NOT NULL,
    manager_id int not null,
    PRIMARY KEY (l_id, manager_id),
    Constraint l_idFK2 foreign key (l_id) references Location(l_id),
    Constraint manager_idFK2 foreign key (manager_id) references Supervisor(manager_id)
    );
*/

-- still a bit confused on how to do these below
create table Buyer(
	b_name varchar(25) NOT NULL, -- composite prime key , leave as varchar
    b_id INT NOT NULL,
	date varchar(20) , -- composite/multi value, leave as varchar
	car_info varchar(50), -- composite/multi value, leave as varchar 
	 primary key(b_id)
);

-- from loction , buys_form
create table Buy_form(
	invoice_num INT,
	l_id INT NOT NULL,
	b_id INT NOT NULL,	
    Constraint l_idFK3 foreign key (l_id) references Location(l_id),
    Constraint b_idFK3 foreign key (b_id) references Buyer(b_id),
    primary key(l_id,b_id)
	);
    
-- inventory 
   create table Inventory(
   new_used varchar(10),
   car_num INT,
   company varchar(15),
   VIN_NUM varchar(35) NOT NULL,
   car_price INT NOT NULL,
   PRIMARY key (VIN_NUM)
   );
   
 -- Department 
create table Department(
	 Dep_id INT NOT NULL,
     d_name varchar(25),
     d_salary INT,
     primary key (Dep_id)
);
 -- parts
    create table Parts(
    part_name varchar(35), 
	part_num INT NOT NULL, 
	part_price INT NOT NULL, 
    PRIMARY key (part_num)
    );
    -- car 
   create table Car(
   repair_num INT NOT NULL,
   VIN_NUM varchar(50),
   repair_price INT NOT NULL,
   PRIMARY key (repair_num)
   );
-- from Department , sells to intcentory , has to parts  , repaiers to cars 
create table Sells(
	Dep_id INT NOT NULL,
	VIN_NUM varchar(40) NOT NULL,	
    Constraint Dep_idSFK4 foreign key (Dep_id) references Department(Dep_id),
    Constraint VIN_NUMSFK4 foreign key (VIN_NUM) references Inventory(VIN_NUM),
    primary key(Dep_id,VIN_NUM)
	);
create table Has(
	Dep_id INT NOT NULL,
	Part_num INT NOT NULL,
	Constraint Dep_idHFK5 foreign key (Dep_id) references Department(Dep_id),
    Constraint Part_numHFK5 foreign key (Part_num) references Parts(Part_num),
    primary key(Dep_id,Part_num)
	);
    create table Repairs(
	Dep_id INT NOT NULL,
	Repair_num INT NOT NULL,	
    Constraint Dep_idRFK6 foreign key (Dep_id) references Department(Dep_id),
    Constraint Repair_numRFK6 foreign key (Repair_num) references Car(Repair_num),
    primary key(Dep_id,Repair_num)
	);

insert into Employee (empl_id, e_addr, e_name, e_salary) values 
   (1, '98 south lane', 'smith,john', 40000), (2, '99 south lane', 'smith,jonny', 60000), (3, '100 south lane', 'Kinddy,Mark', 50000), (4, '101 south lane', 'Oohhun, Lone ', 40000), (5, '102 south lane', 'Sky,Han', 100000);

#insert into Supervisor(manager_id, empl_id) values
#	(1, 1), (2, 2);

insert into Location (l_id, l_addr, l_phnum, l_income, l_name) values 
   (101, '126 that street', 5124891152, 9846000, 'the pink Depot by fengroup');
   
insert into Works_for (l_id, empl_id) values
	(101, 1), (101, 2), (101, 3), (101, 4), (101, 5);
    
#insert into Manages (l_id, empl_id) values
#	(101, 1), (101,3);
	
insert into Buyer (date, b_id, b_name, car_info) values 
	('43833', 1, 'Smith,Lane ', 'RCA,159648,80000'), ('43834', 2, 'Jack,Train', '4-os,34Fe5e,5000');

insert into Department (Dep_id, d_name, d_salary) values 
	(11, 'sells_floor', 10000), (12, 'parts', 5000), (13, 'repair', 300);

insert into Parts (part_name, part_num, part_price) values 
	('battery', 1, 100), ('brakes pads', 2, 25), ('spark plugs', 3, 5), ('fuel injector ', 4, 10), ('radiator', 5, 45), ('car jark', 6, 50), ('nuts ', 7, 0.5), ('bolts', 8, 0.5), ('clutch', 9, 150), ('air filter', 10, 23), ('muffler', 11, 200), ('catalyic converter', 12, 150), ('alternator', 13, 300), ('seats', 14, 255), ('head light blub ', 15, 8), ('oil filter ', 16, 15), ('fuel filter', 17, 5), ('fues', 18, 5), ('brake disc', 19, 30), ('keys', 20, 500);

insert into Car (repair_num, VIN_NUM, repair_price) values 
	(1, '4reht6', 3000), (2, 'ssfj69ij-a', 500), (3, 'futis', 150);

insert into Inventory(new_used, car_num, company, vin_num, car_price) values 
	('New', 202, '4-os', '22eft57-a', 59999), ('Used', 203, '4-os', 'ssfj69ij-a', 29999), ('New', 204, 'RCA', '33gthry7-s', 39999);
