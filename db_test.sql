-- Database: "R1_test"
--
-- -----------------------

--
CREATE DATABASE R1_TEST;
-- DROP DATABASE R1_TEST;
USE R1_TEST;
 
-- Employee table
create table Employee(
	empl_id int(11) NOT NULL AUTO_INCREMENT,
	e_addr varchar(50) DEFAULT NULL, 
	salary DECIMAL(19,9) NOT NULL,
	e_name varchar(25) NOT NULL, -- gotta make this a composite/ multi valued?
	PRIMARY KEY (empl_id)
);

-- Location table 
create table Location(
	l_id int(11) NOT NULL, 
	l_addr varchar(50) DEFAULT NULL, 
	l_phnum int(10) NOT NULL, 
	l_name varchar(25) NOT NULL, 
	income DECIMAL(19,9) NOT NULL,
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
    primary key (empl_id), */ 
    

-- still a bit confused on how to do these below
create table Buyer(
date varchar(20) NOT NULL, -- composite/multi value
car_info varchar(50) NOT NULL, -- composite/multi value
b_name varchar(25) NOT NULL -- composite 
-- no prime key atm 
);

 
/* create table Department(
	 new_inv varchar()
     used_inv varchar()
 */