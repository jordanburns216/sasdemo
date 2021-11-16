libname readmit XLSX "C:\Users\joburn\Documents\SMBU\Data\readmissions_working.xlsx";

proc sql;
create table readmit.readmissions as select * from readmit.sheet1;
run;

proc contents data=readmit.readmissions;
run;

proc freq data=readmit.readmissions;
table 'dv readmit flag'n;
run;


title "Readmissions by Gender";
proc sgplot data=readmit.readmissions pctlevel=group;
vbar 'dv readmit flag'n / group='Patient Gender'n;
run;

/*proc sort data=readmit.readmissions out=train_sorted;
by 'dv readmit flag'n;
run;
proc surveyselect data=train_sorted out=train_survey outall
samprate= 0.7 seed=2021;
strata 'dv readmit flag'n;
run;

proc freq data=train_survey;
tables Selected*'dv readmit flag'n;
run;*/

proc logistic data=readmit.readmissions;
class 'Patient Gender'n 'Urban Class'n 'Repeat Care Gap Offenders'n;
model 'dv readmit flag'n (event='1')= 'Length of Stay'n 'Prior IP Admits'n 'Chronic Conditions Number'n 'Patient Age'n 'Patient Gender'n 'Urban Class'n 'Repeat Care Gap Offenders'n 'bmi'n/
selection = stepwise expb stb lackfit;
output out=m3 p=prob xbeta=logit;
run;

 