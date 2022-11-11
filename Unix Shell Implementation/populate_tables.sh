#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "user/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
insert into Vendor values(1, 'Orange Company', 'Vancouver');
insert into Vendor values(2, 'Jackson Company', 'Montreal');
insert into Vendor values(3, 'Jones Company', 'Calgary');
insert into Vendor values(4, 'Magic Company', 'Toronto');
insert into Vendor values(5, 'Co Company', 'Winnipeg');
insert into Product values(10001, 1, 'Orange Company', 'Apparel', 5, '2022-01-23', 50, 0);
insert into Product values(10004, 4, 'Magic Company', 'Electronics', 3, '2021-02-10', 21, 1);
insert into Product values(10006, 1, 'Orange Company', 'Electronics', 3, '2021-05-05', 20.25, 1);
insert into Product values(10145, 3, 'Jones Company', 'Apparel', 1, '2020-06-15', 125, 1);
insert into Product values(10422, 5, 'Co Company', 'Electronics', 3, '2021-11-03', 1100, 1);
insert into Product values(10352, 1, 'Orange Company', 'Electronics', 3, '2021-12-03', 50.25, 1);
insert into Product values(10722, 2, 'Jackson Company', 'Apparel', 1, '2022-03-03', 29.99, 1);
insert into Reviews values(10, 'this product is 10/10', '2022-09-20', 'reviewerguy1', 10004);
insert into Reviews values(2, 'this product is bad', '2022-03-14', 'reviewerguy294', 10001);
insert into Reviews values(7, 'this product is good', '2021-08-25', 'reviewergirl392', 10006);
insert into Reviews values(5, 'this product is 10/10', '2022-09-20', 'reviewergirl748', 10422);
insert into UserAccounts values(1000,'jacksmith123','fakepassword', 0);
insert into Customers values('Jack','Smith','jacksmith@fakeemail.com', 1000);
insert into ShoppingCart values(2, 0, 50, 10001, 1000);
insert into Orders values(20194, 2, 100, 1000);
insert into Orders values(20195, 1, 125, 1000);
insert into PaymentCard values(4125839485838485, 'Jack', 'Smith', 444, '2025-06-25');
insert into PaymentInformation values(475, 'Queen St.', 'M8J 5I7', 'Montreal', 1000, 4125839485838485);
insert into UserAccounts values(1062, 'johnjohnson', 'password2', 0);
insert into Customers values('John','Johnson','johnjohnson@fakeemail.com', 1062);
insert into ShoppingCart values(2, 0, 21, 10004, 1062);
insert into Orders values(20423, 1, 80, 1062);
insert into Orders values(20293, 2, 40, 1062);
insert into PaymentCard values(7888988899543553, 'John', 'Johnson', 523, '2026-01-24');
insert into PaymentInformation values(325, 'Fake St.', 'M43 5K7', 'Vancouver', 1062, 7888988899543553);
insert into UserAccounts values(40593,'mariajordan','fakefakepass', 0);
insert into Customers values('Maria','Jordan','mariajordan@fakeemail.com', 40593);
insert into ShoppingCart values(1, 0, 1100, 10422, 40593);
insert into Orders values(20002, 1, 1100, 40593);
insert into PaymentCard values(1948583295295551, 'Maria', 'Jordan', 159, '2026-02-20');
insert into PaymentInformation values(204, 'Fake St.', 'J3J 4I8', 'Ottawa', 40593, 1948583295295551);
insert into UserAccounts values(39583,'janiceking','passpass22', 0);
insert into Customers values('Janice','King','janiceking@fakeemail.com', 39583);
insert into ShoppingCart values(1, 0, 125, 10145, 39583);
insert into Orders values(20382, 1, 125, 39583);
insert into PaymentCard values(1848539943441431, 'Janice', 'King', 423, '2022-10-14');
insert into PaymentInformation values(10, 'Faker Avenue', 'L7L 7K8', 'Montreal', 39583, 1848539943441431);
exit;
EOF
