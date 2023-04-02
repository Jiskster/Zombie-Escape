
local ZE = RV_ZESCAPE
local CV = ZE.Console

local function SwarmMapHud(v,p,c)
	--if not mapheaderinfo[gamemap].swarmmap then return end
	local hudtype = CV.hudtype.value 
	local basetime = ((CV.survtime/TICRATE))- (CV.countup/TICRATE)
	if hudtype == 1 
		v.drawString(0,167,"\x85\Time Left: "+basetime, V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
	end
	if hudtype == 2
		v.drawString(160,8,"\x85\Time Left: "+basetime, V_PERPLAYER|V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")
	end


end

hud.add(SwarmMapHud, "game")