
libname sdtm "C:\review\sdtm";
proc contents data=sdtm._all_ out=out1 noprint;


proc sort data=out1;
by memname varnum name;
run;

proc print data=out1(keep=memname varnum name label);
id memname;
by memname;
run;

