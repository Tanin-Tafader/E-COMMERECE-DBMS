#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "user/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
SELECT COUNT(DISTINCT CardNum), ExpirationDate
FROM PaymentCard
WHERE ExpirationDate > '2025-01-01'
GROUP BY ExpirationDate
ORDER BY ExpirationDate DESC;

SELECT UserID, CardNum, City
FROM PaymentInformation
WHERE City = 'Montreal'
ORDER BY UserID ASC;

SELECT Rating, DateOfReview, ReviewerName
FROM Reviews
WHERE Rating >= 7
ORDER BY DateOfReview ASC, ReviewerName ASC;

SELECT UserID, COUNT(UnitsOrdered)
FROM ORDERS
GROUP BY UserID
ORDER BY UserID ASC;

SELECT ProductID,Price , DateOfAddition
FROM Product
ORDER BY Price ASC; 

SELECT *
From ShoppingCart
WHERE CartQuantity > 1
ORDER BY CartQuantity DESC, userid ASC;   

SELECT *
From Customers
ORDER BY firstname ASC;

SELECT VendorID, Supplier, LocationSupply
FROM Vendor
ORDER BY Supplier ASC;

SELECT UserID, Username, Pwd
FROM UserAccounts
WHERE UserID > 2500
ORDER BY Username ASC;


--advanced queries
SELECT Product.ProductID, Product.Price
FROM Product, Reviews
WHERE Product.ProductID = Reviews.ProductID;

SELECT Product.Supplier, ProductType, Stock, Price
FROM Product
INNER JOIN Reviews on Product.ProductID = Reviews.ProductID
INNER JOIN Vendor on Product.VendorID = Vendor.VendorID
ORDER BY Supplier ASC;

SELECT FirstName, LastName, ExpirationDate
FROM PaymentCard
INNER JOIN PaymentInformation ON PaymentCard.CardNum = PaymentInformation.CardNum   --join condition
ORDER BY FirstName ASC;

SELECT UserID
FROM Product p, Reviews r, ShoppingCart s
WHERE s.ProductID = p.ProductID AND p.ProductID = r.ProductID   --join condition
ORDER BY UserID ASC;

SELECT Rating, r.ProductID
FROM Reviews r
WHERE EXISTS
(SELECT s.ProductID
 FROM ShoppingCart s
 WHERE s.ProductID = r.ProductID);

SELECT ProductID, ProductType
FROM Product
MINUS
(SELECT p.ProductID, p.ProductType
 FROM Product p, Reviews r
 WHERE p.ProductID = r.ProductID);

SELECT o.UserID
FROM Orders o
WHERE EXISTS
(SELECT c.UserID
 FROM Customers c
 WHERE o.UserID = c.UserID)
UNION
 (SELECT o.UserID
  FROM Orders o
  WHERE EXISTS
   (SELECT s.UserID
    FROM ShoppingCart s
    WHERE o.UserID = s.UserID));
exit;
EOF
