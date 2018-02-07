Merge Multiple csv files into one table


    Two solutions should be cross platform

       1. Using wildcard
       2. Using directory (allows for arbitrary names)



https://communities.sas.com/t5/SAS-Procedures/Merge-Multiple-csv-files-into-one-dataset/m-p/434930


INPUT  (three files in directory parent )
=========================================


    C:\PARENT
        |
        +-- file1.txt
             record 1:  file1

        +-- file2.txt
             record 1:  file2

        +-- file3.txt
             record 1:  file3

   RILES (want)

     WORK.FILES total obs=3

                FRO            RECORD1

        c:\parent\file1.txt     file1
        c:\parent\file1.txt     file2
        c:\parent\file2.txt     file3


PROCESS (full solutions)
=========================

 1. USING WILDCARD

  filename inp "c:\parent\";
  data files;
    length fro fid  $32;
    infile inp(*.txt) filename=fid length=len;
    fro=fid;
    input records$ ;
  run;quit;


 2. USING DIRECTORY (allows for arbitrary names)

    data want;
       length froPth fname $96;;
       rc=filename("mydir","&path");
       did=dopen("mydir");
       if did > 0 then do;
          number_of_members=dnum(did);
          do i=1 to number_of_members;
            filename=dread(did,i);
            fylvar="&pth/"!!filename;
            infile dummy2 filevar=fylvar filename=fname end=eof;
            froPth=fname;
            input records$;
            keep froPth records;
            output;
         end;
      end;
      stop;
    run;quit;


*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

* create 3 txt file in c:/parent;
data _null_;

  * create directory;
  if _n_=0 then do;
      %let rc=%sysfunc(dosubl('
         data _null_;
             rc=dcreate("parent","c:/");
         run;quit;
     '));
  end;

  file "c:/parent/file1.txt"; put "file1";
  file "c:/parent/file2.txt"; put "file2";
  file "c:/parent/file3.txt"; put "file3";

run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __  ___
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|
\__ \ (_) | | |_| | |_| | (_) | | | \__ \
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/

;


 1. USING WILDCARD

  filename inp "c:\parent\";
  data files;
    length fro fid  $32;
    infile inp(*.txt) filename=fid length=len;
    fro=fid;
    input records$ ;
  run;quit;


 2. USING DIRECTORY (allows for arbitrary names)

data want;
   length froPth fname $96;;
   rc=filename("mydir","&path");
   did=dopen("mydir");
   if did > 0 then do;
      number_of_members=dnum(did);
      do i=1 to number_of_members;
        filename=dread(did,i);
        fylvar="&pth/"!!filename;
        infile dummy2 filevar=fylvar filename=fname end=eof;
        froPth=fname;
        input records$;
        keep froPth records;
        output;
     end;
  end;
  stop;
run;quit;

