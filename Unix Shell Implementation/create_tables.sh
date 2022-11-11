#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "user/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
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
exit;
EOF
