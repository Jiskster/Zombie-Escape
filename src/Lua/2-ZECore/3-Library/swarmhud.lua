
local ZE = RV_ZESCAPE
local CV = ZE.Console

local function SwarmMapHud(v,p,c)
  --if not mapheaderinfo[gamemap].swarmmap then return end


  local basetime = ((CV.survtime/TICRATE))- (CV.countup/TICRATE)
  v.drawString(160,8,"\x85\Time Left: "+basetime, V_PERPLAYER|V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")
  
end

hud.add(SwarmMapHud, "game")