local CV = RV_ZESCAPE.Console

CV.rhenable = CV_RegisterVar{
	name = "rh_enable",
	defaultvalue = "On",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff
}

CV.knockback = CV_RegisterVar{
	name = "rh_knockback",
	defaultvalue = "On",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff
}

CV.debug = CV_RegisterVar{
	name = "rh_debug",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff
}

CV.ringlimit = CV_RegisterVar{
	name = "rh_ringlimit",
	defaultvalue = "9999",
	flags = CV_NETVAR,
	PossibleValue={MIN = 50, MAX = 9999}
}

CV.friendlypushing = CV_RegisterVar{
	name = "rh_friendlyfire",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff
}