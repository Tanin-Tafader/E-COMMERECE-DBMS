import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class Main_tester {
    public static void createTables(Connection conn1) throws SQLException {
        // Strings used to create each table in sql
        String createUserAccounts = "CREATE TABLE UserAccounts(" + "UserID NUMBER(5) NOT NULL," + "Username VARCHAR2(25) NOT NULL,"
        + "Pwd VARCHAR2(25) NOT NULL," + "CheckAdmin NUMBER(1) DEFAULT 0," + "CONSTRAINT check_CheckAdmin CHECK (CheckAdmin = 0 or CheckAdmin = 1)," +
        "PRIMARY KEY (UserID))";
        String createCustomers = "CREATE TABLE Customers(" + "FirstName VARCHAR2(25) NOT NULL," + "LastName VARCHAR2(25) NOT NULL," + "EmailAddress VARCHAR2(75) NOT NULL," + "UserID NUMBER NOT NULL," + "UNIQUE(FirstName)," + "UNIQUE(LastName)," + "CONSTRAINT fk_UserID_customers FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE)";
        String createVendor = "CREATE TABLE Vendor(" + "VendorID NUMBER(3) CHECK (VendorID BETWEEN 1 and 999) NOT NULL," + "Supplier VARCHAR2(50) NOT NULL," + "LocationSupply VARCHAR2(50) NOT NULL," + "UNIQUE (Supplier)," + "PRIMARY KEY (VendorID))";
        String createProduct = "CREATE TABLE Product(" + "ProductID NUMBER(5) CHECK (ProductID BETWEEN 10000 and 11000) NOT NULL," + "VendorID NUMBER(3) NOT NULL," + "Supplier VARCHAR2(50) NOT NULL," + "ProductType VARCHAR2(25) NOT NULL," + "Stock NUMBER(3) Default 0," + "DateOfAddition VARCHAR2(10) NOT NULL," + "Price DECIMAL(10,2) NOT NULL," + "Picture NUMBER(1) Default 0," + "UNIQUE(Price)," + "CONSTRAINT fk_VendorID_product FOREIGN KEY (VendorID) REFERENCES Vendor(VendorID) ON DELETE CASCADE," + "CONSTRAINT fk_Supplier_product FOREIGN KEY (Supplier) REFERENCES Vendor(Supplier) ON DELETE CASCADE," + "CONSTRAINT check_Picture CHECK (Picture = 0 or Picture = 1)," + "CONSTRAINT check_ProductType CHECK (ProductType = 'Apparel' or ProductType = 'Electronics')," + "PRIMARY KEY (ProductID))";
        String createReviews = "CREATE TABLE Reviews(" + "Rating NUMBER(2) CHECK (Rating BETWEEN 1 and 10)," + "WrittenReview VARCHAR2(100) DEFAULT ''," + "DateOfReview VARCHAR2(10) DEFAULT ''," + "ReviewerName VARCHAR2(20) DEFAULT ''," + "ProductID NUMBER NOT NULL," + "CONSTRAINT fk_ProductID_reviews FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE)";
        String createOrders = "CREATE TABLE Orders(" + "OrderID NUMBER(5) CHECK (OrderID BETWEEN 20000 and 21000)," + "UnitsOrdered NUMBER(2) Default 0," + "TotalPrice DECIMAL(10,2) Default 0," + "UserID NUMBER NOT NULL," + "Unique(OrderID)," + "CONSTRAINT fk_UserID_orders FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE)";
        String createShoppingCart = "CREATE TABLE ShoppingCart(" + "CartQuantity NUMBER(3) DEFAULT 0," + "Total NUMBER NOT NULL," + "Price DECIMAL(10,2) NOT NULL," + "ProductID NUMBER NOT NULL," + "UserID NUMBER NOT NULL," + "CONSTRAINT fk_Price_cart FOREIGN KEY (Price) REFERENCES Product(Price) ON DELETE CASCADE," + "CONSTRAINT fk_ProductID_cart FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE," + "CONSTRAINT fk_UserID_cart FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE)";
        String createPaymentCard = "CREATE TABLE PaymentCard(" + "CardNum NUMBER(16) NOT NULL," + "FirstName VARCHAR2(25) REFERENCES Customers(FirstName) ON DELETE CASCADE," + "LastName VARCHAR2(25) REFERENCES Customers(LastName) ON DELETE CASCADE," + "Pin NUMBER CHECK (pin BETWEEN 000 and 999)," + "ExpirationDate VARCHAR2(10) NOT NULL," + "Unique(CardNum))";
        String createPaymentInformation = "CREATE TABLE PaymentInformation(" + "StreetNumber NUMBER(3) NOT NULL," + "Street VARCHAR2(50) NOT NULL," + "PostalCode VARCHAR2(7) NOT NULL," + "City VARCHAR2(50) NOT NULL," + "UserId NUMBER NOT NULL," + "CardNum NUMBER(16) NOT NULL," + "CONSTRAINT fk_UserID_paymentinfo FOREIGN KEY (UserID) REFERENCES UserAccounts(UserID) ON DELETE CASCADE," + "CONSTRAINT fk_CardNum_paymentinfo FOREIGN KEY (CardNum) REFERENCES PaymentCard(CardNum) ON DELETE CASCADE)";
        // Execute each create table statement
        Statement state = conn1.createStatement();
        state.execute(createUserAccounts);
        state.execute(createCustomers);
        state.execute(createVendor);
        state.execute(createProduct);
        state.execute(createReviews);
        state.execute(createOrders);
        state.execute(createShoppingCart);
        state.execute(createPaymentCard);
        state.execute(createPaymentInformation);
        System.out.println("Successfully created all tables.\n");
    }

    public static void populateTables(Connection conn1) throws SQLException {
        // Strings used to create each INSERT statement in sql
        String vendor1 = "insert into Vendor values(1, 'Orange Company', 'Vancouver')";
        String vendor2 =  "insert into Vendor values(2, 'Jackson Company', 'Montreal')";
        String vendor3 = "insert into Vendor values(3, 'Jones Company', 'Calgary')";
        String vendor4 = "insert into Vendor values(4, 'Magic Company', 'Toronto')";
        String vendor5 = "insert into Vendor values(5, 'Co Company', 'Winnipeg')";
        String prod1 = "insert into Product values(10001, 1, 'Orange Company', 'Apparel', 5, '2022-01-23', 50, 0)";
        String prod2 = "insert into Product values(10004, 4, 'Magic Company', 'Electronics', 3, '2021-02-10', 21, 1)";
        String prod3 = "insert into Product values(10006, 1, 'Orange Company', 'Electronics', 3, '2021-05-05', 20.25, 1)";
        String prod4 = "insert into Product values(10145, 3, 'Jones Company', 'Apparel', 1, '2020-06-15', 125, 1)";
        String prod5 = "insert into Product values(10422, 5, 'Co Company', 'Electronics', 3, '2021-11-03', 1100, 1)";
        String prod6 = "insert into Product values(10352, 1, 'Orange Company', 'Electronics', 3, '2021-12-03', 50.25, 1)";
        String prod7 = "insert into Product values(10722, 2, 'Jackson Company', 'Apparel', 1, '2022-03-03', 29.99, 1)";
        String rev1 = "insert into Reviews values(10, 'this product is 10/10', '2022-09-20', 'reviewerguy1', 10004)";
        String rev2 = "insert into Reviews values(2, 'this product is bad', '2022-03-14', 'reviewerguy294', 10001)";
        String rev3 = "insert into Reviews values(7, 'this product is good', '2021-08-25', 'reviewergirl392', 10006)";
        String rev4 = "insert into Reviews values(5, 'this product is 10/10', '2022-09-20', 'reviewergirl748', 10422)";
        String cus1_a = "insert into UserAccounts values(1000,'jacksmith123','fakepassword', 0)";
        String cus1_b = "insert into Customers values('Jack','Smith','jacksmith@fakeemail.com', 1000)";
        String cus1_c = "insert into ShoppingCart values(2, 0, 50, 10001, 1000)";
        String cus1_d = "insert into Orders values(20194, 2, 100, 1000)";
        String cus1_e = "insert into Orders values(20195, 1, 125, 1000)";
        String cus1_f = "insert into PaymentCard values(4125839485838485, 'Jack', 'Smith', 444, '2025-06-25')";
        String cus1_g = "insert into PaymentInformation values(475, 'Queen St.', 'M8J 5I7', 'Montreal', 1000, 4125839485838485)";
        String cus2_a = "insert into UserAccounts values(1062, 'johnjohnson', 'password2', 0)";
        String cus2_b = "insert into Customers values('John','Johnson','johnjohnson@fakeemail.com', 1062)";
        String cus2_c = "insert into ShoppingCart values(2, 0, 21, 10004, 1062)";
        String cus2_d = "insert into Orders values(20423, 1, 80, 1062)";
        String cus2_e = "insert into Orders values(20293, 2, 40, 1062)";
        String cus2_f = "insert into PaymentCard values(7888988899543553, 'John', 'Johnson', 523, '2026-01-24')";
        String cus2_g = "insert into PaymentInformation values(325, 'Fake St.', 'M43 5K7', 'Vancouver', 1062, 7888988899543553)";
        String cus3_a = "insert into UserAccounts values(40593,'mariajordan','fakefakepass', 0)";
        String cus3_b = "insert into Customers values('Maria','Jordan','mariajordan@fakeemail.com', 40593)";
        String cus3_c = "insert into ShoppingCart values(1, 0, 1100, 10422, 40593)";
        String cus3_d = "insert into Orders values(20002, 1, 1100, 40593)";
        String cus3_e = "insert into PaymentCard values(1948583295295551, 'Maria', 'Jordan', 159, '2026-02-20')";
        String cus3_f = "insert into PaymentInformation values(204, 'Fake St.', 'J3J 4I8', 'Ottawa', 40593, 1948583295295551)";
        String cus4_a = "insert into UserAccounts values(39583,'janiceking','passpass22', 0)";
        String cus4_b = "insert into Customers values('Janice','King','janiceking@fakeemail.com', 39583)";
        String cus4_c = "insert into ShoppingCart values(1, 0, 125, 10145, 39583)";
        String cus4_d = "insert into Orders values(20382, 1, 125, 39583)";
        String cus4_e = "insert into PaymentCard values(1848539943441431, 'Janice', 'King', 423, '2022-10-14')";
        String cus4_f = "insert into PaymentInformation values(10, 'Faker Avenue', 'L7L 7K8', 'Montreal', 39583, 1848539943441431)";
        
        String[] populate_vendors = {vendor1, vendor2, vendor3, vendor4, vendor5};
        String[] populate_products = {prod1, prod2, prod3, prod4, prod5, prod6, prod7};
        String[] populate_rev = {rev1, rev2, rev3, rev4};
        String[] populate_cus1 = {cus1_a, cus1_b, cus1_c, cus1_d, cus1_e, cus1_f, cus1_g};
        String[] populate_cus2  = {cus2_a, cus2_b, cus2_c, cus2_d, cus2_e, cus2_f, cus2_g};
        String[] populate_cus3 = {cus3_a, cus3_b, cus3_c, cus3_d, cus3_e, cus3_f};
        String[] populate_cus4 = {cus4_a, cus4_b, cus4_c, cus4_d, cus4_e, cus4_f};
        String[][] combined = {populate_vendors, populate_products, populate_rev, populate_cus1, populate_cus2, populate_cus3, populate_cus4};
        Statement state = conn1.createStatement();
        for (int i = 0; i < combined.length; i++) {
            for (int k = 0; k < combined[i].length; k++) {
                state.execute(combined[i][k]);
            }
        }
        System.out.println("Successfully populated all tables.\n");

    }

    public static void dropTables(Connection conn1) throws SQLException {
        // Strings used for dropping tables in sql
        String dropUserAccounts = "DROP TABLE UserAccounts CASCADE CONSTRAINTS";
        String dropCustomers = "DROP TABLE Customers CASCADE CONSTRAINTS";
        String dropVendor = "DROP TABLE Vendor CASCADE CONSTRAINTS";
        String dropProduct = "DROP TABLE Product CASCADE CONSTRAINTS";
        String dropReviews = "DROP TABLE Reviews CASCADE CONSTRAINTS";
        String dropOrders = "DROP TABLE Orders CASCADE CONSTRAINTS";
        String dropShoppingCart = "DROP TABLE ShoppingCart CASCADE CONSTRAINTS";
        String dropPaymentCard = "DROP TABLE PaymentCard CASCADE CONSTRAINTS";
        String dropPaymentInformation = "DROP TABLE PaymentInformation CASCADE CONSTRAINTS";

        // Execute each drop table statement using array of strings above
        String[] dropTablesAll = {dropReviews, dropOrders, dropPaymentInformation, dropPaymentCard, dropShoppingCart, dropProduct, dropVendor, dropCustomers, dropUserAccounts};
        Statement state = conn1.createStatement();
        for (int i=0; i < dropTablesAll.length; i++) {
            state.execute(dropTablesAll[i]);
        }
        System.out.println("Successfully dropped all tables.\n");
    }

    public static void queryTables(Connection conn1) throws SQLException { 
        // List lowest to highest price of products
        String query_1 = "SELECT ProductID, Price , DateOfAddition FROM Product ORDER BY Price ASC";
        // List all UserAccounts with UserID > 2500 and Username in ascending order
        String query_2 = "SELECT UserID, Username, Pwd FROM UserAccounts WHERE UserID > 2500 ORDER BY Username ASC";
        // List all payment card holders who also have payment information
        String query_3 = "SELECT FirstName, LastName, ExpirationDate FROM PaymentCard INNER JOIN PaymentInformation ON PaymentCard.CardNum = PaymentInformation.CardNum ORDER BY FirstName ASC";
        // List Customers by firstname in ascending order
        String query_4 = "SELECT * From Customers ORDER BY firstname ASC";

        Statement state = conn1.createStatement();

        ResultSet result = state.executeQuery(query_1);
        System.out.println("\nShowing all the product prices from lowest to highest");
        while (result.next()) {
            // First query
            int ProductID = result.getInt("ProductID");
            int Price = result.getInt("Price");
            String DateOfAddition = result.getString("DateOfAddition");
            System.out.println("Product ID = " + ProductID + " | Price = " + Price + " | Date Added = " + DateOfAddition);
        }

        result = state.executeQuery(query_2);
        System.out.println("\nList all UserAccounts with UserID > 2500 and Username, Password in ascending order");
        while (result.next()){
            // Second query
            int UserID = result.getInt("UserID");
            String Username = result.getString("Username");
            String Password = result.getString("Pwd");
            System.out.println("User ID = " + UserID + " | Username = " + Username + " | Password = " + Password);
        }

        result = state.executeQuery(query_3);
        System.out.println("\nList all payment card holders who also have payment information");
        while (result.next()){
            // Third query
            String FirstName = result.getString("FirstName");
            String LastName = result.getString("LastName");
            String Expiration = result.getString("ExpirationDate");
            System.out.println("First name = " + FirstName + " | Last name = " + LastName + " | Card expiration date = " + Expiration);
        }
        
        result = state.executeQuery(query_4);
        System.out.println("\nList Customers by firstname in ascending order");
        while (result.next()){
            // Fourth query
            String FirstName = result.getString("FirstName");
            String LastName = result.getString("LastName");
            String Email = result.getString("EmailAddress");
            int UserID = result.getInt("UserID");
            System.out.println("First name = " + FirstName + " | Last name = " + LastName + " | Email address = " + Email + " | User ID = " + UserID);
        }
        System.out.println("Successfully queried all tables.\n");
    }
}