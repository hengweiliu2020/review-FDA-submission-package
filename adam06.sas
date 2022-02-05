

libname adam "C:\review\adam\datasets";

ods output enginehost=eghost;
proc contents data=adam._all_; 
run;

data eghost; set eghost;
where label1='File Size';
unit=compress(cvalue1, '0123456789');
value=input(compress(cvalue1, 'GMKB '), best.);
run;

proc print data=eghost; 
run;

proc print data=eghost; 
where unit='GB' and value>5; 

proc print data=eghost;
where unit='MB' and value>5000; 
run;

proc print data=eghost;
where unit='KB' and value>5000000; 
run;








