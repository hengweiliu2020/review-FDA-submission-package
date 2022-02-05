proc import datafile="C:\review\adam_spec" out=adam_spec dbms=xlsx replace; sheet='Variables';
proc import datafile="C:\review\sdtm_spec" out=sdtm_spec dbms=xlsx replace; sheet='Variables';

proc sort data=adam_spec nodupkey; by variable label data_type;
proc sort data=sdtm_spec nodupkey; by variable label data_type;

data adam_spec; set adam_spec; 
rename label=label_adam data_type=type_adam dataset=data_adam;

data sdtm_spec; set sdtm_spec;
rename label=label_sdtm data_type=type_sdtm dataset=data_sdtm;


proc sort data=adam_spec(keep=variable label_adam type_adam data_adam);
by variable;

proc sort data=sdtm_spec(keep=variable label_sdtm type_sdtm data_sdtm);
by variable;


data compare;
merge adam_spec(in=a) sdtm_spec(in=b);
by variable;
if a and b;
run;

ods pdf file="C:\review\corss02.pdf"; 

proc print data=compare(drop=type_:);
where label_adam ne label_sdtm;
title "Same Variable with different label in ADaM and SDTM define "; 

proc print data=compare(drop=Label_:);
where type_adam ne type_sdtm; 
title "Same Variable with different type in ADaM and SDTM define "; 

run;

ods pdf close; 





