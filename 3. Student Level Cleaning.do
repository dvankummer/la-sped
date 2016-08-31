/*Merge SIS (Pre) and SER (Post Files )*/
***********************************************
***********************************************

/***********************************************
STEP 1: FIRST MERGE ALL SIS AND SER FILES
***********************************************/
/*YEAR 1*/

clear all
cd "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived"


use SER_2010-11, clear

sort GUIDNum_SER_1011 SiteCd_SER_1011
rename (GUIDNum_SER_1011 SiteCd_SER_1011) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2010", replace


use SIS_2010-11, clear

drop SexCd_SIS_1011 FedRaceEthnicityCd_SIS_1011
order GUIDNum_SIS_1011  BegSchSessYr_SIS_1011 SiteCd_SIS_1011
sort GUIDNum_SIS_1011 SiteCd_SIS_1011
rename (GUIDNum_SIS_1011 SiteCd_SIS_1011) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SIS2010", replace



merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2010" 

tab _merge
drop if _merge!=3

order BegSchSessYr_SIS_1011

drop _merge race gender

save "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2010-11", replace







/*YEAR 2*/

clear all

cd "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived"


use SER_2011-12, clear

sort GUIDNum_SER_1112 SiteCd_SER_1112
rename (GUIDNum_SER_1112 SiteCd_SER_1112) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2011", replace

cd "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived"
use SIS_2011-12, clear

drop SexCd_SIS_1112 FedRaceEthnicityCd_SIS_1112
order GUIDNum_SIS_1112  BegSchSessYr_SIS_1112 SiteCd_SIS_1112
sort GUIDNum_SIS_1112 SiteCd_SIS_1112
rename (GUIDNum_SIS_1112 SiteCd_SIS_1112) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SIS2011", replace



merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2011" 

tab _merge
drop if _merge!=3

order BegSchSessYr_SIS_1112

drop _merge race gender

save "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2011-12", replace








/*YEAR 3*/

clear all

cd "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived"
use SER_2012-13, clear

sort GUIDNum_SER_1213 SiteCd_SER_1213
rename (GUIDNum_SER_1213 SiteCd_SER_1213) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2012", replace



cd "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived"
use SIS_2012-13, clear

drop SexCd_SIS_1213 FedRaceEthnicityCd_SIS_1213
order GUIDNum_SIS_1213  BegSchSessYr_SIS_1213 SiteCd_SIS_1213
sort GUIDNum_SIS_1213 SiteCd_SIS_1213
rename (GUIDNum_SIS_1213 SiteCd_SIS_1213) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SIS2012", replace

merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2012" 

tab _merge
drop if _merge!=3

order BegSchSessYr_SIS_1213

drop _merge race gender

save "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2012-13", replace










/*YEAR 4*/
clear all

cd "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived"


use SER_2013-14, clear

sort GUIDNum_SER_1314 SiteCd_SER_1314
rename (GUIDNum_SER_1314 SiteCd_SER_1314) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2013", replace


/*ASSESS THE DUPLICATES*/
/*RETAIN THE CASE THAT HAS THE MOST RECENT EXIT DATE*/

duplicates report GUIDNum

list GUIDNum exit_date_SER_1314 SpecialEdExitCode_SER_1314 if _n==3829 
list GUIDNum exit_date_SER_1314 SpecialEdExitCode_SER_1314 if _n==3830

drop if _n==3829 


save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2013", replace



cd "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived"
use SIS_2013-14, clear

drop SexCd_SIS_1314 FedRaceEthnicityCd_SIS_1314
order GUIDNum_SIS_1314  BegSchSessYr_SIS_1314 SiteCd_SIS_1314
sort GUIDNum_SIS_1314 SiteCd_SIS_1314
rename (GUIDNum_SIS_1314 SiteCd_SIS_1314) (GUIDNum SiteCd)
save "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SIS2013", replace



merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataSets/Derived/SER2013" 

tab _merge
drop if _merge!=3

order BegSchSessYr_SIS_1314

drop _merge race gender
save "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2013-14", replace








