

***SETTING WORKING DIRECTORY*******************
cd "G:\My Drive\NYU\Multivariate-Decomposition-Analysis\data"


******EXTRA DATA FROM THE NHANES MAIN SURVEY*******************
***************2013-2014*******************************


****IMPORTING SAS DATA IN STATA AND SAVING IT*********
foreach x in ALQ_H DUQ_H FSQ_H HIQ_H DPQ_H PUQMEC_H PAQ_H  SLQ_H SMQSHS_H DR1IFF_H DR2IFF_H HUQ_H DBQ_H INQ_H HSQ_H DEMO_H{
    
    * Import the XPT file
    import sasxport5 `x'.xpt, clear
    
    * Save as a .dta file with the correct file path
    save `x'_2013.dta, replace
}



******MERGING ALL 2013-2014 DATA **************
clear

use ALQ_H_2013, replace
foreach x in DUQ_H FSQ_H HIQ_H DPQ_H PUQMEC_H PAQ_H  SLQ_H SMQSHS_H /*DR1IFF_H DR2IFF_H*/ HUQ_H DBQ_H INQ_H HSQ_H DEMO_H{
	
	di "Merging `x'.xpt..."  // Print progress to log  

merge 1:1 seqn using `x'_2013.dta
rename _merge merge_`x'
}

gen svy_year=8

save extra_2013, replace

***************2015-2016*******************************

****IMPORTING SAS DATA IN STATA AND SAVING IT*********

foreach x in ALQ_I DUQ_I FSQ_I HIQ_I DPQ_I PUQMEC_I PAQ_I  SLQ_I SMQSHS_I DR1IFF_I DR2IFF_I HUQ_I DBQ_I INQ_I HSQ_I DEMO_I{
    
	di "Importing `x'.xpt..."  // Print progress to log  

    * Import the XPT file
    import sasxport5 `x'.xpt, clear
    
	di "Saving `x'.dta..."  

    * Save as a .dta file with the correct file path
    save `x'_2015.dta, replace
}



******MERGING ALL 2015-2016 DATA **************


clear

use ALQ_I_2015, replace
foreach x in DUQ_I FSQ_I HIQ_I DPQ_I PUQMEC_I PAQ_I  SLQ_I SMQSHS_I /*DR1IFF_I DR2IFF_I*/ HUQ_I DBQ_I INQ_I HSQ_I DEMO_I{
	
di "Merging `x'.xpt..."  // Print progress to log  

merge 1:1 seqn using `x'_2015.dta
rename _merge merge_`x'
}

gen svy_year=9

save extra_2015, replace




***************2017-2020*******************************

****IMPORTING SAS DATA IN STATA AND SAVING IT*********

foreach x in P_ALQ /*P_DUQ*/ P_FSQ P_HIQ P_DPQ P_PUQMEC P_PAQ  P_SLQ P_SMQSHS P_DR1IFF P_DR2IFF P_HUQ P_DBQ P_DBQ P_INQ P_HSQ P_DEMO{
    
		di "Importing `x'.xpt..."  // Print progress to log  

    * Import the XPT file
    import sasxport5 `x'.xpt, clear
    
	
    * Save as a .dta file with the correct file path
    save `x'_2017.dta, replace
}



******MERGING ALL 2017-2020 DATA **************

clear

use P_ALQ_2017, replace
foreach x in  /*P_DUQ*/ P_FSQ P_HIQ P_DPQ P_PUQMEC P_PAQ  P_SLQ P_SMQSHS /*P_DR1IFF P_DR2IFF*/ P_HUQ P_DBQ P_INQ P_HSQ P_DEMO{
	
	di "Merging `x'.xpt..."  // Print progress to log  

merge 1:1 seqn using `x'_2017.dta
rename _merge merge_`x'
}

gen svy_year=10

save extra_2017, replace


*************************************************************

********Append data from all 3 surveys************

clear
use extra_2013
append using extra_2015 extra_2017
tab svy_year 

rename seqn svy_id
save extra_data, replace



********ADDING NHANES CURATED DATA TO EXTRA DATA FROM THE NHANES MAIN SURVEY*******************

clear 
use nhanes_data, clear

keep if svy_year>=8 //subseting data to include on surveys from 2013 to 2020

merge 1:1 svy_id svy_year using extra_data
tab svy_year _merge

drop if _merge==2  // EXCLUDING EXTRA DATA THAT COULD NOT BE MATCHED WITH THE CURATED NHANES DATA


****** DATA CLEANING***********************
replace sld012=sld010h if svy_year==8
replace sld012=. if sld012==99
replace  dmdmartl = dmdmartz if dmdmartl==. & dmdmartz !=.
replace dmdmartl=. if dmdmartl==99
replace dmdeduc2=dmdeduc3 if dmdeduc2==. & dmdeduc3!=.
replace dmdeduc2=. if dmdeduc2==9

replace paq635 = . if paq635 ==9
replace paq665 = . if paq665==9
replace paq650 = . if paq650==9
replace paq620=. if paq620==7 | paq620==9
replace paq605=. if paq605==7 | paq605==9

replace dmdborn4=. if dmdborn4==77 | dmdborn4==99

replace alq101=. if  alq101==9
replace hiq011=. if hiq011==7 | hiq011==9
replace huq090=. if huq090==7 | huq090==9

replace dbq700=. if dbq700==7 | dbq700==9
replace huq010=. if huq010==7 | huq010==9

replace pad680=. if pad680==9999 | pad680==7777

replace huq090=. if huq090==9
replace hiq011=. if hiq011==7 | hiq011==9
replace alq101=. if alq101==9


****SLEEP***********************

recode sld012 (0/6.9=1 short)(7/9=2 Normal)(9.1/14.5=3 Long),gen(sleep)


**********DEPRESSION*******

recode dpq* (9 7=.)
gen raw_dep = dpq010 + dpq020 + dpq030 + dpq040 + dpq050 + dpq060 + dpq070 + dpq080 + dpq090

recode raw_dep (0/4=1 "No/minimal")(5/9=2 "Mild")(10/14=3 Moderate)(15/19=4 "Moderate-severe")(20/27=5 Severe),gen(depression)
recode raw_dep (0/4=1 "No")(5/27=2 "Yes"),gen(depress)

***********CONVERTING SEDENTARY MINUTES TO HOURS AND CATEGORIZING*****************
gen  sed=round(pad680/60,0.1)
recode sed (0/4=1 "<=4")(4.1/8=2 "4.1-8")(8.1/23=3 ">8"),gen(cat_sed)
recode sed (0/4=1 "<=4")(4.1/23=2 ">4"),gen(new_cat_sed)

*********EDUCATIONAL LEVEL***************************************************
recode dmdeduc2 (1/3 7 9/14 55 66=1 "<=High school")(4 5 15=2 ">High school"),gen(educ)


*********FAMILY SIZE****************************************
recode dmdfmsiz (1=1 "Living alone")(2/7=2 "Living with someone"),gen(hh_size1)
recode dmdfmsiz (1=1 "One")(2/3=2 "2-3")(4/5=3 "4-5")(6/10=4 ">5"),gen(hh_size2)


******MARITAL STATUS************************************************************
recode dmdmartl (1 6=1 "Currently Married/living together")(2 3 4=2 "Previously Married")(5=0 "Never Married"), gen(married)
replace married=1 if dmdmartz==1 
replace married=2 if dmdmartz==2 
replace married=0 if dmdmartz==3 
replace married=. if married==77
 
 
 ******BP CONTROL OUTCOME VARIABLE****************************
 recode bp_control_130_80 (1=0 No)(2=1 Yes),gen(bp_control)

********************POVERTY STATUS*********************************
recode indfmpir (0/0.999=1 "Below")(1/1.999=2 "Near Poverty")(2/3.99=3 "Moderate")(4/5=4 "High"),gen(poverty)




**********CREATING SECOND HAND SMOKING********************************
codebook smq858 smq862 smq868 smq872 smq876 smq880, compact
gen second_smoke=0 if smq856 !=. | smq860!=. |  smq866!=. | smq870!=. | smq874!=. | smq878!=. 
foreach x in smq858 smq862 smq868 smq872 smq876 smq880{
	
	replace second_smoke=1 if `x'==1
	replace second_smoke=0 if smq858==2 & smq862==2 &  smq868==2 &  smq872==2 &  smq876==2 &  smq880==2 
	
	replace second_smoke=. if smq858==9 & smq862==9 &  smq868==9 &  smq872==9 &  smq876==9 &  smq880==9

	replace second_smoke=. if smq856==9 & smq860==9 & smq866==9 & smq870==9 & smq874==2 & smq878==9
}


****FINAL DATA*******************
save data_extra, replace
