/*
E-Commerce System
A4 - Simple Queries
Vincent Huynh
Tanin Tafader
Hitarthi Kothari
*/

--Count all payment cards where ExpirationDate is after Jan 1 2025, grouped by ExpirationDate in descending order
SELECT COUNT(DISTINCT CardNum), ExpirationDate
FROM PaymentCard
WHERE ExpirationDate > '2025-01-01'
GROUP BY ExpirationDate
ORDER BY ExpirationDate DESC;

--List all payment information from the city 'Montreal' ordered by UserID in ascending order
SELECT UserID, CardNum, City
FROM PaymentInformation
WHERE City = 'Montreal'
ORDER BY UserID ASC;

--List all reviews with a rating greater than 7 ordered by DateOfReview and ReviewerName
SELECT Rating, DateOfReview, ReviewerName
FROM Reviews
WHERE Rating >= 7
ORDER BY DateOfReview ASC, ReviewerName ASC;

--List the total amount of units ordered placed by a UserID grouped by UserID in ascending order
SELECT UserID, COUNT(UnitsOrdered)
FROM ORDERS
GROUP BY UserID
ORDER BY UserID ASC;

--List lowest to highest price of products
SELECT ProductID,Price , DateOfAddition
FROM Product
ORDER BY Price ASC;

--List ShoppingCart where CartQuantity is greater than 1 in descending order (priority) and UserID in ascending order
SELECT *
From ShoppingCart
WHERE CartQuantity > 1
ORDER BY CartQuantity DESC, userid ASC;    

--List Customers by firstname in ascending order
SELECT *
From Customers
ORDER BY firstname ASC;

--List all Suppliers in ascending order
SELECT VendorID, Supplier, LocationSupply
FROM Vendor
ORDER BY Supplier ASC;

--List all UserAccounts with UserID > 2500 and Username in ascending order 
SELECT UserID, Username, Pwd
FROM UserAccounts
WHERE UserID > 2500
ORDER BY Username ASC;



