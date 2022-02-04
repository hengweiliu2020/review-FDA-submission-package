
*indir is the folder for xpt files;
*outdir is where to store the SAS datasets;


%macro xpt2dat(indir=, outdir=);

libname a "&outdir";
%list_files(path=&indir, ext=xpt);


data _null_;
set f1 end=eof;
i+1;
call symput(compress("name"||i), trim(left(names)));
if eof then call symput("tot", trim(left(_n_)));
run;

%do k=1 %to &tot;

libname xpt&k xport "&indir/&&name&k" access=readonly;
proc copy in=xpt&k out=a;
run;
%end;
%mend;

*example;
%*xpt2dat(indir=/home/hliu/transport, outdir=/home/hliu/transport);
