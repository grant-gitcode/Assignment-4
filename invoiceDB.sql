drop table Products;
drop table Invoice;
drop table Customer;
drop table Person;
drop table Address;
drop table Email;
select * from Person;
alter table Person drop column emailID;
alter table Person drop column addressID;
alter table Person drop foreign key Person_ibfk_1;
alter table Person drop foreign key Person_ibfk_2;
show create table Person;
set foreign_key_checks = 0;

-- show tables;

CREATE TABLE Address (
addressID int (11) not null auto_increment,
street varchar(30),
city varchar(30),
state varchar(30),
zip varchar(30),
country varchar(30),
primary key (addressID)
);

-- Creation of Address sample data -- 
insert into Address(street, city, state, zip, country) values (
4
944c;Lesner, Rocky;321 Backwards Street,Dallas,IA,60789,USA;rockythelesner@boxerbro.com, rockyarockmysocks@socksbro.net
306a;McCringleberry, Hingle;2906 N. 34th St.,Funky Town,WY,60999,USA;thecringleberry@gmail.com
55bb;Wise, Yoda;0000 Meditation Way,Portland,OR,75111,USA;YodaWise@gmail.com, YodaWise@hotmail.com, YodaWise@outlook.com
2342;Thorton, Billy Bob;no street available,no city,no state,no zip,no nation;



create table Person (
personID int(11) not null auto_increment,
personCode varchar(30),
firstName varchar(30),
lastName varchar(30),
addressID int,
primary key (personID),
foreign key (addressID) references Address(addressID)
);

-- Creation of Person sample data -- 
select * from Person;
delete from Person where personID = 1;
INSERT INTO Person(personCode,firstName,lastName,addressID) VALUES("944c","Rocky","Lesner",1);
INSERT INTO Person(personCode,firstName,lastName,addressID) VALUES("306a","Hingle","McCringleberry",2);
INSERT INTO Person(personCode,firstName,lastName,addressID) VALUES("55bb","Yoda","Wise",3);
INSERT INTO Person(personCode,firstName,lastName,addressID) VALUES("2342","Billy Bob","Thorton",4);

CREATE TABLE Email (
emailID int(11) not null auto_increment,
personID int,
emailAddess VARCHAR(30),
primary key (emailID),
foreign key (personID) references Person(personID)
);

alter table Email add foreign key (personID) references Person(personID);

create table Customer (

customerID int(11) not null auto_increment,

-- Entities found in Customer --

customerCode varchar(30),
personID int,
customerName varchar(30),
addressID int,
subclass varchar(30),

-- Creation of primary and foreign key --

primary key (customerID),
foreign key (personID) references Person(personID),
foreign key (addressID) references Address(addressID)
);

create table Invoice (
invoiceID int(11) not null auto_increment,
invoiceCode varchar(30),
customerID int,
date Date,
personID int,
productsID int,
primary key (invoiceID),
foreign key (customerID) references Customer(customerID),
foreign key (personID) references Person(personID)
);

create table Products (

-- entities which are common to all products --

productsID int(11) not null auto_increment,
productCode varchar(30),
units varchar(30),
attachedProduct varchar(30),
productName varchar(30),
pricePerUnit double precision,
discount double precision,
invoiceID int,

-- Division of products by SubClass (Ticket, Service) and --
-- SubSubClass (MovieTicket, SeasonPass, Refreshment, Parking Pass) --

productSubClass varchar(30),
productSubSubClass varchar(30),
 
-- Specific SubSubClass entities --

-- MovieTicket entities --

movieDateTime Date,
movieScreenNo varchar(30),
movieAddress varchar(30),

-- SeasonPass entities --

startDate Date,
endDate Date,

-- Creation of primary and foreign keys --

primary key (productsID),
foreign key (invoiceID) references Invoice(invoiceID)
);
