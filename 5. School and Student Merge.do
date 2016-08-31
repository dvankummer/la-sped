
clear
********************************************************************************
********************************************************************************
********************************************************************************
/*******MERGE SCHOOL LEVEL AND STUDENT LEVEL*/
********************************************************************************
********************************************************************************
********************************************************************************

****************************************************
/*First Merge School Data with Each Year*/
****************************************************

clear all
/*Y1*/

use "/Volumes/USB DISK/LCSE/Posted/DataClean/Final LEA Sample_School Level n=796"

rename* =_1011

rename (SiteCd_1011) (SiteCd)

merge 1:m SiteCd using "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2010-11.dta"

drop if _merge==2
drop _merge
rename (SiteCd) (SiteCd_1011) 

drop if GUIDNum==.
sort GUIDNum

save "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 1", replace




clear all
/*Y2*/

use "/Volumes/USB DISK/LCSE/Posted/DataClean/Final LEA Sample_School Level n=796"

rename* =_1112

rename (SiteCd_1112) (SiteCd)

merge 1:m SiteCd using "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2011-12.dta"

drop if _merge==2
drop _merge
rename (SiteCd) (SiteCd_1112) 

drop if GUIDNum==.
sort GUIDNum



save "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 2", replace





clear all
/*Y3*/

use "/Volumes/USB DISK/LCSE/Posted/DataClean/Final LEA Sample_School Level n=796"

rename* =_1213

rename (SiteCd_1213) (SiteCd)

merge 1:m SiteCd using "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2012-13.dta"

drop if _merge==2
drop _merge

rename (SiteCd) (SiteCd_1213) 
drop if GUIDNum==.
sort GUIDNum
save "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 3", replace



clear all
/*Y4*/

use "/Volumes/USB DISK/LCSE/Posted/DataClean/Final LEA Sample_School Level n=796"

rename* =_1314

rename (SiteCd_1314) (SiteCd)

merge 1:m SiteCd using "/Volumes/USB DISK/LCSE/Posted/DataClean/Student 2013-14.dta"

drop if _merge==2
drop _merge

rename (SiteCd) (SiteCd_1314) 
drop if GUIDNum==.
sort GUIDNum
save "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 4", replace





/*use "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 1.dta", clear
merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 2.dta"
tab _merge

/*Please not that only 6 students have data for both Years 1 and 2*/

drop _merge


/*Y1,Y2 and Y3*/
merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 3.dta"
tab _merge

drop _merge

/*Y1,Y2, Y3 and Y4*/
merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 4.dta"
tab _merge

drop _merge

sort SiteCd
save "/Volumes/USB DISK/LCSE/Posted/DataClean/Student Level Y1-Y4", replace*/




clear
******************************************************************
/*Next Merge All Years Together*/
******************************************************************


/*Y1 and Y2*/

use "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 1", clear
merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 2"
drop _merge

/*Y1,Y2 and 3*/
merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 3"
drop _merge


/*Y1,Y2, Y3 and Y4*/
merge 1:1 GUIDNum using "/Volumes/USB DISK/LCSE/Posted/DataClean/Year 4"
drop _merge



save  "/Volumes/USB DISK/LCSE/Posted/DataClean/FINAL SpED 2010-11 to 2013-14", replace

***************************************************************************
****************************************************************************
/*Calculate Persistence*/
drop P1-P3

generate Persist1=1 if SiteCd_1011==SiteCd_1112
label variable Persist1 "Persistence 1: If Student Remained in the same school Y1 and Y2"

generate Persist2=1 if SiteCd_1112==SiteCd_1213
label variable Persist2 "Persistence 2: If Student Remained in the same school Y2 and Y3"

generate Persist3=1 if SiteCd_1213==SiteCd_1314
label variable Persist3 "Persistence 3: If Student Remained in the same school Y3 and Y4"


replace Persist1=0 if SiteCd_1011!=SiteCd_1112
replace Persist2=0 if SiteCd_1112!=SiteCd_1213
replace Persist3=0 if SiteCd_1213!=SiteCd_1314

/*Calculate Newely Certified*/
generate NewlyCertYr1=1 if dis_SIS_1011==1
label variable NewlyCertYr1 "Newly Certified as Special Need in 2010-11"

generate NewlyCertyr2=1 if dis_SIS_1011!=1 &dis_SIS_1112==1
label variable NewlyCertyr2 "Newly Certified as Special Need in 2011-12"

generate NewlyCertYr3=1 if dis_SIS_1112!=1 &dis_SIS_1213==1
label variable NewlyCertYr3 "Newly Certified as Special Need in 2012-13"

generate NewlyCertYr4=1 if dis_SIS_1213!=1 &dis_SIS_1314==1
label variable NewlyCertYr4 "Newly Certified as Special Need in 2013-14"


/*Caclulate Newly DeCertified*/

generate NewlyDECertyr2=1 if dis_SIS_1011==1 &dis_SIS_1112!=1
label variable NewlyDECertyr2 "Newly Decertified as Special Need in 2011-12"

generate NewlyDECertYr3=1 if dis_SIS_1112==1 &dis_SIS_1213!=1
label variable NewlyDECertYr3 "Newly Decertified as Special Need in 2012-13"

generate NewlyDECertYr4=1 if dis_SIS_1213==1 &dis_SIS_1314!=1
label variable NewlyDECertYr4 "Newly Decertified as Special Need in 2013-14"

save  "/Volumes/USB DISK/LCSE/Posted/DataClean/FINAL SpED 2010-11 to 2013-14", replace



