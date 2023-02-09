
use "ReplicationAllenMartinezMachainJOGSS.dta", clear

 
 
 //Replication materials for "Choosing Air Strikes," by Susan Hannah Allen and Carla Martinez Machain
 //Updated March 19, 2018

  //collapse the last two outcomes
 generate outcomecoll=outcome
 replace outcomecoll=2 if outcomecoll==3

 
 //Table 2
 
  	set more off

	eststo clear
	

	la var powscore2 "Power Differential"
	la var polity2 " Polity Score"
	la var jointdem  "Joint Democracy"
	la var logengy "ln(Energy Consumption)"
	la var cractloc "Crisis Location"
	la var gravty2 "Issue Salience"
	la var noactr "Number of Actors"
	la var protrac "Protracted Crisis"
	la var sanctong "Ongoing Sanctions"

	eststo: mprobit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog
	eststo: mprobit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog base(2)

	#delimit;
	esttab _all using Table2.rtf, se starlevels(* .10 ** .05 *** .01) label scalars(N chi2 ll) nogaps compress title("Multinomial Logit) replace;
 
 //Figures 

	//Figure 1 (Energy consumption)
	mprobit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog
	margins, at(logengy=(1(1)15)) predict(outcome(1)) predict(outcome(2)) cont atmeans
	marginsplot, title("Predicted Probability of Decision to Use Foreign Policy Tools in Crisis") subtitle("Across Range of Energy Consumption") ytitle("")  plot1opts(lpattern("."))  
	
	//Figure 2 (Polity)
	mprobit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog
	margins, at(polity2=(-10(1)10)) predict(outcome(1)) predict(outcome(2)) cont atmeans
	marginsplot, title("Predicted Probability of Decision to Use Foreign Policy Tools in Crisis") subtitle("Across Range of Polity II Scores") ytitle("") plot1opts(lpattern(".")) 

	//Figure 3 (Issue Salience)
	mprobit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog
	margins, at(gravty2=(0(1)6)) predict(outcome(1)) predict(outcome(2)) cont atmeans
	marginsplot, title("Predicted Probability of Decision to Use Foreign Policy Tools in Crisis") subtitle("Across Range of Issue Salience") ytitle("") plot1opts(lpattern(".")) 
	
	
///////// Online Appendix Material
	

 

 // Figure A1: (Issue Salience with Ground Troops as base category)
	mprobit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog base(2)
	margins, at(gravty2=(0(1)6)) predict(outcome(0)) predict(outcome(1)) cont atmeans
	marginsplot, title("Predicted Probability of Decision to Use Foreign Policy Tools in Crisis") subtitle("Across Range of Issue Salience (Ground Troops as Base Category)") ytitle("") plot1opts(lpattern(".")) 

 
		//Diplomacy as Base Category, Table A1
 	set more off

	eststo clear
	

	la var powscore2 "Power Differential"
	la var polity2 " Polity Score"
	la var jointdem  "Joint Democracy"
	la var logengy "ln(Energy Consumption)"
	la var cractloc "Crisis Location"
	la var gravty2 "Issue Salience"
	la var noactr "Number of Actors"
	la var protrac "Protracted Crisis"
	la var sanctong "Ongoing Sanctions"

	eststo: mlogit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog

	#delimit;
	esttab _all using TableA1.rtf, se starlevels(* .10 ** .05 *** .01) label scalars(N chi2 ll) mtitles("Air Strikes Alone" "Military Action with Ground Troops") nogaps compress
	title("Multinomial Logit-No Force as Base Category")  replace;
	
	// Table A2 (Military Action with Ground Troops as Base Category)
 	set more off

	eststo clear
	
	la var powscore2 "Power Differential"
	la var polity2 " Polity Score"
	la var jointdem  "Joint Democracy"
	la var logengy "ln(Energy Consumption)"
	la var cractloc "Crisis Location"
	la var gravty2 "Issue Salience"
	la var noactr "Number of Actors"
	la var protrac "Protracted Crisis"
	la var sanctong "Ongoing Sanctions"

	eststo: mlogit outcomecoll powscore2  polity2 jointdem  logengy cractloc gravty2 noactr protrac, cluster(ccode) robust nolog base(2)


	#delimit;
	esttab _all using TableA2.rtf, se starlevels(* .10 ** .05 *** .01) label scalars(N chi2 ll) mtitles("Non-Violent Coercion" "Air Strikes Alone") nogaps compress
	title(" Multinomial Logit-Military Action with Ground Troops as Base Category")  replace;
