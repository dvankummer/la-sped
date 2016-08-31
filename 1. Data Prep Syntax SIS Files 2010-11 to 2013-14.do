

log using "/Volumes/USB DISK/LCSE/Posted/DataSets\Source\SIS 2010-11.log"
***test***

clear
*****************************************
*****************************************
*****************************************
*Data Prep 4.15 LA Charters SpED Study	*
*           2010-11 to 2013-14 		    *
*****************************************
*****************************************
*****************************************

**********************************************************************
**********************************************************************
*                    YEAR 1: 2010-11                                *
**********************************************************************
**********************************************************************

import excel "/Volumes/USB DISK/LCSE/Work/Data/SIS Enrollment Files/2010-11 SIS Enrollment.xlsx", sheet("2010-11 SIS Enrollment") firstrow


save 2010-11_SIS, replace


/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/


desc
sort GUIDNum
//SiteCd is left string to preserve leading zeros. It's nominal anyway//
destring GradePlacementCd BegSchSessYr GUIDNum FreeReducedLunchCd EnglishProficiencyCd Disability, replace

generate Year1=1
save SIS_2010-11, replace



*******************************************	
/*Create Gender Dummy Variables*/
encode SexCd, generate(gender)
tab gender

	generate female=.
	replace female=0 if gender==2
	replace female=1 if gender==1

	
	
	
*******************************************	
/*Create Race/Ethnicity Dummy Variables*/

encode FedRaceEthnicityCd, generate(race)
tab race

//American Indian or Alaskan
generate AM=.
replace AM=1 if race==1
replace AM=0 if race!=1 & race!=.
label variable AM "American Indian or Alaskan"

//Asian//
generate AS=.
replace AS=1 if race==2
replace AS=0 if race!=2 & race!=.
label variable AS "Asian"


//Black or African American//
generate BL=.
replace BL=1 if race==3
replace BL=0 if race!=3 & race!=.
label variable BL "Black or African American"


//Hispanic or Latino//
generate HI=.
replace HI=1 if race==4
replace HI=0 if race!=4 & race!=.
label variable HI "Hispanic or Latino"


//Two or More//
generate MU=.
replace MU=1 if race==5
replace MU=0 if race!=5 & race!=.
label variable MU "Two or more races"

//Native Hawaiian or Pacific Islander//
generate PI=.
replace PI=1 if race==6
replace PI=0 if race!=6 & race!=.
label variable PI "Native Hawaiian or Pacific Islander"

//White//
generate WH=.
replace WH=1 if race==7
replace WH=0 if race!=7 & race!=.
label variable WH "White"

summarize AM-WH




*******************************************************
/*Create Free and Reduced Price Lunch Dummy Variables*/
tab FreeReducedLunchCd

generate FRPL=.
replace FRPL =1 if FreeReducedLunchCd==1 | FreeReducedLunchCd==2
replace FRPL=0 if FreeReducedLunchCd !=. & FreeReducedLunchCd !=1 & FreeReducedLunchCd!=2

label variable FRPL "Receives Free OR Reduced Price Lunch"
list FreeReducedLunchCd FRPL if _n<=20

	generate FreeLunch=.
	replace FreeLunch =1 if FreeReducedLunchCd==1
	replace FreeLunch=0 if FreeReducedLunchCd ==2

		label variable FreeLunch "Free Lunch"

		
	generate RedLunch=.
	replace RedLunch =1 if FreeReducedLunchCd==2
	replace RedLunch=0 if FreeReducedLunchCd ==1 

		label variable RedLunch "Reduced Price Price Lunch"
	
		
	
summarize FreeReducedLunchCd FRPL FreeLunch RedLunch	


*******************************************************
/*Create English Proficiency Dummy Variables*/
tab EnglishProficiencyCd

	generate engprof=.
	replace engprof =1 if EnglishProficiencyCd==1
	replace engprof=0 if EnglishProficiencyCd ==2

		label variable engprof "Full English Proficiency"
		list EnglishProficiencyCd engprof if _n<=10


summarize EnglishProficiencyCd engprof



*******************************************	
/*Create Grade Level Dummy Variables*/



tab GradePlacementCd


generate FIRST=.
	replace FIRST = 1 if  GradePlacementCd==1
	replace FIRST = 0 if (GradePlacementCd !=1 & GradePlacementCd!=.)
	

generate SECOND=.
	replace SECOND = 1 if  GradePlacementCd==2
	replace SECOND = 0 if (GradePlacementCd !=2 & GradePlacementCd!=.)


generate THIRD=.
	replace THIRD = 1 if  GradePlacementCd==3
	replace THIRD = 0 if (GradePlacementCd !=3 & GradePlacementCd!=.)


generate FOURTH=.
	replace FOURTH = 1 if  GradePlacementCd==4
	replace FOURTH = 0 if (GradePlacementCd !=4 & GradePlacementCd!=.)
	
	
generate FIFTH=.
	replace FIFTH = 1 if  GradePlacementCd==5
	replace FIFTH = 0 if (GradePlacementCd !=5 & GradePlacementCd!=.)
	
	
generate SIXTH=.
	replace SIXTH = 1 if  GradePlacementCd==6
	replace SIXTH = 0 if (GradePlacementCd !=6 & GradePlacementCd!=.)
	
generate SEVENTH=.
	replace SEVENTH = 1 if  GradePlacementCd==7
	replace SEVENTH = 0 if (GradePlacementCd !=7 & GradePlacementCd!=.)
	

generate EIGHTH=.
	replace EIGHTH = 1 if  GradePlacementCd==8
	replace EIGHTH = 0 if (GradePlacementCd !=8 & GradePlacementCd!=.)
	

generate NINTH=.
	replace NINTH = 1 if  GradePlacementCd==9
	replace NINTH = 0 if (GradePlacementCd !=9 & GradePlacementCd!=.)
	

generate TENTH=.
	replace TENTH = 1 if  GradePlacementCd==10
	replace TENTH = 0 if (GradePlacementCd !=10 & GradePlacementCd!=.)
	
	
generate ELEVENTH=.
	replace ELEVENTH = 1 if  GradePlacementCd==11
	replace ELEVENTH = 0 if (GradePlacementCd !=11 & GradePlacementCd!=.)
	

generate TWELFTH=.
	replace TWELFTH = 1 if  GradePlacementCd==12
	replace TWELFTH = 0 if (GradePlacementCd !=12 & GradePlacementCd!=.)
	

generate INFANTPGRM=.
	replace INFANTPGRM = 1 if  GradePlacementCd==15
	replace INFANTPGRM = 0 if (GradePlacementCd !=15 & GradePlacementCd!=.)

	
generate PRESCHOOL=.
	replace PRESCHOOL = 1 if  GradePlacementCd==20
	replace PRESCHOOL = 0 if (GradePlacementCd !=20 & GradePlacementCd!=.)
	

generate PREK3=.
	replace PREK3 = 1 if  GradePlacementCd==22
	replace PREK3 = 0 if (GradePlacementCd !=22 & GradePlacementCd!=.)
	

generate PREK4=.
	replace PREK4 = 1 if  GradePlacementCd==24
	replace PREK4 = 0 if (GradePlacementCd !=24 & GradePlacementCd!=.)
	
	
generate KINDER=.
	replace KINDER = 1 if  GradePlacementCd==25
	replace KINDER = 0 if (GradePlacementCd !=25 & GradePlacementCd!=.)
	
	

tab GradePlacementCd
summarize FIRST-KINDER	

/*CONSOLIDATE GRADE CATEGORIES*/

			generate prek=.
				replace prek = 1 if (GradePlacementCd==15| GradePlacementCd==20 |GradePlacementCd==22| GradePlacementCd==24)
				replace prek = 0 if (GradePlacementCd !=15 & GradePlacementCd !=20 & GradePlacementCd !=22 & GradePlacementCd !=24 & GradePlacementCd!=.)

			generate elementary=.
				replace elementary = 1 if (GradePlacementCd==1| GradePlacementCd==2 |GradePlacementCd==3| GradePlacementCd==4| GradePlacementCd==5|GradePlacementCd==25)
				replace elementary = 0 if (GradePlacementCd !=1 & GradePlacementCd !=2 & GradePlacementCd !=3 & GradePlacementCd !=4 & GradePlacementCd !=5 & GradePlacementCd !=25 & GradePlacementCd!=.)
			label variable elementary "Elementary (K-5)"
				

			generate middle=.
				replace middle = 1 if (GradePlacementCd==6| GradePlacementCd==7 |GradePlacementCd==8)
				replace middle = 0 if (GradePlacementCd !=6 & GradePlacementCd !=7 & GradePlacementCd !=8 & GradePlacementCd!=.)
			label variable middle "Middle School (6-8)"

				
			generate high=.
				replace high = 1 if (GradePlacementCd==9| GradePlacementCd==10 |GradePlacementCd==11 | GradePlacementCd==12)
				replace high = 0 if (GradePlacementCd !=9 & GradePlacementCd !=10 & GradePlacementCd !=11 & GradePlacementCd!=12 & GradePlacementCd!=.)
			label variable high "High School (9-12)"
				
summarize prek elementary middle high




**************************************************
/*Create Dummy Variables for each Exceptionality*/
sort Disability
tab Disability


generate dis=.
replace dis = 1 if Disability !=. & Disability !=24
replace dis = 0 if Disability !=. & Disability==24



summarize Disability dis

//autism//
generate autism=.
replace autism =1 if Disability==1
replace autism = 0 if Disability !=1 & Disability !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if Disability==2
replace blindness = 0 if Disability !=2 & Disability !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if Disability==3
replace deafness = 0 if Disability !=3 & Disability !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if Disability==4
replace deaf_blindness = 0 if Disability !=4 & Disability !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if Disability==5
replace emotdist = 0 if Disability !=5 & Disability !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if Disability==7
replace devpmtdelay = 0 if Disability !=7 & Disability !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if Disability==8
replace hearimpair = 0 if Disability !=8 & Disability !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning Disability//
generate speclearn=.
replace speclearn =1 if Disability==11
replace speclearn = 0 if Disability !=11 & Disability !=.

label variable speclearn "Specific Learning Disability"


//Intellectual Disability-Mild//
generate intell_mild=.
replace intell_mild =1 if Disability==12
replace intell_mild = 0 if Disability !=12 & Disability !=.

label variable intell_mild "Intellectual Disability-Mild"


//Intellectual Disability-Moderate//
generate intell_mod=.
replace intell_mod =1 if Disability==13
replace intell_mod = 0 if Disability !=13 & Disability !=.

label variable intell_mod "Intellectual Disability-Moderate"


//Intellectual Disability-Severe//
generate intell_severe=.
replace intell_severe =1 if Disability==14
replace intell_severe = 0 if Disability !=14 & Disability !=.

label variable intell_severe "Intellectual Disability-Severe"



//Intellectual Disability-Profound//
generate intell_prof=.
replace intell_prof =1 if Disability==15
replace intell_prof = 0 if Disability !=15 & Disability !=.

label variable intell_prof "Intellectual Disability-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if Disability==16
replace multiple = 0 if Disability !=16 & Disability !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if Disability==17
replace multiple = 0 if Disability !=17 & Disability !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if Disability==18
replace orthopedic = 0 if Disability !=18 & Disability !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if Disability==19
replace oth_health = 0 if Disability !=19 & Disability !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if Disability==20
replace semi_visual = 0 if Disability !=20 & Disability !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if Disability==21
replace severelang = 0 if Disability !=21 & Disability !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if Disability==22
replace edhandicap = 0 if Disability !=22 & Disability !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if Disability==25
replace braininjury = 0 if Disability !=25 & Disability !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if Disability==26
replace unknown = 0 if Disability !=26 & Disability !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if Disability==27
replace gifted = 0 if Disability !=27 & Disability !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if Disability==28
replace speech_lang = 0 if Disability !=28 & Disability !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if Disability==29
replace speech_langflu = 0 if Disability !=29 & Disability !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if Disability==30
replace speech_langla = 0 if Disability !=30 & Disability !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if Disability==31
replace speech_langvo = 0 if Disability !=31 & Disability !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if Disability==32
replace talented = 0 if Disability !=32 & Disability !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if Disability==33
replace talented_thtr = 0 if Disability !=33 & Disability !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if Disability==34
replace talented_vis = 0 if Disability !=34 & Disability !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if Disability==99
replace incomplete = 0 if Disability !=99 & Disability !=.

label variable incomplete "Unable to Complete Evaluation Process"


summarize dis-incomplete


save SIS_2010-11, replace


******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if Disability==2| Disability==20
replace visual_cons= 0 if  Disability !=2 & Disability!=20

label variable visual_cons "Visual Impairments Consilidated"


//Hearing Impairment-Deafness and Hearing Impariment-Hard of Hearing//
generate hearing_cons=.
replace hearing_cons = 1 if deafness==1 |hearimpair==1
replace hearing_cons= 0 if deafness!=1 & hearimpair!=1

label variable hearing_cons "Hearing Impairments Consilidated"


//Intellectual Disabiity Mild Mod, Severe, Profound//
generate intell_cons=.
replace intell_cons = 1 if intell_mild==1 | intell_mod==1 | intell_severe==1 | intell_prof==1
replace intell_cons= 0 if intell_mild!=1 & intell_mod!=1 & intell_severe!=1 & intell_prof!=1

label variable intell_con "Intellectual Disabiity Consolidated ( Mild, Mod,Severe,Profound)"

//Speech or Language Impairments Regular, Fluency, Language, Voice//
generate speech_cons=.
replace speech_cons = 1 if speech_lang==1 | speech_langflu==1 | speech_langla==1 | speech_langvo==1
replace speech_cons= 0 if speech_lang!=1 & speech_langflu!=1 & speech_langla!=1 & speech_langvo!=1

label variable speech_cons "Speech or Language Impairments Consolidated ( Regular, Fluency, Language, Voice)"


//Talented- Talented, Theater, Visual Arts//
generate talented_cons=.
replace talented_cons = 1 if talented==1 | talented_thtr==1 | talented_vis==1 
replace talented_cons= 0 if talented!=1 & talented_thtr!=1 & talented_vis!=1 

label variable talented_cons "Talented (Talented, Theater, Visual Arts)"

summarize visual_cons-talented_cons


rename * =_SIS_1011
desc

save SIS_2010-11, replace
























clear

**********************************************************************
**********************************************************************
*                    YEAR 2: 2011-12                                *
**********************************************************************
**********************************************************************

import excel "/Volumes/USB DISK/LCSE/Work/Data/SIS Enrollment Files/2011-12 SIS Enrollment.xlsx", sheet("2011-12 SIS Enrollment") firstrow


save 2011-12_SIS, replace



/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/


desc
sort GUIDNum
//SiteCd is left string to preserve leading zeros. It's nominal anyway//
destring GradePlacementCd BegSchSessYr GUIDNum FreeReducedLunchCd EnglishProficiencyCd Disability, replace

generate Year2=1
save SIS_2011-12, replace



*******************************************	
/*Create Gender Dummy Variables*/
encode SexCd, generate(gender)
tab gender

	generate female=.
	replace female=0 if gender==2
	replace female=1 if gender==1

	
	
	
*******************************************	
/*Create Race/Ethnicity Dummy Variables*/

encode FedRaceEthnicityCd, generate(race)
tab race

//American Indian or Alaskan
generate AM=.
replace AM=1 if race==1
replace AM=0 if race!=1 & race!=.
label variable AM "American Indian or Alaskan"

//Asian//
generate AS=.
replace AS=1 if race==2
replace AS=0 if race!=2 & race!=.
label variable AS "Asian"


//Black or African American//
generate BL=.
replace BL=1 if race==3
replace BL=0 if race!=3 & race!=.
label variable BL "Black or African American"


//Hispanic or Latino//
generate HI=.
replace HI=1 if race==4
replace HI=0 if race!=4 & race!=.
label variable HI "Hispanic or Latino"


//Two or More//
generate MU=.
replace MU=1 if race==5
replace MU=0 if race!=5 & race!=.
label variable MU "Two or more races"

//Native Hawaiian or Pacific Islander//
generate PI=.
replace PI=1 if race==6
replace PI=0 if race!=6 & race!=.
label variable PI "Native Hawaiian or Pacific Islander"

//White//
generate WH=.
replace WH=1 if race==7
replace WH=0 if race!=7 & race!=.
label variable WH "White"

summarize AM-WH




*******************************************************
/*Create Free and Reduced Price Lunch Dummy Variables*/
tab FreeReducedLunchCd

generate FRPL=.
replace FRPL =1 if FreeReducedLunchCd==1 | FreeReducedLunchCd==2
replace FRPL=0 if FreeReducedLunchCd !=. & FreeReducedLunchCd !=1 & FreeReducedLunchCd!=2

label variable FRPL "Receives Free OR Reduced Price Lunch"
list FreeReducedLunchCd FRPL if _n<=20

	generate FreeLunch=.
	replace FreeLunch =1 if FreeReducedLunchCd==1
	replace FreeLunch=0 if FreeReducedLunchCd ==2

		label variable FreeLunch "Free Lunch"

		
	generate RedLunch=.
	replace RedLunch =1 if FreeReducedLunchCd==2
	replace RedLunch=0 if FreeReducedLunchCd ==1 

		label variable RedLunch "Reduced Price Price Lunch"
	
		
	
summarize FreeReducedLunchCd FRPL FreeLunch RedLunch	


*******************************************************
/*Create English Proficiency Dummy Variables*/
tab EnglishProficiencyCd

	generate engprof=.
	replace engprof =1 if EnglishProficiencyCd==1
	replace engprof=0 if EnglishProficiencyCd ==2

		label variable engprof "Full English Proficiency"
		list EnglishProficiencyCd engprof if _n<=10


summarize EnglishProficiencyCd engprof



*******************************************	
/*Create Grade Level Dummy Variables*/



tab GradePlacementCd


generate FIRST=.
	replace FIRST = 1 if  GradePlacementCd==1
	replace FIRST = 0 if (GradePlacementCd !=1 & GradePlacementCd!=.)
	

generate SECOND=.
	replace SECOND = 1 if  GradePlacementCd==2
	replace SECOND = 0 if (GradePlacementCd !=2 & GradePlacementCd!=.)


generate THIRD=.
	replace THIRD = 1 if  GradePlacementCd==3
	replace THIRD = 0 if (GradePlacementCd !=3 & GradePlacementCd!=.)


generate FOURTH=.
	replace FOURTH = 1 if  GradePlacementCd==4
	replace FOURTH = 0 if (GradePlacementCd !=4 & GradePlacementCd!=.)
	
	
generate FIFTH=.
	replace FIFTH = 1 if  GradePlacementCd==5
	replace FIFTH = 0 if (GradePlacementCd !=5 & GradePlacementCd!=.)
	
	
generate SIXTH=.
	replace SIXTH = 1 if  GradePlacementCd==6
	replace SIXTH = 0 if (GradePlacementCd !=6 & GradePlacementCd!=.)
	
generate SEVENTH=.
	replace SEVENTH = 1 if  GradePlacementCd==7
	replace SEVENTH = 0 if (GradePlacementCd !=7 & GradePlacementCd!=.)
	

generate EIGHTH=.
	replace EIGHTH = 1 if  GradePlacementCd==8
	replace EIGHTH = 0 if (GradePlacementCd !=8 & GradePlacementCd!=.)
	

generate NINTH=.
	replace NINTH = 1 if  GradePlacementCd==9
	replace NINTH = 0 if (GradePlacementCd !=9 & GradePlacementCd!=.)
	

generate TENTH=.
	replace TENTH = 1 if  GradePlacementCd==10
	replace TENTH = 0 if (GradePlacementCd !=10 & GradePlacementCd!=.)
	
	
generate ELEVENTH=.
	replace ELEVENTH = 1 if  GradePlacementCd==11
	replace ELEVENTH = 0 if (GradePlacementCd !=11 & GradePlacementCd!=.)
	

generate TWELFTH=.
	replace TWELFTH = 1 if  GradePlacementCd==12
	replace TWELFTH = 0 if (GradePlacementCd !=12 & GradePlacementCd!=.)
	

generate INFANTPGRM=.
	replace INFANTPGRM = 1 if  GradePlacementCd==15
	replace INFANTPGRM = 0 if (GradePlacementCd !=15 & GradePlacementCd!=.)

	
generate PRESCHOOL=.
	replace PRESCHOOL = 1 if  GradePlacementCd==20
	replace PRESCHOOL = 0 if (GradePlacementCd !=20 & GradePlacementCd!=.)
	

generate PREK3=.
	replace PREK3 = 1 if  GradePlacementCd==22
	replace PREK3 = 0 if (GradePlacementCd !=22 & GradePlacementCd!=.)
	

generate PREK4=.
	replace PREK4 = 1 if  GradePlacementCd==24
	replace PREK4 = 0 if (GradePlacementCd !=24 & GradePlacementCd!=.)
	
	
generate KINDER=.
	replace KINDER = 1 if  GradePlacementCd==25
	replace KINDER = 0 if (GradePlacementCd !=25 & GradePlacementCd!=.)
	
	

tab GradePlacementCd
summarize FIRST-KINDER	

/*CONSOLIDATE GRADE CATEGORIES*/

			generate prek=.
				replace prek = 1 if (GradePlacementCd==15| GradePlacementCd==20 |GradePlacementCd==22| GradePlacementCd==24)
				replace prek = 0 if (GradePlacementCd !=15 & GradePlacementCd !=20 & GradePlacementCd !=22 & GradePlacementCd !=24 & GradePlacementCd!=.)

			generate elementary=.
				replace elementary = 1 if (GradePlacementCd==1| GradePlacementCd==2 |GradePlacementCd==3| GradePlacementCd==4| GradePlacementCd==5|GradePlacementCd==25)
				replace elementary = 0 if (GradePlacementCd !=1 & GradePlacementCd !=2 & GradePlacementCd !=3 & GradePlacementCd !=4 & GradePlacementCd !=5 & GradePlacementCd !=25 & GradePlacementCd!=.)
			label variable elementary "Elementary (K-5)"
				

			generate middle=.
				replace middle = 1 if (GradePlacementCd==6| GradePlacementCd==7 |GradePlacementCd==8)
				replace middle = 0 if (GradePlacementCd !=6 & GradePlacementCd !=7 & GradePlacementCd !=8 & GradePlacementCd!=.)
			label variable middle "Middle School (6-8)"

				
			generate high=.
				replace high = 1 if (GradePlacementCd==9| GradePlacementCd==10 |GradePlacementCd==11 | GradePlacementCd==12)
				replace high = 0 if (GradePlacementCd !=9 & GradePlacementCd !=10 & GradePlacementCd !=11 & GradePlacementCd!=12 & GradePlacementCd!=.)
			label variable high "High School (9-12)"
				
summarize prek elementary middle high




**************************************************
/*Create Dummy Variables for each Exceptionality*/
sort Disability
tab Disability


generate dis=.
replace dis = 1 if Disability !=. & Disability !=24
replace dis = 0 if Disability !=. & Disability==24



summarize Disability dis

//autism//
generate autism=.
replace autism =1 if Disability==1
replace autism = 0 if Disability !=1 & Disability !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if Disability==2
replace blindness = 0 if Disability !=2 & Disability !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if Disability==3
replace deafness = 0 if Disability !=3 & Disability !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if Disability==4
replace deaf_blindness = 0 if Disability !=4 & Disability !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if Disability==5
replace emotdist = 0 if Disability !=5 & Disability !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if Disability==7
replace devpmtdelay = 0 if Disability !=7 & Disability !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if Disability==8
replace hearimpair = 0 if Disability !=8 & Disability !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning Disability//
generate speclearn=.
replace speclearn =1 if Disability==11
replace speclearn = 0 if Disability !=11 & Disability !=.

label variable speclearn "Specific Learning Disability"


//Intellectual Disability-Mild//
generate intell_mild=.
replace intell_mild =1 if Disability==12
replace intell_mild = 0 if Disability !=12 & Disability !=.

label variable intell_mild "Intellectual Disability-Mild"


//Intellectual Disability-Moderate//
generate intell_mod=.
replace intell_mod =1 if Disability==13
replace intell_mod = 0 if Disability !=13 & Disability !=.

label variable intell_mod "Intellectual Disability-Moderate"


//Intellectual Disability-Severe//
generate intell_severe=.
replace intell_severe =1 if Disability==14
replace intell_severe = 0 if Disability !=14 & Disability !=.

label variable intell_severe "Intellectual Disability-Severe"



//Intellectual Disability-Profound//
generate intell_prof=.
replace intell_prof =1 if Disability==15
replace intell_prof = 0 if Disability !=15 & Disability !=.

label variable intell_prof "Intellectual Disability-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if Disability==16
replace multiple = 0 if Disability !=16 & Disability !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if Disability==17
replace multiple = 0 if Disability !=17 & Disability !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if Disability==18
replace orthopedic = 0 if Disability !=18 & Disability !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if Disability==19
replace oth_health = 0 if Disability !=19 & Disability !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if Disability==20
replace semi_visual = 0 if Disability !=20 & Disability !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if Disability==21
replace severelang = 0 if Disability !=21 & Disability !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if Disability==22
replace edhandicap = 0 if Disability !=22 & Disability !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if Disability==25
replace braininjury = 0 if Disability !=25 & Disability !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if Disability==26
replace unknown = 0 if Disability !=26 & Disability !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if Disability==27
replace gifted = 0 if Disability !=27 & Disability !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if Disability==28
replace speech_lang = 0 if Disability !=28 & Disability !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if Disability==29
replace speech_langflu = 0 if Disability !=29 & Disability !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if Disability==30
replace speech_langla = 0 if Disability !=30 & Disability !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if Disability==31
replace speech_langvo = 0 if Disability !=31 & Disability !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if Disability==32
replace talented = 0 if Disability !=32 & Disability !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if Disability==33
replace talented_thtr = 0 if Disability !=33 & Disability !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if Disability==34
replace talented_vis = 0 if Disability !=34 & Disability !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if Disability==99
replace incomplete = 0 if Disability !=99 & Disability !=.

label variable incomplete "Unable to Complete Evaluation Process"


summarize dis-incomplete



******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if Disability==2| Disability==20
replace visual_cons= 0 if  Disability !=2 & Disability!=20

label variable visual_cons "Visual Impairments Consilidated"


//Hearing Impairment-Deafness and Hearing Impariment-Hard of Hearing//
generate hearing_cons=.
replace hearing_cons = 1 if deafness==1 |hearimpair==1
replace hearing_cons= 0 if deafness!=1 & hearimpair!=1

label variable hearing_cons "Hearing Impairments Consilidated"


//Intellectual Disabiity Mild Mod, Severe, Profound//
generate intell_cons=.
replace intell_cons = 1 if intell_mild==1 | intell_mod==1 | intell_severe==1 | intell_prof==1
replace intell_cons= 0 if intell_mild!=1 & intell_mod!=1 & intell_severe!=1 & intell_prof!=1

label variable intell_con "Intellectual Disabiity Consolidated ( Mild, Mod,Severe,Profound)"

//Speech or Language Impairments Regular, Fluency, Language, Voice//
generate speech_cons=.
replace speech_cons = 1 if speech_lang==1 | speech_langflu==1 | speech_langla==1 | speech_langvo==1
replace speech_cons= 0 if speech_lang!=1 & speech_langflu!=1 & speech_langla!=1 & speech_langvo!=1

label variable speech_cons "Speech or Language Impairments Consolidated ( Regular, Fluency, Language, Voice)"


//Talented- Talented, Theater, Visual Arts//
generate talented_cons=.
replace talented_cons = 1 if talented==1 | talented_thtr==1 | talented_vis==1 
replace talented_cons= 0 if talented!=1 & talented_thtr!=1 & talented_vis!=1 

label variable talented_cons "Talented (Talented, Theater, Visual Arts)"

summarize visual_cons-talented_cons


rename * =_SIS_1112
desc

save SIS_2011-12, replace






















































clear



cd "/Volumes/USB DISK/LCSE/Posted/DataSets"

**********************************************************************
**********************************************************************
*                    YEAR 3: 2012-13                                 *
**********************************************************************
**********************************************************************

import excel "/Volumes/USB DISK/LCSE/Work/Data/SIS Enrollment Files/2012-13 SIS Enrollment.xlsx", sheet("2012-13 SIS Enrollment") firstrow


save 2012-13_SIS, replace


/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/


desc
sort GUIDNum
//SiteCd is left string to preserve leading zeros. It's nominal anyway//
destring GradePlacementCd BegSchSessYr GUIDNum FreeReducedLunchCd EnglishProficiencyCd Disability, replace

generate Year3=1
save SIS_2012-13, replace



*******************************************	
/*Create Gender Dummy Variables*/
encode SexCd, generate(gender)
tab gender

	generate female=.
	replace female=0 if gender==2
	replace female=1 if gender==1

	
	
	
*******************************************	
/*Create Race/Ethnicity Dummy Variables*/

encode FedRaceEthnicityCd, generate(race)
tab race

//American Indian or Alaskan
generate AM=.
replace AM=1 if race==1
replace AM=0 if race!=1 & race!=.
label variable AM "American Indian or Alaskan"

//Asian//
generate AS=.
replace AS=1 if race==2
replace AS=0 if race!=2 & race!=.
label variable AS "Asian"


//Black or African American//
generate BL=.
replace BL=1 if race==3
replace BL=0 if race!=3 & race!=.
label variable BL "Black or African American"


//Hispanic or Latino//
generate HI=.
replace HI=1 if race==4
replace HI=0 if race!=4 & race!=.
label variable HI "Hispanic or Latino"


//Two or More//
generate MU=.
replace MU=1 if race==5
replace MU=0 if race!=5 & race!=.
label variable MU "Two or more races"

//Native Hawaiian or Pacific Islander//
generate PI=.
replace PI=1 if race==6
replace PI=0 if race!=6 & race!=.
label variable PI "Native Hawaiian or Pacific Islander"

//White//
generate WH=.
replace WH=1 if race==7
replace WH=0 if race!=7 & race!=.
label variable WH "White"

summarize AM-WH




*******************************************************
/*Create Free and Reduced Price Lunch Dummy Variables*/
tab FreeReducedLunchCd

generate FRPL=.
replace FRPL =1 if FreeReducedLunchCd==1 | FreeReducedLunchCd==2
replace FRPL=0 if FreeReducedLunchCd !=. & FreeReducedLunchCd !=1 & FreeReducedLunchCd!=2

label variable FRPL "Receives Free OR Reduced Price Lunch"
list FreeReducedLunchCd FRPL if _n<=20

	generate FreeLunch=.
	replace FreeLunch =1 if FreeReducedLunchCd==1
	replace FreeLunch=0 if FreeReducedLunchCd ==2

		label variable FreeLunch "Free Lunch"

		
	generate RedLunch=.
	replace RedLunch =1 if FreeReducedLunchCd==2
	replace RedLunch=0 if FreeReducedLunchCd ==1 

		label variable RedLunch "Reduced Price Price Lunch"
	
		
	
summarize FreeReducedLunchCd FRPL FreeLunch RedLunch	


*******************************************************
/*Create English Proficiency Dummy Variables*/
tab EnglishProficiencyCd

	generate engprof=.
	replace engprof =1 if EnglishProficiencyCd==1
	replace engprof=0 if EnglishProficiencyCd ==2

		label variable engprof "Full English Proficiency"
		list EnglishProficiencyCd engprof if _n<=10


summarize EnglishProficiencyCd engprof



*******************************************	
/*Create Grade Level Dummy Variables*/



tab GradePlacementCd


generate FIRST=.
	replace FIRST = 1 if  GradePlacementCd==1
	replace FIRST = 0 if (GradePlacementCd !=1 & GradePlacementCd!=.)
	

generate SECOND=.
	replace SECOND = 1 if  GradePlacementCd==2
	replace SECOND = 0 if (GradePlacementCd !=2 & GradePlacementCd!=.)


generate THIRD=.
	replace THIRD = 1 if  GradePlacementCd==3
	replace THIRD = 0 if (GradePlacementCd !=3 & GradePlacementCd!=.)


generate FOURTH=.
	replace FOURTH = 1 if  GradePlacementCd==4
	replace FOURTH = 0 if (GradePlacementCd !=4 & GradePlacementCd!=.)
	
	
generate FIFTH=.
	replace FIFTH = 1 if  GradePlacementCd==5
	replace FIFTH = 0 if (GradePlacementCd !=5 & GradePlacementCd!=.)
	
	
generate SIXTH=.
	replace SIXTH = 1 if  GradePlacementCd==6
	replace SIXTH = 0 if (GradePlacementCd !=6 & GradePlacementCd!=.)
	
generate SEVENTH=.
	replace SEVENTH = 1 if  GradePlacementCd==7
	replace SEVENTH = 0 if (GradePlacementCd !=7 & GradePlacementCd!=.)
	

generate EIGHTH=.
	replace EIGHTH = 1 if  GradePlacementCd==8
	replace EIGHTH = 0 if (GradePlacementCd !=8 & GradePlacementCd!=.)
	

generate NINTH=.
	replace NINTH = 1 if  GradePlacementCd==9
	replace NINTH = 0 if (GradePlacementCd !=9 & GradePlacementCd!=.)
	

generate TENTH=.
	replace TENTH = 1 if  GradePlacementCd==10
	replace TENTH = 0 if (GradePlacementCd !=10 & GradePlacementCd!=.)
	
	
generate ELEVENTH=.
	replace ELEVENTH = 1 if  GradePlacementCd==11
	replace ELEVENTH = 0 if (GradePlacementCd !=11 & GradePlacementCd!=.)
	

generate TWELFTH=.
	replace TWELFTH = 1 if  GradePlacementCd==12
	replace TWELFTH = 0 if (GradePlacementCd !=12 & GradePlacementCd!=.)
	

generate INFANTPGRM=.
	replace INFANTPGRM = 1 if  GradePlacementCd==15
	replace INFANTPGRM = 0 if (GradePlacementCd !=15 & GradePlacementCd!=.)

	
generate PRESCHOOL=.
	replace PRESCHOOL = 1 if  GradePlacementCd==20
	replace PRESCHOOL = 0 if (GradePlacementCd !=20 & GradePlacementCd!=.)
	

generate PREK3=.
	replace PREK3 = 1 if  GradePlacementCd==22
	replace PREK3 = 0 if (GradePlacementCd !=22 & GradePlacementCd!=.)
	

generate PREK4=.
	replace PREK4 = 1 if  GradePlacementCd==24
	replace PREK4 = 0 if (GradePlacementCd !=24 & GradePlacementCd!=.)
	
	
generate KINDER=.
	replace KINDER = 1 if  GradePlacementCd==25
	replace KINDER = 0 if (GradePlacementCd !=25 & GradePlacementCd!=.)
	
	

tab GradePlacementCd
summarize FIRST-KINDER	

/*CONSOLIDATE GRADE CATEGORIES*/

			generate prek=.
				replace prek = 1 if (GradePlacementCd==15| GradePlacementCd==20 |GradePlacementCd==22| GradePlacementCd==24)
				replace prek = 0 if (GradePlacementCd !=15 & GradePlacementCd !=20 & GradePlacementCd !=22 & GradePlacementCd !=24 & GradePlacementCd!=.)

			generate elementary=.
				replace elementary = 1 if (GradePlacementCd==1| GradePlacementCd==2 |GradePlacementCd==3| GradePlacementCd==4| GradePlacementCd==5|GradePlacementCd==25)
				replace elementary = 0 if (GradePlacementCd !=1 & GradePlacementCd !=2 & GradePlacementCd !=3 & GradePlacementCd !=4 & GradePlacementCd !=5 & GradePlacementCd !=25 & GradePlacementCd!=.)
			label variable elementary "Elementary (K-5)"
				

			generate middle=.
				replace middle = 1 if (GradePlacementCd==6| GradePlacementCd==7 |GradePlacementCd==8)
				replace middle = 0 if (GradePlacementCd !=6 & GradePlacementCd !=7 & GradePlacementCd !=8 & GradePlacementCd!=.)
			label variable middle "Middle School (6-8)"

				
			generate high=.
				replace high = 1 if (GradePlacementCd==9| GradePlacementCd==10 |GradePlacementCd==11 | GradePlacementCd==12)
				replace high = 0 if (GradePlacementCd !=9 & GradePlacementCd !=10 & GradePlacementCd !=11 & GradePlacementCd!=12 & GradePlacementCd!=.)
			label variable high "High School (9-12)"
				
summarize prek elementary middle high




**************************************************
/*Create Dummy Variables for each Exceptionality*/
sort Disability
tab Disability


generate dis=.
replace dis = 1 if Disability !=. & Disability !=24
replace dis = 0 if Disability !=. & Disability==24



summarize Disability dis

//autism//
generate autism=.
replace autism =1 if Disability==1
replace autism = 0 if Disability !=1 & Disability !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if Disability==2
replace blindness = 0 if Disability !=2 & Disability !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if Disability==3
replace deafness = 0 if Disability !=3 & Disability !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if Disability==4
replace deaf_blindness = 0 if Disability !=4 & Disability !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if Disability==5
replace emotdist = 0 if Disability !=5 & Disability !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if Disability==7
replace devpmtdelay = 0 if Disability !=7 & Disability !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if Disability==8
replace hearimpair = 0 if Disability !=8 & Disability !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning Disability//
generate speclearn=.
replace speclearn =1 if Disability==11
replace speclearn = 0 if Disability !=11 & Disability !=.

label variable speclearn "Specific Learning Disability"


//Intellectual Disability-Mild//
generate intell_mild=.
replace intell_mild =1 if Disability==12
replace intell_mild = 0 if Disability !=12 & Disability !=.

label variable intell_mild "Intellectual Disability-Mild"


//Intellectual Disability-Moderate//
generate intell_mod=.
replace intell_mod =1 if Disability==13
replace intell_mod = 0 if Disability !=13 & Disability !=.

label variable intell_mod "Intellectual Disability-Moderate"


//Intellectual Disability-Severe//
generate intell_severe=.
replace intell_severe =1 if Disability==14
replace intell_severe = 0 if Disability !=14 & Disability !=.

label variable intell_severe "Intellectual Disability-Severe"



//Intellectual Disability-Profound//
generate intell_prof=.
replace intell_prof =1 if Disability==15
replace intell_prof = 0 if Disability !=15 & Disability !=.

label variable intell_prof "Intellectual Disability-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if Disability==16
replace multiple = 0 if Disability !=16 & Disability !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if Disability==17
replace multiple = 0 if Disability !=17 & Disability !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if Disability==18
replace orthopedic = 0 if Disability !=18 & Disability !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if Disability==19
replace oth_health = 0 if Disability !=19 & Disability !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if Disability==20
replace semi_visual = 0 if Disability !=20 & Disability !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if Disability==21
replace severelang = 0 if Disability !=21 & Disability !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if Disability==22
replace edhandicap = 0 if Disability !=22 & Disability !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if Disability==25
replace braininjury = 0 if Disability !=25 & Disability !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if Disability==26
replace unknown = 0 if Disability !=26 & Disability !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if Disability==27
replace gifted = 0 if Disability !=27 & Disability !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if Disability==28
replace speech_lang = 0 if Disability !=28 & Disability !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if Disability==29
replace speech_langflu = 0 if Disability !=29 & Disability !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if Disability==30
replace speech_langla = 0 if Disability !=30 & Disability !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if Disability==31
replace speech_langvo = 0 if Disability !=31 & Disability !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if Disability==32
replace talented = 0 if Disability !=32 & Disability !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if Disability==33
replace talented_thtr = 0 if Disability !=33 & Disability !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if Disability==34
replace talented_vis = 0 if Disability !=34 & Disability !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if Disability==99
replace incomplete = 0 if Disability !=99 & Disability !=.

label variable incomplete "Unable to Complete Evaluation Process"


summarize dis-incomplete


save SIS_2012-13, replace


******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if Disability==2| Disability==20
replace visual_cons= 0 if  Disability !=2 & Disability!=20

label variable visual_cons "Visual Impairments Consilidated"


//Hearing Impairment-Deafness and Hearing Impariment-Hard of Hearing//
generate hearing_cons=.
replace hearing_cons = 1 if deafness==1 |hearimpair==1
replace hearing_cons= 0 if deafness!=1 & hearimpair!=1

label variable hearing_cons "Hearing Impairments Consilidated"


//Intellectual Disabiity Mild Mod, Severe, Profound//
generate intell_cons=.
replace intell_cons = 1 if intell_mild==1 | intell_mod==1 | intell_severe==1 | intell_prof==1
replace intell_cons= 0 if intell_mild!=1 & intell_mod!=1 & intell_severe!=1 & intell_prof!=1

label variable intell_con "Intellectual Disabiity Consolidated ( Mild, Mod,Severe,Profound)"

//Speech or Language Impairments Regular, Fluency, Language, Voice//
generate speech_cons=.
replace speech_cons = 1 if speech_lang==1 | speech_langflu==1 | speech_langla==1 | speech_langvo==1
replace speech_cons= 0 if speech_lang!=1 & speech_langflu!=1 & speech_langla!=1 & speech_langvo!=1

label variable speech_cons "Speech or Language Impairments Consolidated ( Regular, Fluency, Language, Voice)"


//Talented- Talented, Theater, Visual Arts//
generate talented_cons=.
replace talented_cons = 1 if talented==1 | talented_thtr==1 | talented_vis==1 
replace talented_cons= 0 if talented!=1 & talented_thtr!=1 & talented_vis!=1 

label variable talented_cons "Talented (Talented, Theater, Visual Arts)"

summarize visual_cons-talented_cons


rename * =_SIS_1213
desc

save SIS_2012-13, replace









































clear



cd "/Volumes/USB DISK/LCSE/Posted/DataSets"

**********************************************************************
**********************************************************************
*                    YEAR 4: 2013-14                                 *
**********************************************************************
**********************************************************************

import excel "/Volumes/USB DISK/LCSE/Work/Data/SIS Enrollment Files/2013-14 SIS Enrollment.xlsx", sheet("2013-14 SIS Enrollment") firstrow


save 2013-14_SIS, replace


/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/


desc
sort GUIDNum
//SiteCd is left string to preserve leading zeros. It's nominal anyway//
destring GradePlacementCd BegSchSessYr GUIDNum FreeReducedLunchCd EnglishProficiencyCd Disability, replace

generate Year4=1
save SIS_2013-14, replace



*******************************************	
/*Create Gender Dummy Variables*/
encode SexCd, generate(gender)
tab gender

	generate female=.
	replace female=0 if gender==2
	replace female=1 if gender==1

	
	
	
*******************************************	
/*Create Race/Ethnicity Dummy Variables*/

encode FedRaceEthnicityCd, generate(race)
tab race

//American Indian or Alaskan
generate AM=.
replace AM=1 if race==1
replace AM=0 if race!=1 & race!=.
label variable AM "American Indian or Alaskan"

//Asian//
generate AS=.
replace AS=1 if race==2
replace AS=0 if race!=2 & race!=.
label variable AS "Asian"


//Black or African American//
generate BL=.
replace BL=1 if race==3
replace BL=0 if race!=3 & race!=.
label variable BL "Black or African American"


//Hispanic or Latino//
generate HI=.
replace HI=1 if race==4
replace HI=0 if race!=4 & race!=.
label variable HI "Hispanic or Latino"


//Two or More//
generate MU=.
replace MU=1 if race==5
replace MU=0 if race!=5 & race!=.
label variable MU "Two or more races"

//Native Hawaiian or Pacific Islander//
generate PI=.
replace PI=1 if race==6
replace PI=0 if race!=6 & race!=.
label variable PI "Native Hawaiian or Pacific Islander"

//White//
generate WH=.
replace WH=1 if race==7
replace WH=0 if race!=7 & race!=.
label variable WH "White"

summarize AM-WH




*******************************************************
/*Create Free and Reduced Price Lunch Dummy Variables*/
tab FreeReducedLunchCd

generate FRPL=.
replace FRPL =1 if FreeReducedLunchCd==1 | FreeReducedLunchCd==2
replace FRPL=0 if FreeReducedLunchCd !=. & FreeReducedLunchCd !=1 & FreeReducedLunchCd!=2

label variable FRPL "Receives Free OR Reduced Price Lunch"
list FreeReducedLunchCd FRPL if _n<=20

	generate FreeLunch=.
	replace FreeLunch =1 if FreeReducedLunchCd==1
	replace FreeLunch=0 if FreeReducedLunchCd ==2

		label variable FreeLunch "Free Lunch"

		
	generate RedLunch=.
	replace RedLunch =1 if FreeReducedLunchCd==2
	replace RedLunch=0 if FreeReducedLunchCd ==1 

		label variable RedLunch "Reduced Price Price Lunch"
	
		
	
summarize FreeReducedLunchCd FRPL FreeLunch RedLunch	


*******************************************************
/*Create English Proficiency Dummy Variables*/
tab EnglishProficiencyCd

	generate engprof=.
	replace engprof =1 if EnglishProficiencyCd==1
	replace engprof=0 if EnglishProficiencyCd ==2

		label variable engprof "Full English Proficiency"
		list EnglishProficiencyCd engprof if _n<=10


summarize EnglishProficiencyCd engprof



*******************************************	
/*Create Grade Level Dummy Variables*/



tab GradePlacementCd


generate FIRST=.
	replace FIRST = 1 if  GradePlacementCd==1
	replace FIRST = 0 if (GradePlacementCd !=1 & GradePlacementCd!=.)
	

generate SECOND=.
	replace SECOND = 1 if  GradePlacementCd==2
	replace SECOND = 0 if (GradePlacementCd !=2 & GradePlacementCd!=.)


generate THIRD=.
	replace THIRD = 1 if  GradePlacementCd==3
	replace THIRD = 0 if (GradePlacementCd !=3 & GradePlacementCd!=.)


generate FOURTH=.
	replace FOURTH = 1 if  GradePlacementCd==4
	replace FOURTH = 0 if (GradePlacementCd !=4 & GradePlacementCd!=.)
	
	
generate FIFTH=.
	replace FIFTH = 1 if  GradePlacementCd==5
	replace FIFTH = 0 if (GradePlacementCd !=5 & GradePlacementCd!=.)
	
	
generate SIXTH=.
	replace SIXTH = 1 if  GradePlacementCd==6
	replace SIXTH = 0 if (GradePlacementCd !=6 & GradePlacementCd!=.)
	
generate SEVENTH=.
	replace SEVENTH = 1 if  GradePlacementCd==7
	replace SEVENTH = 0 if (GradePlacementCd !=7 & GradePlacementCd!=.)
	

generate EIGHTH=.
	replace EIGHTH = 1 if  GradePlacementCd==8
	replace EIGHTH = 0 if (GradePlacementCd !=8 & GradePlacementCd!=.)
	

generate NINTH=.
	replace NINTH = 1 if  GradePlacementCd==9
	replace NINTH = 0 if (GradePlacementCd !=9 & GradePlacementCd!=.)
	

generate TENTH=.
	replace TENTH = 1 if  GradePlacementCd==10
	replace TENTH = 0 if (GradePlacementCd !=10 & GradePlacementCd!=.)
	
	
generate ELEVENTH=.
	replace ELEVENTH = 1 if  GradePlacementCd==11
	replace ELEVENTH = 0 if (GradePlacementCd !=11 & GradePlacementCd!=.)
	

generate TWELFTH=.
	replace TWELFTH = 1 if  GradePlacementCd==12
	replace TWELFTH = 0 if (GradePlacementCd !=12 & GradePlacementCd!=.)
	

generate INFANTPGRM=.
	replace INFANTPGRM = 1 if  GradePlacementCd==15
	replace INFANTPGRM = 0 if (GradePlacementCd !=15 & GradePlacementCd!=.)

	
generate PRESCHOOL=.
	replace PRESCHOOL = 1 if  GradePlacementCd==20
	replace PRESCHOOL = 0 if (GradePlacementCd !=20 & GradePlacementCd!=.)
	

generate PREK3=.
	replace PREK3 = 1 if  GradePlacementCd==22
	replace PREK3 = 0 if (GradePlacementCd !=22 & GradePlacementCd!=.)
	

generate PREK4=.
	replace PREK4 = 1 if  GradePlacementCd==24
	replace PREK4 = 0 if (GradePlacementCd !=24 & GradePlacementCd!=.)
	
	
generate KINDER=.
	replace KINDER = 1 if  GradePlacementCd==25
	replace KINDER = 0 if (GradePlacementCd !=25 & GradePlacementCd!=.)
	
	

tab GradePlacementCd
summarize FIRST-KINDER	

/*CONSOLIDATE GRADE CATEGORIES*/

			generate prek=.
				replace prek = 1 if (GradePlacementCd==15| GradePlacementCd==20 |GradePlacementCd==22| GradePlacementCd==24)
				replace prek = 0 if (GradePlacementCd !=15 & GradePlacementCd !=20 & GradePlacementCd !=22 & GradePlacementCd !=24 & GradePlacementCd!=.)

			generate elementary=.
				replace elementary = 1 if (GradePlacementCd==1| GradePlacementCd==2 |GradePlacementCd==3| GradePlacementCd==4| GradePlacementCd==5|GradePlacementCd==25)
				replace elementary = 0 if (GradePlacementCd !=1 & GradePlacementCd !=2 & GradePlacementCd !=3 & GradePlacementCd !=4 & GradePlacementCd !=5 & GradePlacementCd !=25 & GradePlacementCd!=.)
			label variable elementary "Elementary (K-5)"
				

			generate middle=.
				replace middle = 1 if (GradePlacementCd==6| GradePlacementCd==7 |GradePlacementCd==8)
				replace middle = 0 if (GradePlacementCd !=6 & GradePlacementCd !=7 & GradePlacementCd !=8 & GradePlacementCd!=.)
			label variable middle "Middle School (6-8)"

				
			generate high=.
				replace high = 1 if (GradePlacementCd==9| GradePlacementCd==10 |GradePlacementCd==11 | GradePlacementCd==12)
				replace high = 0 if (GradePlacementCd !=9 & GradePlacementCd !=10 & GradePlacementCd !=11 & GradePlacementCd!=12 & GradePlacementCd!=.)
			label variable high "High School (9-12)"
				
summarize prek elementary middle high




**************************************************
/*Create Dummy Variables for each Exceptionality*/
sort Disability
tab Disability


generate dis=.
replace dis = 1 if Disability !=. & Disability !=24
replace dis = 0 if Disability !=. & Disability==24



summarize Disability dis

//autism//
generate autism=.
replace autism =1 if Disability==1
replace autism = 0 if Disability !=1 & Disability !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if Disability==2
replace blindness = 0 if Disability !=2 & Disability !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if Disability==3
replace deafness = 0 if Disability !=3 & Disability !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if Disability==4
replace deaf_blindness = 0 if Disability !=4 & Disability !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if Disability==5
replace emotdist = 0 if Disability !=5 & Disability !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if Disability==7
replace devpmtdelay = 0 if Disability !=7 & Disability !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if Disability==8
replace hearimpair = 0 if Disability !=8 & Disability !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning Disability//
generate speclearn=.
replace speclearn =1 if Disability==11
replace speclearn = 0 if Disability !=11 & Disability !=.

label variable speclearn "Specific Learning Disability"


//Intellectual Disability-Mild//
generate intell_mild=.
replace intell_mild =1 if Disability==12
replace intell_mild = 0 if Disability !=12 & Disability !=.

label variable intell_mild "Intellectual Disability-Mild"


//Intellectual Disability-Moderate//
generate intell_mod=.
replace intell_mod =1 if Disability==13
replace intell_mod = 0 if Disability !=13 & Disability !=.

label variable intell_mod "Intellectual Disability-Moderate"


//Intellectual Disability-Severe//
generate intell_severe=.
replace intell_severe =1 if Disability==14
replace intell_severe = 0 if Disability !=14 & Disability !=.

label variable intell_severe "Intellectual Disability-Severe"



//Intellectual Disability-Profound//
generate intell_prof=.
replace intell_prof =1 if Disability==15
replace intell_prof = 0 if Disability !=15 & Disability !=.

label variable intell_prof "Intellectual Disability-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if Disability==16
replace multiple = 0 if Disability !=16 & Disability !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if Disability==17
replace multiple = 0 if Disability !=17 & Disability !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if Disability==18
replace orthopedic = 0 if Disability !=18 & Disability !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if Disability==19
replace oth_health = 0 if Disability !=19 & Disability !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if Disability==20
replace semi_visual = 0 if Disability !=20 & Disability !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if Disability==21
replace severelang = 0 if Disability !=21 & Disability !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if Disability==22
replace edhandicap = 0 if Disability !=22 & Disability !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if Disability==25
replace braininjury = 0 if Disability !=25 & Disability !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if Disability==26
replace unknown = 0 if Disability !=26 & Disability !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if Disability==27
replace gifted = 0 if Disability !=27 & Disability !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if Disability==28
replace speech_lang = 0 if Disability !=28 & Disability !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if Disability==29
replace speech_langflu = 0 if Disability !=29 & Disability !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if Disability==30
replace speech_langla = 0 if Disability !=30 & Disability !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if Disability==31
replace speech_langvo = 0 if Disability !=31 & Disability !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if Disability==32
replace talented = 0 if Disability !=32 & Disability !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if Disability==33
replace talented_thtr = 0 if Disability !=33 & Disability !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if Disability==34
replace talented_vis = 0 if Disability !=34 & Disability !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if Disability==99
replace incomplete = 0 if Disability !=99 & Disability !=.

label variable incomplete "Unable to Complete Evaluation Process"


summarize dis-incomplete


save SIS_2013-14, replace


******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if Disability==2| Disability==20
replace visual_cons= 0 if  Disability !=2 & Disability!=20

label variable visual_cons "Visual Impairments Consilidated"


//Hearing Impairment-Deafness and Hearing Impariment-Hard of Hearing//
generate hearing_cons=.
replace hearing_cons = 1 if deafness==1 |hearimpair==1
replace hearing_cons= 0 if deafness!=1 & hearimpair!=1

label variable hearing_cons "Hearing Impairments Consilidated"


//Intellectual Disabiity Mild Mod, Severe, Profound//
generate intell_cons=.
replace intell_cons = 1 if intell_mild==1 | intell_mod==1 | intell_severe==1 | intell_prof==1
replace intell_cons= 0 if intell_mild!=1 & intell_mod!=1 & intell_severe!=1 & intell_prof!=1

label variable intell_con "Intellectual Disabiity Consolidated ( Mild, Mod,Severe,Profound)"

//Speech or Language Impairments Regular, Fluency, Language, Voice//
generate speech_cons=.
replace speech_cons = 1 if speech_lang==1 | speech_langflu==1 | speech_langla==1 | speech_langvo==1
replace speech_cons= 0 if speech_lang!=1 & speech_langflu!=1 & speech_langla!=1 & speech_langvo!=1

label variable speech_cons "Speech or Language Impairments Consolidated ( Regular, Fluency, Language, Voice)"


//Talented- Talented, Theater, Visual Arts//
generate talented_cons=.
replace talented_cons = 1 if talented==1 | talented_thtr==1 | talented_vis==1 
replace talented_cons= 0 if talented!=1 & talented_thtr!=1 & talented_vis!=1 

label variable talented_cons "Talented (Talented, Theater, Visual Arts)"

summarize visual_cons-talented_cons


rename * =_SIS_1314
desc

save SIS_2013-14, replace

