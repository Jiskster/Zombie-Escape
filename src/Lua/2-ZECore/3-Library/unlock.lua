local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.UnlockRevenger = function(player)
	if player.rvgrpass ~= 1 then
		chatprint(string.format("\x87\%s Unlocked \x8F\Revenger! \x87\%s games played!",player.name,player.gamesPlayed))
		S_StartSound(player.mo, sfx_ideya)
		player.rvgrpass = 1
	end
end

ZE.Revenger = function(player)
	for player in players.iterate
		if player.mo and player.mo.valid
			if player.rvgrpass == 0 and (player.mo.skin == "revenger") then
				R_SetPlayerSkin(player,ZE.survskinsplay[P_RandomRange(1,#ZE.survskinsplay)])
				chatprintf(player,"\x87\You need atleast 25 games played to use this character!",true)
	       end
	    end
	end
end

ZE.CheckUnlocks = function(player)	
	if player.gamesPlayed == 25 then
		ZE.UnlockRevenger(player)
	end
end

