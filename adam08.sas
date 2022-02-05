
libname adam "C:\review\adam\datasets";
proc contents data=adam._all_ out=out1 noprint;


proc sort data=out1;
by memname varnum name;
run;

proc print data=out1(keep=memname varnum name label);
id memname;
by memname;
run;

