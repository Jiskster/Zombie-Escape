local ZE = RV_ZESCAPE
local CV = ZE.Console


ZE.ZombieSwarmWave = function(player)
	if gametype ~= GT_ZESCAPE return end
	if player.mo and player.mo.valid
		if player.ctfteam == 2 return end
		if mapheaderinfo[gamemap].zombieswarm and not player.ztype then 
			if ZE.Wave == 1
				if player.powers[pw_flashing] > 0
					player.mo.health = 150 + (15*ZE.survcount)
					player.mo.maxHealth = 150 + (15*ZE.survcount)
				end
				player.normalspeed = 24*FRACUNIT
			end
			
			if ZE.Wave == 2
				if player.powers[pw_flashing] > 0
					player.mo.health = 175 + (30*ZE.survcount)
					player.mo.maxHealth = 175 + (30*ZE.survcount)
				end
				player.normalspeed = 28*FRACUNIT
			end
			
			if ZE.Wave == 3
				if player.powers[pw_flashing] > 0
					player.mo.health = 200 + (35*ZE.survcount)
					player.mo.maxHealth = 200 + (35*ZE.survcount)
				end
				player.normalspeed = 32*FRACUNIT
				player.charability = CA_NONE
				player.charability2 = CA2_SPINDASH
			end
			
			if ZE.Wave == 4
				if player.powers[pw_flashing] > 0
					player.mo.health = 315 + (40*ZE.survcount)
					player.mo.maxHealth = 315 + (40*ZE.survcount)
				end
				player.normalspeed = 32*FRACUNIT
				player.charability = CA_THOK
				player.charability2 = CA2_SPINDASH
			end
		end
	end
end

ZE.SwarmParition = function()
	if CV.gamestarted == true and mapheaderinfo[gamemap].zombieswarm
		if (CV.countup) == 60*TICRATE then
			ZE.Wave = $ + 1
			chatprint("\x83\<Zombie Swarm>\x80\ Wave "..ZE.Wave.." (+HP +SPD)")
		end
		
		if (CV.countup) == 60*TICRATE*2 then
			ZE.Wave = $ + 1
			chatprint("\x83\<Zombie Swarm>\x80\ Wave "..ZE.Wave.." (+HP +SPD +SPINDASH)")
		end
		
		if (CV.countup) == 60*TICRATE*3 then
			ZE.Wave = $ + 1
			chatprint("\x83\<Zombie Swarm>\x80\ Wave "..ZE.Wave.." (+HP +SPD +SPINDASH +THOK)")
		end
	end
end
