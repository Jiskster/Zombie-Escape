local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.ZombieSkin = function(player)
  if not (gametype == GT_ZESCAPE) then return end
    if player and player.valid
     and player.mo and player.mo.valid
	if (player.ctfteam == 1 and player.mo.skin ~= "dzombie") then
		if player.playerstate == PST_LIVE and CV.gamestarted == true and player.powers[pw_flashing] < 35 then
			P_DamageMobj(player.mo, nil, nil, 1, DMG_INSTAKILL)
		end
		R_SetPlayerSkin(player, "dzombie")

	elseif (player.ctfteam == 2) and (player.mo.skin == "dzombie") then
	   R_SetPlayerSkin(player,ZE.survskinsplay[P_RandomRange(1,#ZE.survskinsplay)])
	   end
	end
end

ZE.RestrictSkin = function()
  if not (gametype == GT_ZESCAPE) then return end
		if (leveltime < CV.waittime) or (CV.waittime < 20*TICRATE) then
		   COM_BufInsertText(server, "restrictskinchange 0")
	    else
		   COM_BufInsertText(server, "restrictskinchange 1")
     end
end


