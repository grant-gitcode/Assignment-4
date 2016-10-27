-- 1. A query to retrieve the major fields for every person.

select * from Person;

-- 2. A query to add an email to a specific person. 
insert into Person (personId, emailAddress)
values ('2', 'shane.ps360@gmail.com');
-- 3. A query to change the address of a theater in a movie ticket record. 

set sql_safe_updates = 0;
update Products as sub set sub.movieAddress="123 Change St." where sub.subType="M";

-- 4. A query (or series of queries) to remove a given movie ticket record. 
Delete from Products where sub.movieAddress = "123Change St." AND sub.subType = "M";

-- 5. A query to get all the products in a particular invoice. 

select * from Products as p where p.invoiceID = 1;

-- as sub (blah) sub

-- 6. A query to get all the invoices of a particular customer. 
select * from Invoice as i where i.customerID = 1;
-- 7. A query that “adds” a particular product to a particular invoice. 

insert into Products(productName,cost,units) values ("New Product",100.00,35);

-- 8. A query to find the total of all per-unit costs of all movie-tickets. 
SELECT P.subType SUM(P.cost) AS TotalCost
WHERE P.subType="M";
-- 9. A query to find the total number of movie-tickets sold on a particular date. 

SELECT I.date, SUM(P.units) AS ticketCount
FROM Products AS P JOIN Invoice AS I 
ON P.invoiceID = I.invoiceID 
WHERE I.date='2016-10-16' AND P.subType="M";

-- 10. A query to find the total number of invoices for every salesperson. 
SELECT P.personID, SUM(I.invoiceID) AS TotalInvoice
FROM Invoice AS I JOIN Person AS P 
ON P.invoiceID = I.invoiceID 
-- 11. A query to find the total number of invoices for a particular movie ticket.

SELECT P.productName, COUNT(I.invoiceID) AS invoiceCount 
FROM Invoice AS I JOIN Products AS P
ON P.invoiceID = I.invoiceID
WHERE P.productName="The Shiny";
 
/* 12. A query to find the total revenue generated (excluding fees and taxes) on a particular date from 
all movie-tickets (hint: you can take an aggregate of a mathematical expression). 
*/
Select P.subType, SUM(P.units * P.cost) As totalRevenue
From Products As P JOIN Invoice AS I
ON P.invoiceID = I.invoiceID
WHERE I.date='2016-10-16' AND P.subType = "M";
/*13. A query to find the total quantities sold (excluding fees and taxes) of each category of services 
(parking-passes and refreshments) in all the existing invoices. 
*/

SELECT P.subType, SUM(P.units * P.cost) AS totalSold 
FROM Products AS P JOIN Invoice AS I 
ON P.invoiceID = I.invoiceID
WHERE P.subType="P" OR P.subType="R"
GROUP BY P.subType;

/*14. A query to detect invalid data in invoices as follows.  In a single invoice, a particular ticket 
should only appear once (since any number of units can be consolidated to a single record).  Write a 
query to find any invoice that includes multiple instances of the same ticket. 
*/
SELECT I.invoiceCode, P.subType
FROM Invoice AS I JOIN Product AS P 
ON I.productsID = P.productsID
WHERE P.subType = "P"
Group BY invoiceID, productsID 
Having Count (Product.productID) > 1;
/* 15. Write a query to detect a possible conflict of interest as follows.  No distinction is made in this 
system between a person who is the primary contact of a customer and a person who is also a sales person.  
Write a query to find any and all invoices where the salesperson is the same as the primary contact of the 
invoice’s customer.  */

SELECT I.invoiceCode, I.personID,C.personID 
FROM Invoice AS I JOIN Customer AS C 
ON I.customerID = C.customerID
WHERE I.personID = C.personID;

-- Should NOT show the 5th invoice, since nearly all my data is filled with conflicts of interests! --
