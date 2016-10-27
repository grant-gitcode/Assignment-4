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
insert into Address(street, city, state, zip, country) values 
("Backwards Street","Dallas","IA","60789","USA"),("N. 34th St.","Funky Town","WY","60999","USA"),
("0000 Meditation Way","Portland","OR","75111","USA"),("no street available","no city","no state","no zip","USA"),
("259 Time Travel Lane","Pensacola","FL","68570-0111","USA"),("1289 Marriage Drive","Omaha","NE","68123","USA"),
("1111 Surfer Way","Beach Town","CA","90234","USA"),("Everywhere Place","Minot","SD","34755","USA");

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
INSERT INTO Person(personCode,firstName,lastName,addressID) VALUES
("944c","Rocky","Lesner",1),
("306a","Hingle","McCringleberry",2),
("55bb","Yoda","Wise",3),
("2342","Billy Bob","Thorton",4);

CREATE TABLE Email (
emailID int(11) not null auto_increment,
personID int,
emailAddress VARCHAR(30),
primary key (emailID),
foreign key (personID) references Person(personID)
);

alter table Email add foreign key (personID) references Person(personID);

-- Creation of sample Email data --
insert into Email(personID,emailAddress) values 
(1,"rockythelesner@boxerbro.com"),(1,"rockyarockmysocks@socksbro.net"),
(2,"thecringleberry@gmail.com"),(3,"YodaWise@gmail.com"),
(3,"YodaWise@hotmail.com"),(3,"YodaWise@outlook.com"),(4,"");

create table Customer (

customerID int(11) not null auto_increment,

-- Entities found in Customer --

customerCode varchar(30),
subclass varchar(30),
personID int,
customerName varchar(100),
addressID int,


-- Creation of primary and foreign key --

primary key (customerID),
foreign key (personID) references Person(personID),
foreign key (addressID) references Address(addressID)
);

-- Creation of Customer sample data --
insert into Customer (customerCode,subclass,personID,customerName,addressID) values
("C001","G",1,"The University of Rick and Morty",5),("C002","S",2,"The Fellowship of the Wedding Ring",6),
("C003","S",3,"The Hang Ten Club",7),("C004","G",4,"Boring Town Inc.",8);

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
units int(11),
attachedProduct varchar(30),
productName varchar(30),
cost double precision,
discount double precision,
invoiceID int,

-- Division of products by SubClass (Ticket, Service) and --
-- SubSubClass (MovieTicket, SeasonPass, Refreshment, Parking Pass) --

type varchar(30),
subType varchar(30),
 
-- Specific SubSubClass entities --

-- MovieTicket entities --

movieDateTime DateTime,
movieScreenNo varchar(30),
movieAddress varchar(100),

-- SeasonPass entities --

startDate Date,
endDate Date,

-- Creation of primary and foreign keys --

primary key (productsID),
foreign key (invoiceID) references Invoice(invoiceID)
);

-- Creation of foreign key for Invoice table --

alter table Invoice add foreign key (productsID) references Products(productsID);

-- Creation of Invoice sample data --
insert into Invoice (invoiceCode,customerID,personID,date,productsID) values 
("INV001",1,1,'2016-10-03',1),("INV002",2,2,'2016-10-10',2),
("INV003",3,3,'2016-10-26',3),("INV004",4,4,'2016-10-16',4);

-- Creation of Products sample data --

-- Creation of "stock" products which are used for cloning --
insert into Products(productCode, subType,productName, startDate, endDate,cost) -- Product 1
values ("b29e","S","Halloween Pass",'2016-10-01','2016-10-31',90.00);
insert into Products (productCode, subType, productName,cost) values 			-- Product 2
("ff23","R","Butter Beer-200oz",40.99);
insert into Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) -- Product 3
values ("fp12","M",'2016-10-21 13:10',"The Shiny","345 Bloody Mary Way,Gretna, NE, 68190, USA","4A",20.00);
insert into Products (productCode,subType,cost) values ("90fa","P",50.00); 	-- Product 4

-- Creation of actual products associated with Invoices --
-- Invoice 1 --
insert into Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) select
productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost from Products where productsID=1;
update Products set invoiceID=1,units=10 where productsID=5;

insert into Products (productCode,subType,cost) select productCode,subType,cost from Products where productsID=4;
update Products set invoiceID=1,units=12,attachedProduct="fp12" where productsID=6;

-- Invoice 2 -- 
insert into Products (productCode, subType, productName,cost) select productCode,subType,productName,cost from
Products where productsID=2;
update Products set invoiceID=2,units=50 where productsID=7;

insert into Products (productCode,subType,cost) select productCode,subType,cost from Products where productsID=4;
update Products set invoiceID=2,units=30 where productsID=8;

-- Invoice 3 --
insert into Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) select
productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost from Products where productsID=3;
update Products set invoiceID=3,units=3 where productsID=9;

insert into Products (productCode, subType, productName,cost) select productCode,subType,productName,cost from
Products where productsID=2;
update Products set invoiceID=3,units=4 where productsID=10;

insert into Products (productCode,subType,cost) select productCode,subType,cost from Products where productsID=4;
update Products set invoiceID=3,units=2,attachedProduct="fp12" where productsID=11;

-- Invoice 4 --
insert into Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) select
productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost from Products where productsID=3;
update Products set invoiceID=4,units=5 where productsID=12;

insert into Products (productCode, subType, productName,cost) select productCode,subType,productName,cost from
Products where productsID=2;
update Products set invoiceID=4,units=7 where productsID=13;
