# Assignment1


Hi,  this is program file For iPhD module 860N1 Assignment 1. We start by running the simple regression without using any statical library. We however later attempt to fully integrate the simple regression into Mata, which is much faster and more verstile that before! Please note the following:
1. Test Instructions are attached in the Folder 
2. A do file is  provided 
3. The dataset is also provided, but can be downloaded at https://archive.ics.uci.edu/dataset/320/student+performance.




```
1. We start by examining the variables that could potentially affect a students final mathematics test performance. We do this by summarizing a select number of variables over 395 0bservations/students. The variables are studytime, health, absence (from school), fedu (father's education) and medu (mother education). We take note that the first two variables are categorical and the later three are continues. With exception of absences, the variables aare centred around the mean with manageable dispersion. Therefore we expect our regression to converge.     


. sum studytime health absences fedu medu

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   studytime |        395    2.035443    .8392403          1          4
      health |        395     3.55443    1.390303          1          5
    absences |        395    5.708861    8.003096          0         75
        fedu |        395    2.521519    1.088201          0          4
        medu |        395    2.749367    1.094735          0          4

------------------------------------------------------------------------------


2. *  *******************Run the basic regression without using statitical libraries**********

The regression below suggest that only medu influences math perfomamnce positively. We can say very lkittkle about studytime, health  and absence  since they are insignificant. Nevertheless, interesting to note is that health is negatively associated with math performance. But we need to be cautious about these regression results beacuse of the many insignificant T-statistics, p-values above 0.05, large standard errors, large constant and an extremely low R- square. The R-Square suggest that little of the variations in the test scores are expalined by indeopendent variabels (studytime, health, medu and absence).


. reg g3 studytime health medu absences

      Source |       SS           df       MS      Number of obs   =       395
-------------+----------------------------------   F(4, 390)       =      5.84
       Model |  467.474622         4  116.868655   Prob > F        =    0.0001
    Residual |  7802.43424       390  20.0062416   R-squared       =    0.0565
-------------+----------------------------------   Adj R-squared   =    0.0469
       Total |  8269.90886       394  20.9896164   Root MSE        =    4.4728

------------------------------------------------------------------------------
          g3 | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   studytime |    .447621   .2704841     1.65   0.099    -.0841683    .9794103
      health |  -.1478577   .1627648    -0.91   0.364     -.467864    .1721486
        medu |   .8704561   .2075713     4.19   0.000     .4623574    1.278555
    absences |   .0098386   .0283814     0.35   0.729     -.045961    .0656381
       _cons |   7.580262   1.034385     7.33   0.000     5.546595     9.61393
------------------------------------------------------------------------------

3. *******we now compare the above results against use of a statiscal Library: Mata

The result from the simple regression are very simmilar to those from the simmple regression 

 ********************
. * Macro use part 1 *
. ********************
. ********declare the dependant variable**************
.  local depvar "g3"

.  *********Declaare the explanatory variables ***************
. local regrlist "studytime health medu absences "

. 
. **************Run the regression of the declared independent variables ///
>  on the depepndent variable********/ 
.  
. regress `depvar' `regrlist'

      Source |       SS           df       MS      Number of obs   =       395
-------------+----------------------------------   F(4, 390)       =      5.84
       Model |  467.474622         4  116.868655   Prob > F        =    0.0001
    Residual |  7802.43424       390  20.0062416   R-squared       =    0.0565
-------------+----------------------------------   Adj R-squared   =    0.0469
       Total |  8269.90886       394  20.9896164   Root MSE        =    4.4728

------------------------------------------------------------------------------
          g3 | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   studytime |    .447621   .2704841     1.65   0.099    -.0841683    .9794103
      health |  -.1478577   .1627648    -0.91   0.364     -.467864    .1721486
        medu |   .8704561   .2075713     4.19   0.000     .4623574    1.278555
    absences |   .0098386   .0283814     0.35   0.729     -.045961    .0656381
       _cons |   7.580262   1.034385     7.33   0.000     5.546595     9.61393
------------------------------------------------------------------------------
