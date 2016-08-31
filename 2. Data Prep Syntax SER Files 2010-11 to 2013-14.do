

clear


*****************************************
*****************************************
*****************************************
*Data Prep 4.15 LA Charters SpED Study	*
*           2010-11 to 2013-14 		    *
*****************************************
*****************************************
*****************************************



cd "/Volumes/USB DISK/LCSE/Posted/DataSets"

**********************************************************************
**********************************************************************
*                    YEAR 1: 2010-11                                 *
**********************************************************************
**********************************************************************


import excel "/Volumes/USB DISK/LCSE/Work/Data/2010-11 to 2013-14 SER Special Ed Exit Summary.xlsx", sheet("10-11") firstrow

save 2010-11_SER, replace



/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/

desc
sort GuidNum
rename (GuidNum) (GUIDNum)


/*FORMAT DATES*/
//EXIT DATE//
generate year=substr(SpecialEdExitDate,1,4)
generate month=substr(SpecialEdExitDate,5,2)
generate day=substr(SpecialEdExitDate,7,2)

	generate e = (month + "/" + day + "/" + year)
	generate exit_date=date(e, "MDY")
	format exit_date %tdnn/dd/CCYY

//COUNT DATE
generate year1=substr(CountDate,1,4)
generate month1=substr(CountDate,5,2)
generate day1=substr(CountDate,7,2)

	generate c = (month1 + "/" + day1 + "/" + year1)
	generate count_date=date(c, "MDY")
	format count_date %tdnn/dd/CCYY

drop CountDate	SpecialEdExitDate year month day e year1 month1 day1 c Gender FedRaceEthnicityCode

destring GUIDNum SponsorCd SpecialEdExitCode, replace

order GUIDNum SponsorCd  count_date SiteCd SpecialEdExitCode exit_date    






*******************************************	
/*Create Exception Code Exit Variables Dummy Variables*/

sort SpecialEdExitCode
tab SpecialEdExitCode


generate dis=.
replace dis = 1 if SpecialEdExitCode !=. & SpecialEdExitCode !=24
replace dis = 0 if SpecialEdExitCode !=. & SpecialEdExitCode==24





//autism//
generate autism=.
replace autism =1 if SpecialEdExitCode==1
replace autism = 0 if SpecialEdExitCode !=1 & SpecialEdExitCode !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if SpecialEdExitCode==2
replace blindness = 0 if SpecialEdExitCode !=2 & SpecialEdExitCode !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if SpecialEdExitCode==3
replace deafness = 0 if SpecialEdExitCode !=3 & SpecialEdExitCode !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if SpecialEdExitCode==4
replace deaf_blindness = 0 if SpecialEdExitCode !=4 & SpecialEdExitCode !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if SpecialEdExitCode==5
replace emotdist = 0 if SpecialEdExitCode !=5 & SpecialEdExitCode !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if SpecialEdExitCode==7
replace devpmtdelay = 0 if SpecialEdExitCode !=7 & SpecialEdExitCode !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if SpecialEdExitCode==8
replace hearimpair = 0 if SpecialEdExitCode !=8 & SpecialEdExitCode !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning SpecialEdExitCode//
generate speclearn=.
replace speclearn =1 if SpecialEdExitCode==11
replace speclearn = 0 if SpecialEdExitCode !=11 & SpecialEdExitCode !=.

label variable speclearn "Specific Learning SpecialEdExitCode"


//Intellectual SpecialEdExitCode-Mild//
generate intell_mild=.
replace intell_mild =1 if SpecialEdExitCode==12
replace intell_mild = 0 if SpecialEdExitCode !=12 & SpecialEdExitCode !=.

label variable intell_mild "Intellectual SpecialEdExitCode-Mild"


//Intellectual SpecialEdExitCode-Moderate//
generate intell_mod=.
replace intell_mod =1 if SpecialEdExitCode==13
replace intell_mod = 0 if SpecialEdExitCode !=13 & SpecialEdExitCode !=.

label variable intell_mod "Intellectual SpecialEdExitCode-Moderate"


//Intellectual SpecialEdExitCode-Severe//
generate intell_severe=.
replace intell_severe =1 if SpecialEdExitCode==14
replace intell_severe = 0 if SpecialEdExitCode !=14 & SpecialEdExitCode !=.

label variable intell_severe "Intellectual SpecialEdExitCode-Severe"



//Intellectual SpecialEdExitCode-Profound//
generate intell_prof=.
replace intell_prof =1 if SpecialEdExitCode==15
replace intell_prof = 0 if SpecialEdExitCode !=15 & SpecialEdExitCode !=.

label variable intell_prof "Intellectual SpecialEdExitCode-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if SpecialEdExitCode==16
replace multiple = 0 if SpecialEdExitCode !=16 & SpecialEdExitCode !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if SpecialEdExitCode==17
replace multiple = 0 if SpecialEdExitCode !=17 & SpecialEdExitCode !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if SpecialEdExitCode==18
replace orthopedic = 0 if SpecialEdExitCode !=18 & SpecialEdExitCode !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if SpecialEdExitCode==19
replace oth_health = 0 if SpecialEdExitCode !=19 & SpecialEdExitCode !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if SpecialEdExitCode==20
replace semi_visual = 0 if SpecialEdExitCode !=20 & SpecialEdExitCode !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if SpecialEdExitCode==21
replace severelang = 0 if SpecialEdExitCode !=21 & SpecialEdExitCode !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if SpecialEdExitCode==22
replace edhandicap = 0 if SpecialEdExitCode !=22 & SpecialEdExitCode !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if SpecialEdExitCode==25
replace braininjury = 0 if SpecialEdExitCode !=25 & SpecialEdExitCode !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if SpecialEdExitCode==26
replace unknown = 0 if SpecialEdExitCode !=26 & SpecialEdExitCode !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if SpecialEdExitCode==27
replace gifted = 0 if SpecialEdExitCode !=27 & SpecialEdExitCode !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if SpecialEdExitCode==28
replace speech_lang = 0 if SpecialEdExitCode !=28 & SpecialEdExitCode !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if SpecialEdExitCode==29
replace speech_langflu = 0 if SpecialEdExitCode !=29 & SpecialEdExitCode !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if SpecialEdExitCode==30
replace speech_langla = 0 if SpecialEdExitCode !=30 & SpecialEdExitCode !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if SpecialEdExitCode==31
replace speech_langvo = 0 if SpecialEdExitCode !=31 & SpecialEdExitCode !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if SpecialEdExitCode==32
replace talented = 0 if SpecialEdExitCode !=32 & SpecialEdExitCode !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if SpecialEdExitCode==33
replace talented_thtr = 0 if SpecialEdExitCode !=33 & SpecialEdExitCode !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if SpecialEdExitCode==34
replace talented_vis = 0 if SpecialEdExitCode !=34 & SpecialEdExitCode !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if SpecialEdExitCode==99
replace incomplete = 0 if SpecialEdExitCode !=99 & SpecialEdExitCode !=.

label variable incomplete "Unable to Complete Evaluation Process"


******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if SpecialEdExitCode==2| SpecialEdExitCode==20
replace visual_cons= 0 if  SpecialEdExitCode !=2 & SpecialEdExitCode!=20

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




rename * =_SER_1011
desc

save SER_2010-11, replace








































clear
cd "/Volumes/USB DISK/LCSE/Posted/DataSets"

**********************************************************************
**********************************************************************
*                    YEAR 2: 2011-12                                 *
**********************************************************************
**********************************************************************


import excel "/Volumes/USB DISK/LCSE/Work/Data/2010-11 to 2013-14 SER Special Ed Exit Summary.xlsx", sheet("11-12") firstrow

save 2011-12_SER, replace



/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/

desc
sort GuidNum
rename (GuidNum) (GUIDNum)


/*FORMAT DATES*/
//EXIT DATE//
generate year=substr(SpecialEdExitDate,1,4)
generate month=substr(SpecialEdExitDate,5,2)
generate day=substr(SpecialEdExitDate,7,2)

	generate e = (month + "/" + day + "/" + year)
	generate exit_date=date(e, "MDY")
	format exit_date %tdnn/dd/CCYY

//COUNT DATE
generate year1=substr(CountDate,1,4)
generate month1=substr(CountDate,5,2)
generate day1=substr(CountDate,7,2)

	generate c = (month1 + "/" + day1 + "/" + year1)
	generate count_date=date(c, "MDY")
	format count_date %tdnn/dd/CCYY

drop CountDate	SpecialEdExitDate year month day e year1 month1 day1 c Gender FedRaceEthnicityCode

destring GUIDNum SponsorCd SpecialEdExitCode, replace

order GUIDNum SponsorCd  count_date SiteCd SpecialEdExitCode exit_date    




*******************************************	
/*Create Exception Code Exit Variables Dummy Variables*/

sort SpecialEdExitCode
tab SpecialEdExitCode


generate dis=.
replace dis = 1 if SpecialEdExitCode !=. & SpecialEdExitCode !=24
replace dis = 0 if SpecialEdExitCode !=. & SpecialEdExitCode==24


//autism//
generate autism=.
replace autism =1 if SpecialEdExitCode==1
replace autism = 0 if SpecialEdExitCode !=1 & SpecialEdExitCode !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if SpecialEdExitCode==2
replace blindness = 0 if SpecialEdExitCode !=2 & SpecialEdExitCode !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if SpecialEdExitCode==3
replace deafness = 0 if SpecialEdExitCode !=3 & SpecialEdExitCode !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if SpecialEdExitCode==4
replace deaf_blindness = 0 if SpecialEdExitCode !=4 & SpecialEdExitCode !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if SpecialEdExitCode==5
replace emotdist = 0 if SpecialEdExitCode !=5 & SpecialEdExitCode !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if SpecialEdExitCode==7
replace devpmtdelay = 0 if SpecialEdExitCode !=7 & SpecialEdExitCode !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if SpecialEdExitCode==8
replace hearimpair = 0 if SpecialEdExitCode !=8 & SpecialEdExitCode !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning SpecialEdExitCode//
generate speclearn=.
replace speclearn =1 if SpecialEdExitCode==11
replace speclearn = 0 if SpecialEdExitCode !=11 & SpecialEdExitCode !=.

label variable speclearn "Specific Learning SpecialEdExitCode"


//Intellectual SpecialEdExitCode-Mild//
generate intell_mild=.
replace intell_mild =1 if SpecialEdExitCode==12
replace intell_mild = 0 if SpecialEdExitCode !=12 & SpecialEdExitCode !=.

label variable intell_mild "Intellectual SpecialEdExitCode-Mild"


//Intellectual SpecialEdExitCode-Moderate//
generate intell_mod=.
replace intell_mod =1 if SpecialEdExitCode==13
replace intell_mod = 0 if SpecialEdExitCode !=13 & SpecialEdExitCode !=.

label variable intell_mod "Intellectual SpecialEdExitCode-Moderate"


//Intellectual SpecialEdExitCode-Severe//
generate intell_severe=.
replace intell_severe =1 if SpecialEdExitCode==14
replace intell_severe = 0 if SpecialEdExitCode !=14 & SpecialEdExitCode !=.

label variable intell_severe "Intellectual SpecialEdExitCode-Severe"



//Intellectual SpecialEdExitCode-Profound//
generate intell_prof=.
replace intell_prof =1 if SpecialEdExitCode==15
replace intell_prof = 0 if SpecialEdExitCode !=15 & SpecialEdExitCode !=.

label variable intell_prof "Intellectual SpecialEdExitCode-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if SpecialEdExitCode==16
replace multiple = 0 if SpecialEdExitCode !=16 & SpecialEdExitCode !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if SpecialEdExitCode==17
replace multiple = 0 if SpecialEdExitCode !=17 & SpecialEdExitCode !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if SpecialEdExitCode==18
replace orthopedic = 0 if SpecialEdExitCode !=18 & SpecialEdExitCode !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if SpecialEdExitCode==19
replace oth_health = 0 if SpecialEdExitCode !=19 & SpecialEdExitCode !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if SpecialEdExitCode==20
replace semi_visual = 0 if SpecialEdExitCode !=20 & SpecialEdExitCode !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if SpecialEdExitCode==21
replace severelang = 0 if SpecialEdExitCode !=21 & SpecialEdExitCode !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if SpecialEdExitCode==22
replace edhandicap = 0 if SpecialEdExitCode !=22 & SpecialEdExitCode !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if SpecialEdExitCode==25
replace braininjury = 0 if SpecialEdExitCode !=25 & SpecialEdExitCode !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if SpecialEdExitCode==26
replace unknown = 0 if SpecialEdExitCode !=26 & SpecialEdExitCode !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if SpecialEdExitCode==27
replace gifted = 0 if SpecialEdExitCode !=27 & SpecialEdExitCode !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if SpecialEdExitCode==28
replace speech_lang = 0 if SpecialEdExitCode !=28 & SpecialEdExitCode !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if SpecialEdExitCode==29
replace speech_langflu = 0 if SpecialEdExitCode !=29 & SpecialEdExitCode !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if SpecialEdExitCode==30
replace speech_langla = 0 if SpecialEdExitCode !=30 & SpecialEdExitCode !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if SpecialEdExitCode==31
replace speech_langvo = 0 if SpecialEdExitCode !=31 & SpecialEdExitCode !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if SpecialEdExitCode==32
replace talented = 0 if SpecialEdExitCode !=32 & SpecialEdExitCode !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if SpecialEdExitCode==33
replace talented_thtr = 0 if SpecialEdExitCode !=33 & SpecialEdExitCode !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if SpecialEdExitCode==34
replace talented_vis = 0 if SpecialEdExitCode !=34 & SpecialEdExitCode !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if SpecialEdExitCode==99
replace incomplete = 0 if SpecialEdExitCode !=99 & SpecialEdExitCode !=.

label variable incomplete "Unable to Complete Evaluation Process"


******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if SpecialEdExitCode==2| SpecialEdExitCode==20
replace visual_cons= 0 if  SpecialEdExitCode !=2 & SpecialEdExitCode!=20

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




rename * =_SER_1112
desc

save SER_2011-12, replace










































clear
cd "/Volumes/USB DISK/LCSE/Posted/DataSets"

**********************************************************************
**********************************************************************
*                    YEAR 3: 2012-13                                 *
**********************************************************************
**********************************************************************


import excel "/Volumes/USB DISK/LCSE/Work/Data/2010-11 to 2013-14 SER Special Ed Exit Summary.xlsx", sheet("13-14") firstrow

save 2012-13_SER, replace

/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/

desc
sort GuidNum
rename (GuidNum) (GUIDNum)


/*FORMAT DATES*/
//EXIT DATE//
generate year=substr(SpecialEdExitDate,1,4)
generate month=substr(SpecialEdExitDate,5,2)
generate day=substr(SpecialEdExitDate,7,2)

	generate e = (month + "/" + day + "/" + year)
	generate exit_date=date(e, "MDY")
	format exit_date %tdnn/dd/CCYY

//COUNT DATE
generate year1=substr(CountDate,1,4)
generate month1=substr(CountDate,5,2)
generate day1=substr(CountDate,7,2)

	generate c = (month1 + "/" + day1 + "/" + year1)
	generate count_date=date(c, "MDY")
	format count_date %tdnn/dd/CCYY

drop CountDate	SpecialEdExitDate year month day e year1 month1 day1 c Gender FedRaceEthnicityCode

destring GUIDNum SponsorCd SpecialEdExitCode, replace

order GUIDNum SponsorCd  count_date SiteCd SpecialEdExitCode exit_date    






*******************************************	
/*Create Exception Code Exit Variables Dummy Variables*/

sort SpecialEdExitCode
tab SpecialEdExitCode


generate dis=.
replace dis = 1 if SpecialEdExitCode !=. & SpecialEdExitCode !=24
replace dis = 0 if SpecialEdExitCode !=. & SpecialEdExitCode==24





//autism//
generate autism=.
replace autism =1 if SpecialEdExitCode==1
replace autism = 0 if SpecialEdExitCode !=1 & SpecialEdExitCode !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if SpecialEdExitCode==2
replace blindness = 0 if SpecialEdExitCode !=2 & SpecialEdExitCode !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if SpecialEdExitCode==3
replace deafness = 0 if SpecialEdExitCode !=3 & SpecialEdExitCode !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if SpecialEdExitCode==4
replace deaf_blindness = 0 if SpecialEdExitCode !=4 & SpecialEdExitCode !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if SpecialEdExitCode==5
replace emotdist = 0 if SpecialEdExitCode !=5 & SpecialEdExitCode !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if SpecialEdExitCode==7
replace devpmtdelay = 0 if SpecialEdExitCode !=7 & SpecialEdExitCode !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if SpecialEdExitCode==8
replace hearimpair = 0 if SpecialEdExitCode !=8 & SpecialEdExitCode !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning SpecialEdExitCode//
generate speclearn=.
replace speclearn =1 if SpecialEdExitCode==11
replace speclearn = 0 if SpecialEdExitCode !=11 & SpecialEdExitCode !=.

label variable speclearn "Specific Learning SpecialEdExitCode"


//Intellectual SpecialEdExitCode-Mild//
generate intell_mild=.
replace intell_mild =1 if SpecialEdExitCode==12
replace intell_mild = 0 if SpecialEdExitCode !=12 & SpecialEdExitCode !=.

label variable intell_mild "Intellectual SpecialEdExitCode-Mild"


//Intellectual SpecialEdExitCode-Moderate//
generate intell_mod=.
replace intell_mod =1 if SpecialEdExitCode==13
replace intell_mod = 0 if SpecialEdExitCode !=13 & SpecialEdExitCode !=.

label variable intell_mod "Intellectual SpecialEdExitCode-Moderate"


//Intellectual SpecialEdExitCode-Severe//
generate intell_severe=.
replace intell_severe =1 if SpecialEdExitCode==14
replace intell_severe = 0 if SpecialEdExitCode !=14 & SpecialEdExitCode !=.

label variable intell_severe "Intellectual SpecialEdExitCode-Severe"



//Intellectual SpecialEdExitCode-Profound//
generate intell_prof=.
replace intell_prof =1 if SpecialEdExitCode==15
replace intell_prof = 0 if SpecialEdExitCode !=15 & SpecialEdExitCode !=.

label variable intell_prof "Intellectual SpecialEdExitCode-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if SpecialEdExitCode==16
replace multiple = 0 if SpecialEdExitCode !=16 & SpecialEdExitCode !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if SpecialEdExitCode==17
replace multiple = 0 if SpecialEdExitCode !=17 & SpecialEdExitCode !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if SpecialEdExitCode==18
replace orthopedic = 0 if SpecialEdExitCode !=18 & SpecialEdExitCode !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if SpecialEdExitCode==19
replace oth_health = 0 if SpecialEdExitCode !=19 & SpecialEdExitCode !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if SpecialEdExitCode==20
replace semi_visual = 0 if SpecialEdExitCode !=20 & SpecialEdExitCode !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if SpecialEdExitCode==21
replace severelang = 0 if SpecialEdExitCode !=21 & SpecialEdExitCode !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if SpecialEdExitCode==22
replace edhandicap = 0 if SpecialEdExitCode !=22 & SpecialEdExitCode !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if SpecialEdExitCode==25
replace braininjury = 0 if SpecialEdExitCode !=25 & SpecialEdExitCode !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if SpecialEdExitCode==26
replace unknown = 0 if SpecialEdExitCode !=26 & SpecialEdExitCode !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if SpecialEdExitCode==27
replace gifted = 0 if SpecialEdExitCode !=27 & SpecialEdExitCode !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if SpecialEdExitCode==28
replace speech_lang = 0 if SpecialEdExitCode !=28 & SpecialEdExitCode !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if SpecialEdExitCode==29
replace speech_langflu = 0 if SpecialEdExitCode !=29 & SpecialEdExitCode !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if SpecialEdExitCode==30
replace speech_langla = 0 if SpecialEdExitCode !=30 & SpecialEdExitCode !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if SpecialEdExitCode==31
replace speech_langvo = 0 if SpecialEdExitCode !=31 & SpecialEdExitCode !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if SpecialEdExitCode==32
replace talented = 0 if SpecialEdExitCode !=32 & SpecialEdExitCode !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if SpecialEdExitCode==33
replace talented_thtr = 0 if SpecialEdExitCode !=33 & SpecialEdExitCode !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if SpecialEdExitCode==34
replace talented_vis = 0 if SpecialEdExitCode !=34 & SpecialEdExitCode !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if SpecialEdExitCode==99
replace incomplete = 0 if SpecialEdExitCode !=99 & SpecialEdExitCode !=.

label variable incomplete "Unable to Complete Evaluation Process"


******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if SpecialEdExitCode==2| SpecialEdExitCode==20
replace visual_cons= 0 if  SpecialEdExitCode !=2 & SpecialEdExitCode!=20

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



rename * =_SER_1213
desc

save SER_2012-13, replace





























































clear
cd "/Volumes/USB DISK/LCSE/Posted/DataSets"

**********************************************************************
**********************************************************************
*                    YEAR 4: 2013-14                                 *
**********************************************************************
**********************************************************************


import excel "/Volumes/USB DISK/LCSE/Work/Data/2010-11 to 2013-14 SER Special Ed Exit Summary.xlsx", sheet("13-14") firstrow

save 2013-14_SER, replace



/* Initial Review 3ab*/
/*Destring grade placement and Recode Year Indicator*/

desc
sort GuidNum
rename (GuidNum) (GUIDNum)


/*FORMAT DATES*/
//EXIT DATE//
generate year=substr(SpecialEdExitDate,1,4)
generate month=substr(SpecialEdExitDate,5,2)
generate day=substr(SpecialEdExitDate,7,2)

	generate e = (month + "/" + day + "/" + year)
	generate exit_date=date(e, "MDY")
	format exit_date %tdnn/dd/CCYY

//COUNT DATE
generate year1=substr(CountDate,1,4)
generate month1=substr(CountDate,5,2)
generate day1=substr(CountDate,7,2)

	generate c = (month1 + "/" + day1 + "/" + year1)
	generate count_date=date(c, "MDY")
	format count_date %tdnn/dd/CCYY

drop CountDate	SpecialEdExitDate year month day e year1 month1 day1 c Gender FedRaceEthnicityCode

destring GUIDNum SponsorCd SpecialEdExitCode, replace

order GUIDNum SponsorCd  count_date SiteCd SpecialEdExitCode exit_date    






*******************************************	
/*Create Exception Code Exit Variables Dummy Variables*/

sort SpecialEdExitCode
tab SpecialEdExitCode


generate dis=.
replace dis = 1 if SpecialEdExitCode !=. & SpecialEdExitCode !=24
replace dis = 0 if SpecialEdExitCode !=. & SpecialEdExitCode==24





//autism//
generate autism=.
replace autism =1 if SpecialEdExitCode==1
replace autism = 0 if SpecialEdExitCode !=1 & SpecialEdExitCode !=.

label variable autism "Autism"

//blindness//
generate blindness=.
replace blindness =1 if SpecialEdExitCode==2
replace blindness = 0 if SpecialEdExitCode !=2 & SpecialEdExitCode !=.

label variable blindness "Visual Impairment-Blindness"

//deafness//
generate deafness=.
replace deafness =1 if SpecialEdExitCode==3
replace deafness = 0 if SpecialEdExitCode !=3 & SpecialEdExitCode !=.

label variable deafness "Hearing Impairment-Deafness"

//deaf_blindness//
generate deaf_blindness=.
replace deaf_blindness =1 if SpecialEdExitCode==4
replace deaf_blindness = 0 if SpecialEdExitCode !=4 & SpecialEdExitCode !=.

label variable deaf_blindnes "Deaf-Blindness"


//Emotional Disturbance//
generate emotdist=.
replace emotdist =1 if SpecialEdExitCode==5
replace emotdist = 0 if SpecialEdExitCode !=5 & SpecialEdExitCode !=.

label variable emotdist "Emotional Disturbance"


//Developmental Delay//
generate devpmtdelay=.
replace devpmtdelay =1 if SpecialEdExitCode==7
replace devpmtdelay = 0 if SpecialEdExitCode !=7 & SpecialEdExitCode !=.

label variable devpmtdelay "Developmental Delay"


//Hearing Impairment-Hard of Hearing//
generate hearimpair=.
replace hearimpair =1 if SpecialEdExitCode==8
replace hearimpair = 0 if SpecialEdExitCode !=8 & SpecialEdExitCode !=.

label variable hearimpair "Hearing Impairment-Hard of Hearing"



//Specific Learning SpecialEdExitCode//
generate speclearn=.
replace speclearn =1 if SpecialEdExitCode==11
replace speclearn = 0 if SpecialEdExitCode !=11 & SpecialEdExitCode !=.

label variable speclearn "Specific Learning SpecialEdExitCode"


//Intellectual SpecialEdExitCode-Mild//
generate intell_mild=.
replace intell_mild =1 if SpecialEdExitCode==12
replace intell_mild = 0 if SpecialEdExitCode !=12 & SpecialEdExitCode !=.

label variable intell_mild "Intellectual SpecialEdExitCode-Mild"


//Intellectual SpecialEdExitCode-Moderate//
generate intell_mod=.
replace intell_mod =1 if SpecialEdExitCode==13
replace intell_mod = 0 if SpecialEdExitCode !=13 & SpecialEdExitCode !=.

label variable intell_mod "Intellectual SpecialEdExitCode-Moderate"


//Intellectual SpecialEdExitCode-Severe//
generate intell_severe=.
replace intell_severe =1 if SpecialEdExitCode==14
replace intell_severe = 0 if SpecialEdExitCode !=14 & SpecialEdExitCode !=.

label variable intell_severe "Intellectual SpecialEdExitCode-Severe"



//Intellectual SpecialEdExitCode-Profound//
generate intell_prof=.
replace intell_prof =1 if SpecialEdExitCode==15
replace intell_prof = 0 if SpecialEdExitCode !=15 & SpecialEdExitCode !=.

label variable intell_prof "Intellectual SpecialEdExitCode-Profound"


//Multiple Disabilities//
generate multiple=.
replace multiple =1 if SpecialEdExitCode==16
replace multiple = 0 if SpecialEdExitCode !=16 & SpecialEdExitCode !=.

label variable multiple "Multiple Disabilities"



//Non Categorical Preschool//
generate nocatpre=.
replace multiple =1 if SpecialEdExitCode==17
replace multiple = 0 if SpecialEdExitCode !=17 & SpecialEdExitCode !=.

label variable nocatpre "Non Categorical Preschool"




//Orthopedic Impairment//
generate orthopedic=.
replace orthopedic =1 if SpecialEdExitCode==18
replace orthopedic = 0 if SpecialEdExitCode !=18 & SpecialEdExitCode !=.

label variable orthopedic "Orthopedic Impairment"


//Other Health Impairments//
generate oth_health=.
replace oth_health =1 if SpecialEdExitCode==19
replace oth_health = 0 if SpecialEdExitCode !=19 & SpecialEdExitCode !=.

label variable oth_health "Other Health Impairments"

//Visual Impairment-Partially Seeing//
generate semi_visual=.
replace semi_visual =1 if SpecialEdExitCode==20
replace semi_visual = 0 if SpecialEdExitCode !=20 & SpecialEdExitCode !=.

label variable semi_visual "Visual Impairment-Partially Seeing"


//Severe Language Disorders//
generate severelang=.
replace severelang =1 if SpecialEdExitCode==21
replace severelang = 0 if SpecialEdExitCode !=21 & SpecialEdExitCode !=.

label variable severelang "Severe Language Disorders"


//Educationally Handicapped-Slow Learning//
generate edhandicap=.
replace edhandicap =1 if SpecialEdExitCode==22
replace edhandicap = 0 if SpecialEdExitCode !=22 & SpecialEdExitCode !=.

label variable edhandicap "Educationally Handicapped-Slow Learning"


//Traumatic Brain Injury//
generate braininjury=.
replace braininjury =1 if SpecialEdExitCode==25
replace braininjury = 0 if SpecialEdExitCode !=25 & SpecialEdExitCode !=.

label variable braininjury "Traumatic Brain Injury"



//Unknown//
generate unknown=.
replace unknown =1 if SpecialEdExitCode==26
replace unknown = 0 if SpecialEdExitCode !=26 & SpecialEdExitCode !=.

label variable unknown "Unknown"


//Gifted//
generate gifted=.
replace gifted =1 if SpecialEdExitCode==27
replace gifted = 0 if SpecialEdExitCode !=27 & SpecialEdExitCode !=.

label variable gifted "Gifted"


//Speech or Language Impairments//
generate speech_lang=.
replace speech_lang =1 if SpecialEdExitCode==28
replace speech_lang = 0 if SpecialEdExitCode !=28 & SpecialEdExitCode !=.

label variable speech_lang "Speech or Language Impairments"



//Speech or Language Impairments-Fluency//
generate speech_langflu=.
replace speech_langflu =1 if SpecialEdExitCode==29
replace speech_langflu = 0 if SpecialEdExitCode !=29 & SpecialEdExitCode !=.

label variable speech_langflu "Speech or Language Impairments-Fluency"


//Speech or Language Impairments-Language//
generate speech_langla=.
replace speech_langla =1 if SpecialEdExitCode==30
replace speech_langla = 0 if SpecialEdExitCode !=30 & SpecialEdExitCode !=.

label variable speech_langla "Speech or Language Impairments-Language"



//Speech or Language Impairments-Voice//
generate speech_langvo=.
replace speech_langvo =1 if SpecialEdExitCode==31
replace speech_langvo = 0 if SpecialEdExitCode !=31 & SpecialEdExitCode !=.

label variable speech_langvo "Speech or Language Impairments-Voice"



//Talented//
generate talented=.
replace talented =1 if SpecialEdExitCode==32
replace talented = 0 if SpecialEdExitCode !=32 & SpecialEdExitCode !=.

label variable talent "Talented"


//Talented-Theater//
generate talented_thtr=.
replace talented_thtr =1 if SpecialEdExitCode==33
replace talented_thtr = 0 if SpecialEdExitCode !=33 & SpecialEdExitCode !=.

label variable talented_thtr "Talented-Theater"


//Talented-Visual Arts//
generate talented_vis=.
replace talented_vis =1 if SpecialEdExitCode==34
replace talented_vis = 0 if SpecialEdExitCode !=34 & SpecialEdExitCode !=.

label variable talented_vis "Talented-Visual Arts"



//Unable to complete evaluatoion process//
generate incomplete=.
replace incomplete =1 if SpecialEdExitCode==99
replace incomplete = 0 if SpecialEdExitCode !=99 & SpecialEdExitCode !=.

label variable incomplete "Unable to Complete Evaluation Process"


******************************************************************************

/*STEP III 1 C- Create Dummy Variables for the Categories 
on Page 18 of Proposal: Consolidate some of the exceptions*/


//Visual Impairment-Blindess and Visual Impairment- Partially Seeing//
generate visual_cons=.
replace visual_cons = 1 if SpecialEdExitCode==2| SpecialEdExitCode==20
replace visual_cons= 0 if  SpecialEdExitCode !=2 & SpecialEdExitCode!=20

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


rename * =_SER_1314
desc

save SER_2013-14, replace



