
libname adam "C:\review\adam\datasets";
proc contents data=adam._all_ out=out1 noprint;

data out1; set out1;
keep memname memlabel name label format informat length; 

proc print data=out1(keep=memname memlabel name label format informat length);
run;

proc sql;
select distinct format from out1;
select distinct informat from out1; 

proc print data=out1;
where anypunct(label)>0 and index(label,"/")=0 and index(label, "-")=0; 

proc print data=out1;
where anypunct(memlabel)>0 and index(label,"/")=0 and index(label, "-")=0;
run;





