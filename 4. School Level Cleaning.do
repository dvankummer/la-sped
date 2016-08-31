

clear
*****************************************
*****************************************
*****************************************
*Data Prep 4.15 LA Charters SpED Study	*
*          SCHOOL LEVEL DATA	    *
*****************************************
*****************************************
*****************************************

clear

cd "/Volumes/USB DISK/LCSE/Docs"


/*Bring in the list of ALL K-12 Schools in LA*/
import excel "/Volumes/USB DISK/LCSE/Docs/2014-Feb-multi-stats-elem-sec-by-site-public.xlsx", sheet("TPS_CHA") firstrow clear
drop A Year SiteCd2 Total 
order LEA LEAName SiteCd SiteName
keep LEA LEAName SiteCd SiteName 
sort LEA SiteCd
rename (LEA) (SponsorCd)
drop if _n==1

save "/Volumes/USB DISK/LCSE/Posted/DataSets/AllSchools", replace





/*Bring in the list of Charter School List in LA*/
/*Note some schools have the same SiteCd. This interferes with merge*/
/*Business Rule Applied: If two schools have the same SiteCd they*/
/*are considered the same school and the first will be deleted*/
* 036079-Lusher/Adovcates for Arts, 398001-KIPP New Orleans, 398002-KIPP McDonogh #15 School for the Creative Arts
 
import excel "/Volumes/USB DISK/LCSE/Docs/Charter Contact List2.xlsx", sheet("Charter Contact List") firstrow clear


keep YearOpened Type SiteCode ParishSchoolDistrict NonProfitName LEACode G City CharteringAuthority  
rename (SiteCode CharteringAuthority G LEACode) (SiteCd CharterAuth Grades SponsorCd)
order SponsorCd ParishSchoolDistrict SiteCd NonProfitName Type CharterAuth YearOpened  City  ParishSchoolDistrict
generate charter =1

sort SponsorCd SiteCd 


/*ASSESS THE DUPLICATES*/
/*RETAIN THE CASE THAT HAS THE MOST RECENT EXIT DATE*/

drop if _n<=8


duplicates report SiteCd

list if SiteCd=="036079"
drop if _n==31


list if SiteCd=="398001"
drop if _n==97


list if SiteCd=="398002"
drop if _n==98



sort SponsorCd SiteCd 
duplicates report SiteCd

save "/Volumes/USB DISK/LCSE/Posted/DataSets/Charters", replace



clear
**********************************************************
**********************************************************
**********************************************************

/*FIRST MERGE THE LEAS TO GET THE THE ALLOWABLE SAMPLE REGIONS*/
import excel "/Volumes/USB DISK/LCSE/Docs/Charter Contact List2.xlsx", sheet("Data Catalogue_rev") firstrow clear


/*Eliminate LEAs that are not in the sample*/

drop if RegionForLCSE=="Not in sample"
drop C
rename (E LEA) (Region SponsorCd)

replace Region=1 if RegionForLCSE=="Baton Rouge"
replace Region=2 if RegionForLCSE=="Jefferson"
replace Region=3 if RegionForLCSE=="New Orleans"
replace Region=4 if RegionForLCSE=="Orleans"
replace Region=5 if RegionForLCSE=="Ouachita"



/*Now Merge to find the LEAs that are in the allowable sample regions*/

merge 1:m SponsorCd using  "/Volumes/USB DISK/LCSE/Posted/DataSets/AllSchools"

tab _merge

drop if _merge==2

	
	sort SponsorCd
	drop _merge

	save "/Volumes/USB DISK/LCSE/Posted/DataSets/All LEAs in Sample Regions" ,replace


/*Now Merge to identify Schools Traditional Public Schools TPS*/

use "/Volumes/USB DISK/LCSE/Posted/DataSets/All LEAs in Sample Regions", clear



merge m:m SponsorCd using "/Volumes/USB DISK/LCSE/Posted/DataSets/Charters"

tab _merge

/*School Type Dummy Variables*/
generate TPS=1 if _merge==1
replace TPS=0 if charter==1
replace charter=0 if TPS==1

label variable charter "Charter School"
label variable TPS "Traditonal Public Schools"

/*Type Dummy Variables*/

/*Remove Conversion Charters (Type 3)*/
tab Type
drop if Type=="3" | Type=="3B"

generate type1=1 if Type=="1" 
label variable type1 "Type 1-New School"

generate type2=1 if Type=="2"
label variable type2 "Type 1-New or Conversion School"

generate type4=1 if Type=="4"
label variable type4 "Type 1-New  or Conversion School"

generate type5=1 if Type=="5"
label variable type5 "Recovery School District Schools"


replace type1 =0 if Type!="1"
replace type2 =0 if Type!="2"
replace type4 =0 if Type!="4"
replace type5 =0 if Type!="5"

/*Region Dummy Variables*/
generate batonrouge=1
label variable batonrouge "Region: Baton Rougue"

generate jefferson=1
label variable jefferson "Region: Jefferson"

generate neworleans=1
label variable neworleans "Region: New Orleans"

generate orleans=1
label variable orleans "Region: Orleans"

generate ouachita=1
label variable ouachita "Region: Ouachita"

replace batonrouge =0 if Region!=1
replace jefferson =0 if Region!=2
replace neworleans =0 if Region!=3
replace orleans =0 if Region!=4
replace ouachita =0 if Region!=5

/*Dummies for Charter Authorizers*/

tab CharterAuth


generate BESE =1 if CharterAuth=="BESE"
label variable BESE "Board of Elementeary and Secondary Education"

generate BESE_APSB =1 if CharterAuth=="BESE/APSB"
label variable BESE_APSB "Board of Elementeary and Secondary Education and Ascension Parish School Board"
      
generate BESE_RSD =1 if CharterAuth=="BESE/RSD" 
label variable BESE_RSD "Board of Elementeary and Secondary Education and Recovery School District"

      
generate CPSB =1 if CharterAuth=="CPSB"    
label variable CPSB "Cado Parish School Board"
   
generate EBRPSB =1 if CharterAuth=="EBRPSB"      
label variable EBRPSB "East Baton Rougue Parish School Board"
   
generate EFPSB =1 if CharterAuth=="EFPSB"
label variable EFPSB "East Feliciana Parish School Board"

generate JPSB =1 if CharterAuth=="JPSB"      
label variable JPSB  "Jefferson Parish School Board"

   
generate LPSB =1 if CharterAuth=="LPSB"
label variable LPSB  "Lafouche Parish School Board"


generate MCSB =1 if CharterAuth=="MCSB" 
label variable MCSB  "Moorhouse Parish School Board"  
      
generate OPSB =1 if CharterAuth=="OPSB" | CharterAuth== "OPSB "  
label variable OPSB  "Orleans Parish School Board"   


replace BESE =0 if Region!=1
replace BESE_APSB =0 if Region!=1
replace BESE_RSD =0 if Region!=1
replace CPSB =0 if Region!=1
replace EBRPSB =0 if Region!=1
replace EFPSB =0 if Region!=1
replace JPSB =0 if Region!=1
replace LPSB =0 if Region!=1
replace MCSB =0 if Region!=1
replace OPSB =0 if Region!=1


sort SiteCd

order SponsorCd LEAName SiteCd SiteName NonProfitName charter TPS Grades ParishSchoolDistrict RegionForLCSE Region batonrouge jefferson neworlean orleans ouachita  Type type1 type2 type4 type5 CharterAuth BESE BESE_APSB BESE_RSD CPSB EBRPSB EFPSB JPSB LPSB MCSB OPSB YearOpened City  _merge
drop _merge

duplicates report SiteCd
duplicates list SiteCd
/*Some School not have site codes, this makes it impossible to merge. Remove them*/

drop if SiteCd==""

/*Remove schools with duplicate site codes*/

list if SiteCd=="398003"
drop if _n==759

save "/Volumes/USB DISK/LCSE/Posted/DataClean/Final LEA Sample_School Level n=796", replace

