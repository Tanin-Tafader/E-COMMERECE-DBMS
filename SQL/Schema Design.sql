/*
E-Commerce System
Tanin Tafader
*/


CREATE TABLE UserAccounts(
    UserID NUMBER(5) NOT NULL,
    Username VARCHAR2(25) NOT NULL,
    Pwd VARCHAR2(25) NOT NULL,
    CheckAdmin NUMBER(1) DEFAULT 0,
    CONSTRAINT check_CheckAdmin CHECK (CheckAdmin = 0 or CheckAdmin = 1),
    PRIMARY KEY (UserID)
    );

CREATE TABLE Customers(
    FirstName VARCHAR2(25) NOT NULL,
    LastName VARCHAR2(25) NOT NULL,
    EmailAddress VARCHAR2(75) NOT NULL,
    UserID NUMBER NOT NULL,
    UNIQUE(FirstName),
    UNIQUE(LastName),
    CONSTRAINT fk_UserID_customers FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE
    );

CREATE TABLE Vendor(
    VendorID NUMBER(3) CHECK (VendorID BETWEEN 1 and 999) NOT NULL,
    Supplier VARCHAR2(50) NOT NULL,
    LocationSupply VARCHAR2(50) NOT NULL,
    UNIQUE (Supplier),
    PRIMARY KEY (VendorID)
);

CREATE TABLE Product(
    ProductID NUMBER(5) CHECK (ProductID BETWEEN 10000 and 11000) NOT NULL,
    VendorID NUMBER(3) NOT NULL,
    Supplier VARCHAR2(50) NOT NULL,
    ProductType VARCHAR2(25) NOT NULL,
    Stock NUMBER(3) Default 0,
    DateOfAddition VARCHAR2(10) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Picture NUMBER(1) Default 0,
    UNIQUE(Price),
    CONSTRAINT fk_VendorID_product FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID) ON DELETE CASCADE,
    CONSTRAINT fk_Supplier_product FOREIGN KEY (Supplier) REFERENCES Vendor(Supplier) ON DELETE CASCADE,
    CONSTRAINT check_Picture CHECK (Picture = 0 or Picture = 1),
    CONSTRAINT check_ProductType CHECK (ProductType = 'Apparel' or ProductType = 'Electronics'),
    PRIMARY KEY (ProductID)
);

CREATE TABLE Reviews(
    Rating NUMBER(2) CHECK (Rating BETWEEN 1 and 10),
    WrittenReview VARCHAR2(100) DEFAULT '',
    DateOfReview VARCHAR2(10) DEFAULT '',
    ReviewerName VARCHAR2(20) DEFAULT '',
    ProductID NUMBER NOT NULL,
    CONSTRAINT fk_ProductID_reviews FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
);

CREATE TABLE Orders(
    OrderID NUMBER(5) CHECK (OrderID BETWEEN 20000 and 21000),
    UnitsOrdered NUMBER(2) Default 0,
    TotalPrice DECIMAL(10,2) Default 0,
    UserID NUMBER NOT NULL,
    Unique(OrderID),
    CONSTRAINT fk_UserID_orders FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE
);

CREATE TABLE ShoppingCart(
    CartQuantity NUMBER(3) DEFAULT 0,
    Total NUMBER NOT NULL, 
    Price DECIMAL(10,2) NOT NULL,
    ProductID NUMBER NOT NULL, 
    UserID NUMBER NOT NULL,
    CONSTRAINT fk_Price_cart FOREIGN KEY (Price) REFERENCES Product(Price) ON DELETE CASCADE,
    CONSTRAINT fk_ProductID_cart FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
    CONSTRAINT fk_UserID_cart FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE
);

CREATE TABLE PaymentCard(
    CardNum NUMBER(16) NOT NULL,
    FirstName VARCHAR2(25) REFERENCES Customers(FirstName) ON DELETE CASCADE,
    LastName VARCHAR2(25) REFERENCES Customers(LastName) ON DELETE CASCADE,
    Pin NUMBER CHECK (pin BETWEEN 000 and 999),
    ExpirationDate VARCHAR2(10) NOT NULL,
    Unique(CardNum)
);

CREATE TABLE PaymentInformation(
    StreetNumber NUMBER(3) NOT NULL, 
    Street VARCHAR2(50) NOT NULL,
    PostalCode VARCHAR2(7) NOT NULL,
    City VARCHAR2(50) NOT NULL,
    UserId NUMBER NOT NULL,
    CardNum NUMBER(16) NOT NULL,
    CONSTRAINT fk_UserID_paymentinfo FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE,
    CONSTRAINT fk_CardNum_paymentinfo FOREIGN KEY (CardNum) REFERENCES PaymentCard(CardNum) ON DELETE CASCADE
);


--Insert Vendors
insert into Vendor values(1, 'Orange Company', 'Vancouver');
insert into Vendor values(2, 'Jackson Company', 'Montreal');
insert into Vendor values(3, 'Jones Company', 'Calgary');
insert into Vendor values(4, 'Magic Company', 'Toronto');
insert into Vendor values(5, 'Co Company', 'Winnipeg');

--Insert Products
insert into Product values(10001, 1, 'Orange Company', 'Apparel', 5, '2022-01-23', 50, 0);
insert into Product values(10004, 4, 'Magic Company', 'Electronics', 3, '2021-02-10', 21, 1);
insert into Product values(10006, 1, 'Orange Company', 'Electronics', 3, '2021-05-05', 20.25, 1);
insert into Product values(10145, 3, 'Jones Company', 'Apparel', 1, '2020-06-15', 125, 1);
insert into Product values(10422, 5, 'Co Company', 'Electronics', 3, '2021-11-03', 1100, 1);
insert into Product values(10352, 1, 'Orange Company', 'Electronics', 3, '2021-12-03', 50.25, 1);
insert into Product values(10722, 2, 'Jackson Company', 'Apparel', 1, '2022-03-03', 29.99, 1);

--Insert Reviews for products
insert into Reviews values(10, 'this product is 10/10', '2022-09-20', 'reviewerguy1', 10004);
insert into Reviews values(2, 'this product is bad', '2022-03-14', 'reviewerguy294', 10001);
insert into Reviews values(7, 'this product is good', '2021-08-25', 'reviewergirl392', 10006);
insert into Reviews values(5, 'this product is 10/10', '2022-09-20', 'reviewergirl748', 10422);


--Customer 1
insert into UserAccounts values(1000,'jacksmith123','fakepassword', 0);
insert into Customers values('Jack','Smith','jacksmith@fakeemail.com', 1000);
insert into ShoppingCart values(2, 0, 50, 10001, 1000);
insert into Orders values(20194, 2, 100, 1000);
insert into Orders values(20195, 1, 125, 1000);
insert into PaymentCard values(4125839485838485, 'Jack', 'Smith', 444, '2025-06-25');
insert into PaymentInformation values(475, 'Queen St.', 'M8J 5I7', 'Montreal', 1000, 4125839485838485);

--Customer 2
insert into UserAccounts values(1062, 'johnjohnson', 'password2', 0);
insert into Customers values('John','Johnson','johnjohnson@fakeemail.com', 1062);
insert into ShoppingCart values(2, 0, 21, 10004, 1062);
insert into Orders values(20423, 1, 80, 1062);
insert into Orders values(20293, 2, 40, 1062);
insert into PaymentCard values(7888988899543553, 'John', 'Johnson', 523, '2026-01-24');
insert into PaymentInformation values(325, 'Fake St.', 'M43 5K7', 'Vancouver', 1062, 7888988899543553);

--Customer 3
insert into UserAccounts values(40593,'mariajordan','fakefakepass', 0);
insert into Customers values('Maria','Jordan','mariajordan@fakeemail.com', 40593);
insert into ShoppingCart values(1, 0, 1100, 10422, 40593);
insert into Orders values(20002, 1, 1100, 40593);
insert into PaymentCard values(1948583295295551, 'Maria', 'Jordan', 159, '2026-02-20');
insert into PaymentInformation values(204, 'Fake St.', 'J3J 4I8', 'Ottawa', 40593, 1948583295295551);

--Customer 4
insert into UserAccounts values(39583,'janiceking','passpass22', 0);
insert into Customers values('Janice','King','janiceking@fakeemail.com', 39583);
insert into ShoppingCart values(1, 0, 125, 10145, 39583);
insert into Orders values(20382, 1, 125, 39583);
insert into PaymentCard values(1848539943441431, 'Janice', 'King', 423, '2022-10-14');
insert into PaymentInformation values(10, 'Faker Avenue', 'L7L 7K8', 'Montreal', 39583, 1848539943441431);


/*
DROP TABLE Reviews;
DROP TABLE Orders;
DROP TABLE PaymentInformation;
DROP TABLE PaymentCard;
DROP TABLE ShoppingCart;
DROP TABLE Product CASCADE CONSTRAINTS;
DROP TABLE Vendor;
DROP TABLE Administrator;
DROP TABLE Customers CASCADE CONSTRAINTS;
DROP TABLE UserAccounts CASCADE CONSTRAINTS;
*/