local CV = RV_ZESCAPE.Console

CV.hudtype = CV_RegisterVar{
	name = "hudtype",
	defaultvalue = "2",
	--flags = CV_NETVAR,
	PossibleValue={MIN = 1, MAX = 2}
}