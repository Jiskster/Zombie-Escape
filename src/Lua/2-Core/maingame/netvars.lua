local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.NetVars = function(net)
	ZE.Ztypes = net($)
	ZE.ringlist = net($)
	ZE.zombcount = net($)
	ZE.survcount = net($)
	ZE.teamWin = net($)
	CV.survtime = net($)
	CV.gametime = net($)
	CV.waittime = net($)
	CV.winWait = net($)
	CV.gamestarted = net($)
	CV.countup = net($)
	CV.timeafterwin = net($)
	CV.onwinscreen = net($)
	ZE.Wave = net($)
	ZE.npclist = net($)
end