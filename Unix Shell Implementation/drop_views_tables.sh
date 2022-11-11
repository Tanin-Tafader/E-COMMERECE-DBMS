#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "user/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))" <<EOF
DROP VIEW cheap_products CASCADE CONSTRAINTS;
DROP VIEW highest_rated_products CASCADE CONSTRAINTS;
DROP VIEW accounts_greater_10000 CASCADE CONSTRAINTS;
