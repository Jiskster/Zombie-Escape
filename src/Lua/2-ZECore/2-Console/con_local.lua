local CV = RV_ZESCAPE.Console

CV.hudtype = CV_RegisterVar{
	name = "hudtype",
	defaultvalue = "2",
	PossibleValue={MIN = 1, MAX = 2}
}

CV.showendscore = CV_RegisterVar{
	name = "showendscore",
	defaultvalue = "On",
	PossibleValue = CV_OnOff
}