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
select * from Address;
delete from Address where addressID=1;
insert into Address(street, city, state, zip, country) values ("Backwards Street","Dallas","IA","60789","USA");
insert into Address(street, city, state, zip, country) values ("N. 34th St.","Funky Town","WY","60999","USA");
insert into Address(street, city, state, zip, country) values ("0000 Meditation Way","Portland","OR","75111","USA");
insert into Address(street, city, state, zip, country) values ("no street available","no city","no state","no zip","USA");

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
emailAddress VARCHAR(30),
primary key (emailID),
foreign key (personID) references Person(personID)
);

alter table Email add foreign key (personID) references Person(personID);

-- Creation of sample Email data --
select * from Email;
show create table Email;
insert into Email(personID,emailAddress) values (1,"rockythelesner@boxerbro.com");
insert into Email(personID,emailAddress) values (1,"rockyarockmysocks@socksbro.net");
insert into Email(personID,emailAddress) values (2,"thecringleberry@gmail.com");
insert into Email(personID,emailAddress) values (3,"YodaWise@gmail.com");
insert into Email(personID,emailAddress) values (3,"YodaWise@hotmail.com");
insert into Email(personID,emailAddress) values (3,"YodaWise@outlook.com");
insert into Email(personID,emailAddress) values (4,"");

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
