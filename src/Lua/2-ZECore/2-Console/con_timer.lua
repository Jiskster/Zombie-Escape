local CV = RV_ZESCAPE.Console

CV.gametime = CV_RegisterVar{
    name="ze_time",
    defaultvalue="14.0",
	flags=CV_CALL|CV_FLOAT|CV_NETVAR|CV_NOINIT,
	PossibleValue={MIN = FRACUNIT, MAX = FRACUNIT*20},
	func=function(cv)
		CV.gametime=(cv.value*60/FRACUNIT)*TICRATE
	end
}

CV.waittime = CV_RegisterVar{
    name="ze_wait",
    defaultvalue="120",
	flags=CV_CALL|CV_NETVAR|CV_NOINIT,
	PossibleValue={MIN = 0, MAX = 120},
	func=function(cv)
		CV.waittime=cv.value*TICRATE
	end
}

CV.winWait = CV_RegisterVar{
    name="ze_winwait",
    defaultvalue="9999",
	flags=CV_CALL|CV_NETVAR|CV_NOINIT,
	PossibleValue={MIN = 0, MAX = 9999},
	func=function(cv)
		CV.winWait=cv.value*TICRATE
	end
}

CV.survtime = CV_RegisterVar{
    name="ze_survtime",
    defaultvalue="600",
	flags=CV_CALL|CV_NETVAR|CV_NOINIT,
	PossibleValue={MIN = 0, MAX = 9999},
	func=function(cv)
		CV.survtime=cv.value*TICRATE
	end
}