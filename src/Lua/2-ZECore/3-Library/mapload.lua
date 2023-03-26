local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.MapLoad = function(mapnum)
    if gametype == GT_ZESCAPE
       for player in players.iterate do
			player.respawned = 0
			player.maxhp = 0
			player.alphazm = 0
			player.boostcount = 0
			player.stamina = 100*TICRATE
			player.propspawn = 2
		end
            ZE.teamWin = 0
			ZE.infectdelay = 0
			ZE.winTriggerDelay = 0
			ZE.alpha_attack = 0
			ZE.alpha_attack_show = 0
			ZE.alpha_attack_doneshow = false
    end

end