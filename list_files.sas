*get a list f1, of the SAS datasets in the folder &path;
%macro list_files(path=, ext=sas7bdat);
                                                           
  %let rc=%sysfunc(filename(filrf,&path));                                                                                               
  %let did=%sysfunc(dopen(&filrf));                                                                                                     
                                                                                                                                                                                                                                       
  %if &did eq 0 %then %do;                                                                                                              
   %put Directory &path cannot be open or does not exist;                                                                                
   %return;                                                                                                                             
  %end;                                                                                                                                 
                                                                                                                                                                                                                                       
   %do i = 1 %to %sysfunc(dnum(&did));                                                                                                                                                                                                                                                                                              
     %let name=%qsysfunc(dread(&did,&i));  
	 data temp&i; 
	 length names $41.; 
	 names="&name";

    data f1; length names $41.; 
    set %if &i=1 %then temp1; %else f1 temp&i;; 
	%end;

	data f1; set f1; if scan(names,2,'.') ne "&ext" then delete;
	run;
	
	/* Closes the directory and clear the fileref */                                                                                      
  %let rc=%sysfunc(dclose(&did));                                                                                                       
  %let rc=%sysfunc(filename(filrf));                                                                                                    

proc datasets nodetails nolist; delete temp:;
run;                                            
%mend;

