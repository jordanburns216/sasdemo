filename project 'C:\Users\joburn\Documents\SMBU\Data\insurance.csv';

proc import file=project out=P1 dbms=csv;

run;

libname odbclib odbc dsn=SASPostgre uid=postgres pwd=Soccer216!; 

data odbclib.insurance;
set work.p1;
run;

proc print data=odbclib.insurance;
run;

/* Exploring Data */
proc univariate data=ODBCLIB.INSURANCE;
	ods select Histogram;
	var charges;
	histogram charges;
run;