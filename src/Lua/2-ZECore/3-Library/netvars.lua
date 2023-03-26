local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.NetVars = function(net)
	ZE.ringlist = net($)
	ZE.zombcount = net($)
	ZE.survcount = net($)
	ZE.teamWin = net($)
	CV.survtime = net($)
	CV.gametime = net($)
	CV.waittime = net($)
	CV.winWait = net($)
	CV.countup = net($)
	ZE.Wave1 = net($)
    ZE.Wave2 = net($)
    ZE.Wave3 = net($)
end