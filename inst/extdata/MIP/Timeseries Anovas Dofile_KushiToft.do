* Time Series Data for JCR Article, MIP Data, Kushi & Toft

clear all
set more off

use C:\Users\kushi\Desktop\CSS\MIPtimeseries

*Basic data clean*

*Removing cases*
keep if year>1944

*Basic distributional graphs*
line milex year
line cinc year
line siprimilitary2018con year
line rgdp2012chained year
scatter freqint year
scatter avgnationalinterestindex year
scatter freqint avgnationalinterestindex
scatter freqint statebpolity2 
graph bar freqint, over(postcoldwar)

*DESCRIPTIVE STATS TABLES*
tabstat freqint avgushost avgushighact avduration milex milper irst pec tpop upop cinc rgdp2012chained changeinrgdp change_govt_expend_defense siprimilitary2018con militaryexpgdp avgnationalinterestindex statebpolity2, stat(me sd min max n) col(stat) long
tabstat freqint avgushost avgushighact avduration milex milper irst pec tpop upop cinc rgdp2012chained changeinrgdp change_govt_expend_defense siprimilitary2018con militaryexpgdp avgnationalinterestindex statebpolity2, by (postcoldwar) stat(me sd min max n) col(stat) long
tabstat freqint, by (postcoldwar) stat(  mean sum)

*INSTALL* 
ssc install outreg2
findit asdoc
ssc install asdoc

*WORD TABLE OF SUMMARY STATS*
outreg2 using JCRSum.doc, replace sum(log)

*Defining DVs and time variables*
global ylist freqint 
* try avgushost avgushighact avduration**
global dylist d.freqint
global xlist milex milper irst pec tpop upop cinc rgdp2012chained changeinrgdp change_govt_expend_defense siprimilitary2018con militaryexpgdp freqlag avgnationalinterestindex
global time year
global lags 40

describe $time $ylist
summarize $time $ylist

* Set data as time series
tset $time, yearly 


*DESCRIPTIVE STATS TABLES*

ssc install estout, replace

estpost tabstat freqint avgushost avgushighact avduration milex milper irst pec tpop upop cinc rgdp2012chained changeinrgdp change_govt_expend_defense siprimilitary2018con militaryexpgdp avgnationalinterestindex, stat(me sd min max n) col(stat) 
esttab, cell((mean(label(Mean)) sd(label(S.D.)) min(label(Minimum)) max(label(Maximum)) count(label(n))))
tabstat freqint avgushost avgushighact avduration milex milper irst pec tpop upop cinc rgdp2012chained changeinrgdp change_govt_expend_defense siprimilitary2018con militaryexpgdp avgnationalinterestindex, by (postcoldwar) stat(me sd min max n) col(stat) 

*WORD TABLE OF DESCRIPTIVE STATS*
set matsize 10000
outreg2 using descriptivestats.doc, replace sum(log) keep(freqint avgushost avgushighact avduration milex milper irst pec tpop upop cinc rgdp2012chained changeinrgdp change_govt_expend_defense siprimilitary2018con militaryexpgdp avgnationalinterestindex)
bysort postcoldwar: outreg2 using descriptivestats2.doc, replace sum(log) keep(freqint avgushost avgushighact avduration milex milper irst pec tpop upop cinc rgdp2012chained changeinrgdp change_govt_expend_defense siprimilitary2018con militaryexpgdp avgnationalinterestindex)
bysort postcoldwar: outreg2 using descriptivestats3.doc, replace sum(log) keep(freqint avgushost avgushighact avduration avgnationalinterestindex)

*BASIC TABS*
outreg2 postcoldwar using coldwartab.doc, replace cross
tab postcoldwar freqint
tabstat freqint avduration avgushost avgushighact avgnationalinterestindex, by (postcoldwar) stat(mean sum)

*ANOVAS FOR SIGNIFICANCE*
oneway freqint era, bonferroni
oneway freqint era, scheffe
oneway freqint era, sidak 

oneway avgnationalinterestindex era, bonferroni
oneway avgnationalinterestindex era, scheffe
oneway avgnationalinterestindex era, sidak 
