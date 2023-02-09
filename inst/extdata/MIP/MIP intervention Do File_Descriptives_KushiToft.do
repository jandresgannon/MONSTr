**MIP Descriptive Statistics - Sidita Kushi**

clear all
set more off
set maxvar 32000

global BASEDIR "C:\Users\kushi\Desktop\CSS"

cd "$BASEDIR"

**open Log File**

capture log close
log using dofilecodeviewer.log, replace

clear all

** IMPORT DATA **

use MIP_Backlogger_MAIN.dta, replace

save savedMIPstata.dta, replace

*Destring variables*
destring HighActB, generate(HighActB1)
drop HighActB
rename HighActB1 HighActB
destring Decade, generate (Decades)
drop Decade
destring Outcome, generate (Outcome1)
drop Outcome
rename Outcome1 Outcome
destring BattleLevUS, generate (BattleLevUS1)
drop BattleLevUS
rename BattleLevUS1 BattleLevUS
destring BattleLevB, generate (BattleLevB1)
drop BattleLevB
rename BattleLevB1 BattleLevB
destring BattleLev, generate (BattleLev1)
drop BattleLev
rename BattleLev1 BattleLev
destring fatlevUS, generate (fatlevUS1)
drop fatlevUS
rename fatlevUS1 fatlevUS
destring fatlevB, generate (fatlevB1)
drop fatlevB
rename fatlevB1 fatlevB
destring fatlev, generate (fatlev1)
drop fatlev
rename fatlev1 fatlev


*Encode Variables*

encode OECDReg, generate(OECDReg2)

*Replace Missing Data (-9, -66, -77)*
*fat level data seems to have some issues*
replace FatLev=. if FatLev==-9
replace fatlevUS=. if fatlevUS==-9
replace fatlevB=. if fatlevB==-9
replace FatB=. if FatB==-9
replace FatUS=. if FatUS==-9
replace Fatalities=. if Fatalities==-9 
replace Fatalities=. if Fatalities==1,000-2,000
replace Fatalities=. if Fatalities==N/A
replace Fatalities=. if Fatalities==Unknown
replace FatB=. if FatB==N/A
replace FatUS=. if FatUS==N/A
replace BattleFatUS=. if BattleFatUS==n/a  
replace BattleFatB=. if BattleFatB==6,000-10,000 
replace BattleFatB=. if BattleFatB==-9 
replace BattleFatB= if BattleFatB==unknown
replace BattleFatB= if BattleFatB==N/A

replace Outcome = "6" in 588

replace RELFRE=. if RELFRE==-66
replace RELFRE=. if RELFRE==-77

replace WORKER=. if WORKER==-66
replace WORKER=. if WORKER==-77

replace WECON=. if WECON==-66
replace WECON=. if WECON==-77
replace WECON=. if WECON==-999

replace WOPOL=. if WOPOL==-66
replace WOPOL=. if WOPOL==-77
replace WOPOL=. if WOPOL==-999

replace WOSOC=. if WOSOC==-66
replace WOSOC=. if WOSOC==-77
replace WOSOC=. if WOSOC==-999

replace StateBautoc=. if StateBautoc==-66
replace StateBautoc=. if StateBautoc==-77
replace StateBautoc=. if StateBautoc==-88
replace StateBdemoc=. if StateBdemoc==-66
replace StateBdemoc=. if StateBdemoc==-77
replace StateBdemoc=. if StateBdemoc==-88

replace OilDummy = 0 if OilDummy==.

**FILTERING OUT OBSERVATIONS**

*Removed cases*
keep if RemoveCase<1
keep if FrontierWar<1
keep if USHiHost>1

*Post-WW2 universe - choose one or other* 
keep if styear>1944

*Post-Cold War universe* 
keep if styear>1989 

*DESCRIPTIVE STATS TABLES*

*Simple Tabs for String variables*
tab OECDReg
tab Era
tab StateB

*Intervention characteristics, split by Era, Hostility, and Region*
tabstat styear endyear dyadicHighAct dyadichostility USHighAct USHiHost HighActB HihostB War, stat(me sd min max n) col(stat) long
tabstat styear endyear FatLev dyadicHighAct fatlevUS USHighAct USHiHost fatlevB HighActB HihostB War, by (dyadichostility) stat(me sd min max n) col(stat) long
tabstat styear endyear FatLev dyadicHighAct dyadichostility fatlevUS USHighAct USHiHost fatlevB HighActB HihostB War, by (Era) stat(me sd min max n) col(stat) long
tabstat styear endyear dyadicHighAct dyadichostility USHighAct USHiHost HighActB HihostB War, by (OECDReg) stat(me sd min max n) col(stat) long

*Interest-based Variables*
tabstat USCINC StateBCINC defense neutrality nonaggression entente Colonialland Colonialsea Colonialcontiguity oil_prod oil_value_2014 gas_prod gas_value_2014 oilgas_value_2014 oil_exports gas_exports, stat(me sd min max n) col(stat) long
tabstat USCINC StateBCINC defense neutrality nonaggression entente Colonialland Colonialsea Colonialcontiguity oil_prod oil_value_2014 gas_prod gas_value_2014 oilgas_value_2014 oil_exports gas_exports, by (Era) stat(me sd min max n) col(stat) long
tabstat USCINC StateBCINC defense neutrality nonaggression entente Colonialland Colonialsea Colonialcontiguity oil_prod oil_value_2014 gas_prod gas_value_2014 oilgas_value_2014 oil_exports gas_exports, by (OECDReg) stat(me sd min max n) col(stat) long

*WORD TABLE OF SUMMARY STATS*
set matsize 2000 
*Intervention Characteristics by Total, Hostility, Era, Region*
outreg2 using summarystats.doc, replace sum(log) keep(styear endyear Era OECDReg dyadicHighAct dyadichostility USHighAct USHiHost HighActB HihostB War USOrig Outcome) 
bysort USHiHost: outreg2 using sumHostility.doc, replace sum(log) keep(styear endyear Era FatLev dyadicHighAct dyadichostility fatlevUS USHighAct USHiHost fatlevB HighActB HihostB War) 
bysort Era: outreg2 using sumEra.doc, replace sum(log) keep(styear endyear Era FatLev dyadicHighAct dyadichostility fatlevUS USHighAct USHiHost fatlevB HighActB HihostB War) 
bysort OECDReg: outreg2 using sumRegion.doc, replace sum(log) keep(styear endyear Era FatLev dyadicHighAct dyadichostility fatlevUS USHighAct USHiHost fatlevB HighActB HihostB War) 

*Interests-based Variables*
outreg2 using interestsStats.doc, replace sum(log) keep(USCINC StateBCINC defense neutrality nonaggression entente Colonialland Colonialsea Colonialcontiguity oil_prod oil_value_2014 gas_prod gas_value_2014 oilgas_value_2014 oil_exports gas_exports)
bysort dyadichostility: outreg2 using interestsHost.doc, replace sum(log) keep(USCINC StateBCINC defense neutrality nonaggression entente Colonialland Colonialsea Colonialcontiguity oil_prod oil_value_2014 gas_prod gas_value_2014 oilgas_value_2014 oil_exports gas_exports)
bysort Era: outreg2 using interestsEra.doc, replace sum(log) keep(USCINC StateBCINC defense neutrality nonaggression entente Colonialland Colonialsea Colonialcontiguity oil_prod oil_value_2014 gas_prod gas_value_2014 oilgas_value_2014 oil_exports gas_exports)
bysort OECDReg: outreg2 using interestsRegion.doc, replace sum(log) keep(USCINC StateBCINC defense neutrality nonaggression entente Colonialland Colonialsea Colonialcontiguity oil_prod oil_value_2014 gas_prod gas_value_2014 oilgas_value_2014 oil_exports gas_exports)

*Human Rights-based Variables* 
outreg2 using HRstats.doc, replace sum(log) keep(StateBpolity2 USDsource USidp UShost StateBsource StateBidp StateBhost PHYSINT RELFRE WECON WOPOL ChildMort LifeExp democracy regime) 
bysort Era: outreg2 using HRstatsEra.doc, replace sum(log) keep(StateBpolity2 USDsource USidp UShost StateBsource StateBidp StateBhost PHYSINT RELFRE WECON WOPOL ChildMort LifeExp democracy regime) 
bysort OECDReg: outreg2 using HRstatsRegion.doc, replace sum(log) keep(StateBpolity2 USDsource USidp UShost StateBsource StateBidp StateBhost PHYSINT RELFRE WECON WOPOL ChildMort LifeExp democracy regime) 

*Economic Variables*
outreg2 using Econstats.doc, replace sum(log) keep(StateBimports StateBexports USimports USexports Tradeflow1 Tradeflow2 USrGDP USrGDPcapita USrGDPCChange USRecession USunemp USDeficit USDebtGDP USDeficitCon USDecifitGDP) 
bysort Era: outreg2 using EconstatsEra.doc, replace sum(log) keep(StateBimports StateBexports USimports USexports Tradeflow1 Tradeflow2 USrGDP USrGDPcapita USrGDPCChange USRecession USunemp USDeficit USDebtGDP USDeficitCon USDecifitGDP) 
bysort OECDReg: outreg2 using EconstatsRegion.doc, replace sum(log) keep(StateBimports StateBexports USimports USexports Tradeflow1 Tradeflow2 USrGDP USrGDPcapita USrGDPCChange USRecession USunemp USDeficit USDebtGDP USDeficitCon USDecifitGDP) 

*Domestic Variables*
outreg2 using USstats.doc, replace sum(log) keep(USdemoc USpolity2 USdurable USHC DefOutlay DODOutlays DOSOutlays SDratioOutlays DODOutlaysP DOSOutlaysP SDOutlaysP SenateDem HouseDem PresidentDem DemControl RepControl CongressDem CongressRep PresElectionYear ViolentCrime)
bysort Era: outreg2 using USstatsEra.doc, replace sum(log) keep(USdemoc USpolity2 USdurable USHC DefOutlay DODOutlays DOSOutlays SDratioOutlays DODOutlaysP DOSOutlaysP SDOutlaysP SenateDem HouseDem PresidentDem DemControl RepControl CongressDem CongressRep PresElectionYear ViolentCrime)
bysort OECDReg: outreg2 using USstatsRegion.doc, replace sum(log) keep(USdemoc USpolity2 USdurable USHC DefOutlay DODOutlays DOSOutlays SDratioOutlays DODOutlaysP DOSOutlaysP SDOutlaysP SenateDem HouseDem PresidentDem DemControl RepControl CongressDem CongressRep PresElectionYear ViolentCrime)

*Using Outreg2 for frequencies*
outreg2 Era using Simpletabs.doc, replace cross
outreg2 OECDReg2 using Simpletabs3.doc, replace cross
outreg2 NationalInterestIndex using SimpletabsInterest.doc, replace cross

*Using Outreg2 for crosstabs - only reports column percentages - edited in document manually!*
outreg2 Era USHiHost using crosstab.doc, replace cross 
outreg2 Decade USHiHost using crosstab2.doc, replace cross 

ssc install estout, replace
