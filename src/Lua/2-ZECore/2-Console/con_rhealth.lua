local CV = RV_ZESCAPE.Console
-- the name is gonna stay as rhealth bc its cool

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

CV.lockcolors = CV_RegisterVar{
	name = "rh_lockcolors",
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

CV.showsavehud = CV_RegisterVar{
	name = "rh_showsavehud",
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

CV.allowunlockables = CV_RegisterVar{
	name = "rh_allowunlockables",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff
}

CV.deathonwin = CV_RegisterVar{
	name = "rh_deathonwin",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff
}

CV.propdespawn = CV_RegisterVar{
	name = "rh_propdespawn",
	defaultvalue = "25",
	flags = CV_NETVAR,
	PossibleValue={MIN = 1, MAX = 60}
}

CV.propmax = CV_RegisterVar{
	name = "rh_propmax",
	defaultvalue = "2",
	flags = CV_NETVAR,
	PossibleValue={MIN = 1, MAX = 9999}
}