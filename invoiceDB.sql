drop table Products;
drop table Invoice;
drop table Customer;
drop table Person;
drop table Address;
drop table Email;
select * from Person;
alter table Person drop column ;
alter table Person drop foreign key Person_ibfk_1;
alter table Person drop foreign key Person_ibfk_2;
show create table Person;
-- show tables;

CREATE TABLE Email (
emailID int(11) not null auto_increment,
personID int,
emailAddess VARCHAR(30),
primary key (personID),
foreign key (personID) references Person(personID)
);


CREATE TABLE Address (
addressID int (11) not null auto_increment,
city varchar(30),
state varchar(30),
street varchar(30),
zip varchar(30),
country varchar(30),
primary key (addressID)
);

create table Person (
personID int(11) not null auto_increment,
personCode varchar(30),
firstName varchar(30),
lastName varchar(30),
addressID int,
primary key (personID),
foreign key (addressID) references Address(addressID)
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

-- Now a query to input sample data -- 

INSERT INTO Email VALUES(
