/*
E-Commerce System
A4B - Views and Queries (Join)
Tanin Tafader
*/


--VIEWS
--Creating a read only virtual table that specifies only cheap instock items (<$30) including certain attributes from the 'Product' base table
CREATE VIEW cheap_products(cheap_productID, cheap_productType, cheap_stock, cheap_Price) AS
 (SELECT ProductID, ProductType, Stock, Price
 FROM Product
 WHERE Price < 30 AND Stock >= 1)
 WITH READ ONLY;
--Expect insert to fail with READ ONLY
--insert into cheap_products values(12000, 'Apparel', 5, 25);
--DROP VIEW cheap_products CASCADE CONSTRAINTS;


--Creating a read only virtual table that specifies high reviews only including certain attributes (product id, rating, written review) from the 'Reviews' base table
CREATE VIEW highest_rated_products(highReview_id, highReview_Rating, highReview_written) AS
 (SELECT ProductID, Rating, WrittenReview 
 FROM Reviews 
 WHERE Rating >= 7)
 WITH READ ONLY;
--DROP VIEW highest_rated_products CASCADE CONSTRAINTS;


--Creating a virtual table that specifies account id's > 10000 with only certain attributes visible from 'UserAccounts' base table
CREATE VIEW accounts_greater_10000(accounts10000_userID, accounts10000_username, accounts10000_pwd) AS
 (SELECT UserID, Username, Pwd
 FROM UserAccounts
 WHERE UserID > 10000);
--insert into accounts_greater_10000 values(14837, 'a4bUsername', 'a4Bpassword');
--delete from accounts_greater_10000 where accounts10000_userID = 14837;
--DROP VIEW accounts_greater_10000 CASCADE CONSTRAINTS;




--QUERIES (JOIN)
-- List all products (productID and price only) that have been reviewed
SELECT Product.ProductID, Product.Price
FROM Product, Reviews
WHERE Product.ProductID = Reviews.ProductID;
--Last condition specifies join condition


--List all Products provided by Vendors that have been reviewed ordered by Supplier ASC.
--3 table join
SELECT Product.Supplier, ProductType, Stock, Price
FROM Product
INNER JOIN Reviews on Product.ProductID = Reviews.ProductID
INNER JOIN Vendor on Product.VendorID = Vendor.VendorID
--INNER JOIN Reviews USING(ProductID)
--INNER JOIN Vendor USING(VendorID)
ORDER BY Supplier ASC;


--List all payment card holders who also have payment information
SELECT FirstName, LastName, ExpirationDate
FROM PaymentCard
INNER JOIN PaymentInformation ON PaymentCard.CardNum = PaymentInformation.CardNum
ORDER BY FirstName ASC;


--List all Users that have a shopping cart of products that have reviews on the products as well
--3 table join
SELECT UserID
FROM Product p, Reviews r, ShoppingCart s
WHERE s.ProductID = p.ProductID AND p.ProductID = r.ProductID
ORDER BY UserID ASC;


