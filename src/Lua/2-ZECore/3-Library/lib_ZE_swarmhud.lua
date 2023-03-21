
local ZE = RV_ZESCAPE
local CV = ZE.Console

local function SwarmMapHud(v,p,c)
  if not mapheaderinfo[gamemap].swarmmap then return end


  local basetime = ((CV.survtime/35))- CV.countup
  v.drawString(0,167,"\x85\Time Left: "+basetime, V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
end

hud.add(SwarmMapHud, "game")