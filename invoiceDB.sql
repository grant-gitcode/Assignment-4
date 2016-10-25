drop table Email;
drop table Address;
drop table Person;
drop table Customer;
drop table Invoice;
drop table Products;
show tables;

CREATE TABLE Email (
emailID int(11),
emailAddess VARCHAR(30),
primary key (emailID)
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
emailID int,
primary key (personID),
foreign key (addressID) references Address(addressID),
foreign key (emailID) references Email(emailID)
);

create table Customer (
customerID int(11) not null auto_increment,
customerCode varchar(30),
personID int,
customerName varchar(30),
addressID int,
subclass varchar(30),
tax double precision,
fee double precision,
discount double precision,
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
productsID int(11) not null auto_increment,
productCode varchar(30),
productType varchar(30),
productName varchar(30),
ProductAddres varchar(30),
ProductScreenNO varchar(30),
ProductQuanity varchar(30),
StartDate Date,
EndDate Date,
primary key (Productsid) int(11),
foreign key (invoiceID) references Invoice(invoiceID)
);
