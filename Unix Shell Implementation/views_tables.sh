#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "user/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
CREATE VIEW cheap_products(cheap_productID, cheap_productType, cheap_stock, cheap_Price) AS
 (SELECT ProductID, ProductType, Stock, Price
 FROM Product
 WHERE Price < 30 AND Stock >= 1)
 WITH READ ONLY;

CREATE VIEW highest_rated_products(highReview_id, highReview_Rating, highReview_written) AS
 (SELECT ProductID, Rating, WrittenReview 
 FROM Reviews 
 WHERE Rating >= 7)
 WITH READ ONLY;

CREATE VIEW accounts_greater_10000(accounts10000_userID, accounts10000_username, accounts10000_pwd) AS
 (SELECT UserID, Username, Pwd
 FROM UserAccounts
 WHERE UserID > 10000);
exit;
EOF
