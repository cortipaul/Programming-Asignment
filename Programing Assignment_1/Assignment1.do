*****************************************************************
* Program file For iPhD module 860N1 Assignment 1      *  
*Test Instructions Attached in Folder 
*Also Attached is ReadMe file and Data      
                           *
* last modified 11 Nov 2025                                    *
***************************************************************** Setup******

version 18
clear all
set more off
pause on
cap log close
log using asignment1.txt, text replace




*********Import dataa set************************
import delimited "/Users/newuser/Downloads/student-mat.csv", clear 

********Describe and understand the varibles we want to put in use****
describe studytime health absences fedu medu 
br studytime health absences medu  
tab fedu, nolab
sum studytime health absences fedu medu
*******************Run the basic regression without using statitical libraries**********
reg g3 studytime health medu absences







********************
* Macro use  *
********************
********declare the dependant variable**************
 local depvar "g3"
 *********Declaare the explanatory variables ***************
local regrlist "studytime health medu absences "

**************Run the regression of the declared independent variables ///
 on the depepndent variable********/ 
 
regress `depvar' `regrlist'


 
 ******************
* Looping example:
******************

/* We nest the regression macros by those who said "YES" access to internet and declare that///
 standard errors should be robust */
regress g3 studytime health medu absences if internet == "yes", robust

/* The equation loop below also does nest macros by access to internet only that ///
it report results of thos who said "NO" and declare that standard errors should be robust */

levelsof internet, local(int_groups)
foreach intgrp of local int_groups {
	local if `"if internet == "`intgrp'""'
	dis `"`if'"'
	regress g3 studytime health medu absences  `if', `options'
	pause
}

***********************/But it is also possible to obtain those who said no and yes at the same time /
levelsof internet, local(int_groups)
*local options "robust"
local i=1
foreach intgrp of local int_groups {
	local if `"if internet == "`intgrp'""'
	dis `"`if'"'
	regress g3 studytime health medu absences  `if', `options'
	estimates store Grp_`i'
	mat MyCoeff = (nullmat(MyCoeff), e(b)') /* margins, dydx(lngdppc07) atmeans post */
	local mycolname "`mycolname' Grp_`i'"
*	pause
	local ++i
}
estimates table Grp_*, stats(N ll r2) star(.1 .05 .01) b(%10.4f) stfmt(%10.4f) var(12) model(8)
mat coln MyCoeff = `mycolname'
mat list MyCoeff

	
***********
* Graphing:
***********

*********graphing of performance over internet use*************** 
/* Absolute no-fills version: */
graph hbar g3, over(internet)

graph hbar g3, over(internet, sort(g3) des) /// 
	graphr(color(white)) plotr(color(white))

/* Aggregate performnance index  over internet use: */
qui sum g3, meanonly
local avg_g3 = r(mean)
graph hbar g3, over(internet, sort(g3) des) /// 
	yline(`avg_g3', lwidth(thin) lpattern(solid) lcolor(red)) ///
	ylabel(`avg_g3' `""Average" " ""') ///
	blabel(bar, format(%2.1f)) ///
	ti("Test Performance Index") ///
	subti("by Internet Use") ///
	yti("Test Performance") /// 
	legend(off) ///
	note(`"Test Scores In America"' ) /// 
	graphr(color(white)) plotr(color(white))




log close
exit
 