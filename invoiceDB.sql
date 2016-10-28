SET FOREIGN_KEY_CHECKS = 0;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE Address (
AddressID INT (11) NOT NULL AUTO_INCREMENT,
street VARCHAR(30),
city VARCHAR(30),
state VARCHAR(30),
zip VARCHAR(30),
country VARCHAR(30),
PRIMARY KEY (AddressID)
);

-- Creation of Address sample data -- 
INSERT INTO Address(street, city, state, zip, country) VALUES 
("Backwards Street","Dallas","IA","60789","USA"),("N. 34th St.","Funky Town","WY","60999","USA"),
("0000 Meditation Way","Portland","OR","75111","USA"),("no street available","no city","no state","no zip","USA"),
("259 Time Travel Lane","Pensacola","FL","68570-0111","USA"),("1289 Marriage Drive","Omaha","NE","68123","USA"),
("1111 Surfer Way","Beach Town","CA","90234","USA"),("Everywhere Place","MiNOT","SD","34755","USA");

CREATE TABLE Person (
personID INT(11) NOT NULL AUTO_INCREMENT,
personCode VARCHAR(30),
firstName VARCHAR(30),
lastName VARCHAR(30),
AddressID INT,
PRIMARY KEY (personID),
FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Creation of Person sample data -- 
INSERT INTO Person(personCode,firstName,lastName,AddressID) VALUES
("944c","Rocky","Lesner",1),
("306a","Hingle","McCringleberry",2),
("55bb","Yoda","Wise",3),
("2342","Billy Bob","Thorton",4),
("7777","Honest Joe","McHonest",5),
("8888","Honest Jane","McHonest",6);

CREATE TABLE Email (
emailID INT(11) NOT NULL AUTO_INCREMENT,
personID INT,
emailAddress VARCHAR(30),
PRIMARY KEY (emailID),
FOREIGN KEY (personID) REFERENCES Person(personID)
);

ALTER TABLE Email ADD FOREIGN KEY (personID) REFERENCES Person(personID);

-- Creation of sample Email data --
INSERT INTO Email(personID,emailAddress) VALUES 
(1,"rockythelesner@boxerbro.com"),(1,"rockyarockmysocks@socksbro.net"),
(2,"thecringleberry@gmail.com"),(3,"YodaWise@gmail.com"),
(3,"YodaWise@hotmail.com"),(3,"YodaWise@outlook.com"),(4,""),
(5,"honestJoseph@goodguy.org"),(6,"honestJane@goodgal.org");

CREATE TABLE Customer (

customerID INT(11) NOT NULL AUTO_INCREMENT,

-- Entities found in Customer --

customerCode VARCHAR(30),
subclass VARCHAR(30),
personID INT,
customerName VARCHAR(100),
AddressID INT,


-- Creation of PRIMARY and FOREIGN KEY --

PRIMARY KEY (customerID),
FOREIGN KEY (personID) REFERENCES Person(personID),
FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

-- Creation of Customer sample data --
INSERT INTO Customer (customerCode,subclass,personID,customerName,AddressID) VALUES
("C001","G",1,"The University of Rick and Morty",5),("C002","S",2,"The Fellowship of the Wedding Ring",6),
("C003","S",3,"The Hang Ten Club",7),("C004","G",4,"Boring Town Inc.",8),("C005","G",5,"NOT Corrupt Corp.",8);

CREATE TABLE Invoice (
invoiceID INT(11) NOT NULL AUTO_INCREMENT,
invoiceCode VARCHAR(30),
customerID INT,
date DATE,
personID INT,
productsID INT,
PRIMARY KEY (invoiceID),
FOREIGN KEY (customerID) REFERENCES Customer(customerID),
FOREIGN KEY (personID) REFERENCES Person(personID)
);

CREATE TABLE Products (

-- entities which are common to all products --

productsID INT(11) NOT NULL AUTO_INCREMENT,
productCode VARCHAR(30),
units INT(11),
attachedProduct VARCHAR(30),
productName VARCHAR(30),
cost DOUBLE PRECISION,
invoiceID INT,

-- Division of products by SubClass (Ticket, Service) and --
-- SubSubClass (MovieTicket, SeasonPass, Refreshment, Parking Pass) --

subType VARCHAR(30),
 
-- Specific SubSubClass entities --

-- MovieTicket entities --

movieDateTime DATETIME,
movieScreenNo VARCHAR(30),
movieAddress VARCHAR(100),

-- SeasonPass entities --

startDate DATE,
endDate DATE,

-- Creation of PRIMARY and FOREIGN KEYs --

PRIMARY KEY (productsID),
FOREIGN KEY (invoiceID) REFERENCES Invoice(invoiceID)
);

-- Creation of FOREIGN KEY for Invoice TABLE --

ALTER TABLE Invoice ADD FOREIGN KEY (productsID) REFERENCES Products(productsID);

-- Creation of Invoice sample data --
INSERT INTO Invoice (invoiceCode,customerID,personID,date,productsID) VALUES 
("INV001",1,1,'2016-10-03',1),("INV002",2,2,'2016-10-10',2),
("INV003",3,3,'2016-10-26',3),("INV004",4,4,'2016-10-16',4),
("INV005",5,6,'2016-10-06',5);

-- Creation of Products sample data --

-- Creation of "stock" products which are used for cloning --
INSERT INTO Products(productCode, subType,productName, startDate, endDate,cost) -- Product 1
VALUES ("b29e","S","Halloween Pass",'2016-10-01','2016-10-31',90.00);
INSERT INTO Products (productCode, subType, productName,cost) VALUES 			-- Product 2
("ff23","R","Butter Beer-200oz",40.99);
INSERT INTO Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) -- Product 3
VALUES ("fp12","M",'2016-10-21 13:10',"The Shiny","345 Bloody Mary Way,Gretna, NE, 68190, USA","4A",20.00);
INSERT INTO Products (productCode,subType,cost) VALUES ("90fa","P",50.00); 	-- Product 4

-- Creation of actual products associated with Invoices --
-- Invoice 1 --
INSERT INTO Products (productCode, subType,productName, startDate, endDate,cost) SELECT
productCode, subType,productName, startDate, endDate,cost FROM Products WHERE productsID=1;
UPDATE Products SET invoiceID=1,units=10 WHERE productsID=5;

INSERT INTO Products (productCode,subType,cost) SELECT productCode,subType,cost FROM Products WHERE productsID=4;
UPDATE Products SET invoiceID=1,units=12,attachedProduct="fp12" WHERE productsID=6;

-- Invoice 2 -- 
INSERT INTO Products (productCode, subType, productName,cost) SELECT productCode,subType,productName,cost FROM
Products WHERE productsID=2;
UPDATE Products SET invoiceID=2,units=50 WHERE productsID=7;

INSERT INTO Products (productCode,subType,cost) SELECT productCode,subType,cost FROM Products WHERE productsID=4;
UPDATE Products SET invoiceID=2,units=30 WHERE productsID=8;

-- Invoice 3 --
INSERT INTO Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) SELECT
productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost FROM Products WHERE productsID=3;
UPDATE Products SET invoiceID=3,units=3 WHERE productsID=9;

INSERT INTO Products (productCode, subType, productName,cost) SELECT productCode,subType,productName,cost FROM
Products WHERE productsID=2;
UPDATE Products SET invoiceID=3,units=4 WHERE productsID=10;

INSERT INTO Products (productCode,subType,cost) SELECT productCode,subType,cost FROM Products WHERE productsID=4;
UPDATE Products SET invoiceID=3,units=2,attachedProduct="fp12" WHERE productsID=11;

-- Invoice 4 --
INSERT INTO Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) SELECT
productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost FROM Products WHERE productsID=3;
UPDATE Products SET invoiceID=4,units=5 WHERE productsID=12;

INSERT INTO Products (productCode, subType, productName,cost) SELECT productCode,subType,productName,cost FROM
Products WHERE productsID=2;
UPDATE Products SET invoiceID=4,units=7 WHERE productsID=13;

-- Invoice 5 --
INSERT INTO Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) SELECT
productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost FROM Products WHERE productsID=3;
UPDATE Products SET invoiceID=5,units=5 WHERE productsID=14;

INSERT INTO Products (productCode, subType, productName,cost) SELECT productCode,subType,productName,cost FROM
Products WHERE productsID=2;
UPDATE Products SET invoiceID=5,units=7 WHERE productsID=15;

INSERT INTO Products (productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost) SELECT
productCode,subType,movieDateTime, productName,movieAddress,movieScreenNo,cost FROM Products WHERE productsID=3;
UPDATE Products SET invoiceID=5,units=5 WHERE productsID=16;
