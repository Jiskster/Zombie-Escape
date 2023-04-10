rawset(_G,"MapVote",{})//Stores functions and any data that doesn't need to be netsynced
rawset(_G,"MapVoteNet",{})//Stores netsync data
local MV = MapVote
local NET = MapVoteNet

MV.MakeEnum = function(tag, names)
    for i = 1, #names do rawset(_G, tag.."_"..names[i], i - 1) end
end
MV.MakeEnum("MV",{"SCORE","VOTE","END","MAPCHANGE"})

NET.gametypedata = {}
NET.enabled_gametypes = {GT_ZESCAPE}
NET.mapqueue = {}
NET.mapblacklist = {}
NET.mapwhitelist = {}
NET.choices = {8,8,8}
NET.gtchoices = {8,8,8}
NET.nextmap = 0
NET.nextgt = 0
NET.timer = 0
NET.state = MV_SCORE
addHook("NetVars", function(n)
	NET.gametypedata = n($)
	NET.enabled_gametypes = n($)
	NET.mapqueue = n($)
	NET.mapblacklist = n($)
	NET.mapwhitelist = n($)
	NET.choices = n($)
	NET.gtchoices = n($)
	NET.nextmap = n($)
	NET.nextgt = n($)
	NET.timer = n($)
	NET.state = n($)
end)

hud.disable("intermissionmessages")