
***SETTING WORKING DIRECTORY*******************
cd "G:\My Drive\NYU\Multivariate-Decomposition-Analysis\data"

****OPENING DATA
 use data_extra, replace 
 
******declearing data as survey data
svyset svy_psu, strata(svy_strata) weight(svy_weight_mec) vce(linearized) singleunit(missing)


**** Table 1: characteristics by year of survey****


foreach x in demo_age_cat demo_gender demo_race demo_race_black  married educ huq090 hiq011 cc_smoke alq101 cc_ckd cc_diabetes cc_cvd_any depression depress sleep hh_size1 hh_size2 dmdhhsza dmdborn4  paq605 paq620 paq650 paq665 paq635 cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke huq010 dbq700{

des `x'
svy linearized,  subpop(if svy_subpop_htn==1) : tab  `x' svy_year, percent col format(%15.3g) 


}

****************OVERALL BP CONTROL BY YEAR OF SURVEY
svy linearized,  subpop( if svy_subpop_htn==1) : tab  bp_control_130_80 svy_year, percent col format(%15.3g) ci null

svy linearized,  subpop( if svy_subpop_htn==1) : logistic  bp_control i.svy_year, base
margins svy_year
marginsplot 

*********** Table 2: overall bp_control across patients characteristics**************
foreach x in demo_age_cat demo_gender demo_race demo_race_black married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depression depress sleep /*hh_size1 hh_size2 dmdhhsza*/ dmdborn4  paq605 paq620 paq650 paq665 paq635 cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke huq010 dbq700{

des `x'
 svy linearized,  subpop( if svy_subpop_htn==1) : tab  `x' bp_control_130_80, percent row ci format(%15.3g) null


}


**********Table 2:overall bp_control across patients characteristics 2013-2014*******

foreach x in demo_age_cat demo_gender demo_race demo_race_black married educ huq090 hiq011 cc_smoke alq101 cc_ckd cc_diabetes cc_cvd_any depression depress sleep hh_size1 hh_size2 dmdhhsza dmdborn4  paq605 paq620 paq650 paq665 paq635 cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke huq010 dbq700{

des `x'
 svy linearized,  subpop( if svy_subpop_htn==1 & svy_year==8) : tab  `x' bp_control_130_80, percent row ci format(%15.3g) null


}


**********Table 2:overall bp_control across patients characteristics 2015-2016*******

foreach x in demo_age_cat demo_gender demo_race demo_race_black married educ huq090 hiq011 cc_smoke alq101 cc_ckd cc_diabetes cc_cvd_any depression depress sleep hh_size1 hh_size2 dmdhhsza dmdborn4  paq605 paq620 paq650 paq665 paq635 cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke huq010 dbq700{

des `x'
 svy linearized,  subpop( if svy_subpop_htn==1 & svy_year==9) : tab  `x' bp_control_130_80, percent row ci format(%15.3g) null


}

**********Table 2:overall bp_control across patients characteristics 2017-2020*******
foreach x in demo_age_cat demo_gender demo_race demo_race_black married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depression depress sleep /*hh_size1 hh_size2 dmdhhsza*/ dmdborn4  paq605 paq620 paq650 paq665 paq635 cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke huq010 dbq700{

des `x'
 svy linearized,  subpop( if svy_subpop_htn==1 & svy_year==10) : tab  `x' bp_control_130_80, percent row ci format(%15.3g)  null


}




*******BINARY LOGISTIC AND POISSON MODELS 2013-2014****
 
svy, subpop( if svy_subpop_htn==1 & svy_year==8):  logistic bp_control  i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza   paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700 dmdborn4), base

svy, subpop( if svy_subpop_htn==1 & svy_year==8):  poisson bp_control  i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza   paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700 dmdborn4), base irr 


*******BINARY LOGISTIC AND POISSON MODELS 2015-2016****

svy, subpop( if svy_subpop_htn==1 & svy_year==9):  logistic bp_control i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza dmdborn4  paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700), base


svy, subpop( if svy_subpop_htn==1 & svy_year==9):  poisson bp_control i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza dmdborn4  paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700), base irr


*******BINARY LOGISTIC AND POISSON MODELS 2017-2020****
svy, subpop( if svy_subpop_htn==1 & svy_year==10):  logistic bp_control i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza dmdborn4  paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700), base

svy, subpop( if svy_subpop_htn==1 & svy_year==10):  poisson bp_control i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza dmdborn4  paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700), base irr


*****BINARY LOGISTIC AND POISSON MODELS COMBINED DATA WITH SURVEY YEAR AS COVARIATE****

svy, subpop( if svy_subpop_htn==1):  logistic bp_control i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza dmdborn4  paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700 svy_year), base 

svy, subpop( if svy_subpop_htn==1):  poisson bp_control i.demo_age_cat i.demo_gender b2.demo_race_black  i.(married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep)  /*dmdhhsza dmdborn4  paq605 paq620*/ b2.paq650 b2.paq665 b2.paq635 i.(cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700 svy_year), base irr


******MULTIVARIATE DECOMPOSITION ANALYSIS************************************
*********GENERATING DUMMIES FOR MULTIVARIATE DECOMPOSITION MODEL*********
/* install mvdcmp package using the following commmnad if not already installed "ssc install devcon"
*/

foreach x in  demo_age_cat demo_gender demo_race_black married educ huq090 hiq011 cc_smoke /*alq101*/ cc_ckd cc_diabetes cc_cvd_any depress sleep  /*dmdhhsza dmdborn4  paq605 paq620*/ paq650 paq665 paq635 cc_bmi new_cat_sed poverty bp_med_use fsdad second_smoke /*huq010*/ dbq700 svy_year{
	
	tab `x', gen(bi_`x'_)
}



****Decomposition MODEL FOR 2013-14 AND 2015-16********************
preserve
keep if svy_year < 10 & svy_subpop_htn==1
tab svy_year bi_svy_year_1
mvdcmp bi_svy_year_1 , normal(bi_demo_age_cat_1 bi_demo_age_cat_2 bi_demo_age_cat_3 bi_demo_age_cat_4| bi_demo_gender_1 bi_demo_gender_2 | bi_demo_race_black_1 bi_demo_race_black_2 | bi_cc_ckd_1 bi_cc_ckd_2 | bi_cc_cvd_any_1 bi_cc_cvd_any_2 | bi_paq650_1 bi_paq650_2 | bi_cc_bmi_1 bi_cc_bmi_2 bi_cc_bmi_3 bi_cc_bmi_4 | bi_bp_med_use_1 bi_bp_med_use_2 | bi_fsdad_1 bi_fsdad_2 bi_fsdad_3 bi_fsdad_4 | bi_paq635_1 bi_paq635_2): logit bp_control   bi_demo_age_cat_2 bi_demo_age_cat_3 bi_demo_age_cat_4  bi_demo_gender_2 bi_demo_race_black_2  bi_cc_ckd_2  bi_cc_cvd_any_2  bi_paq650_2  bi_cc_bmi_2 bi_cc_bmi_3 bi_cc_bmi_4  bi_bp_med_use_2  bi_fsdad_2 bi_fsdad_3 bi_fsdad_4  bi_paq635_2 [pw=svy_weight_mec]
 
 restore
 

 
 
 ****Decomposition MODEL FOR 2013-14 AND 2017-20*****************************
preserve
keep if (svy_year ==10 | svy_year ==8) & svy_subpop_htn==1
tab svy_year bi_svy_year_1
mvdcmp bi_svy_year_1 , normal(bi_demo_age_cat_1 bi_demo_age_cat_2 bi_demo_age_cat_3 bi_demo_age_cat_4| bi_demo_gender_1 bi_demo_gender_2 | bi_demo_race_black_1 bi_demo_race_black_2 | bi_cc_ckd_1 bi_cc_ckd_2 | bi_cc_cvd_any_1 bi_cc_cvd_any_2 | bi_paq650_1 bi_paq650_2 | bi_cc_bmi_1 bi_cc_bmi_2 bi_cc_bmi_3 bi_cc_bmi_4 | bi_bp_med_use_1 bi_bp_med_use_2 | bi_fsdad_1 bi_fsdad_2 bi_fsdad_3 bi_fsdad_4 | bi_paq635_1 bi_paq635_2): logit bp_control   bi_demo_age_cat_2 bi_demo_age_cat_3 bi_demo_age_cat_4  bi_demo_gender_2 bi_demo_race_black_2  bi_cc_ckd_2  bi_cc_cvd_any_2  bi_paq650_2  bi_cc_bmi_2 bi_cc_bmi_3 bi_cc_bmi_4  bi_bp_med_use_2  bi_fsdad_2 bi_fsdad_3 bi_fsdad_4  bi_paq635_2 [pw=svy_weight_mec]
 
 restore
 
 
 