local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.HandleZombie = function(player) --zombie health and ztype config combined
	if gametype == GT_ZESCAPE
		if player.mo and player.mo.valid then
			if player.ctfteam == 2 then return end
			if not (player.spectator) then
				if CV.gamestarted then
					if player.ztype and ZE.ZombieStats[player.ztype] and ZE.ZombieStats[player.ztype].scale then
						player.mo.scale = ZE.ZombieStats[player.ztype].scale
					end
					if (player.ztype) and not (player.boost == 1) then
						player.normalspeed = ZE.ZombieStats[player.ztype].normalspeed
						player.jumpfactor = ZE.ZombieStats[player.ztype].jumpfactor
					end
				end
				if player.powers[pw_flashing] == 0 then return end -- stop if not invincible frames on spawn
				if not (player.ztype) then 
					player.mo.health = ZE.ZombieStats["ZM_NORMAL"].startHealth + (35*ZE.survcount)
					player.mo.maxHealth = ZE.ZombieStats["ZM_NORMAL"].maxHealth + (35*ZE.survcount)      --normal zombie health
				end
				if (player.ztype == "ZM_ALPHA")
					player.mo.health = ZE.ZombieStats["ZM_ALPHA"].startHealth + (40*ZE.survcount)
					player.mo.maxHealth = ZE.ZombieStats["ZM_ALPHA"].maxHealth + (40*ZE.survcount)
				end	
				
				if (player.ztype == "ZM_FAST")
					player.mo.health = ZE.ZombieStats["ZM_FAST"].startHealth + (25*ZE.survcount)
					player.mo.maxHealth = ZE.ZombieStats["ZM_FAST"].maxHealth + (25*ZE.survcount)
				end
				--zombie swarm
				if (player.ztype == "ZM_TANK")
					player.mo.health = ZE.ZombieStats["ZM_TANK"].startHealth + (150*ZE.survcount)
					player.mo.maxHealth = ZE.ZombieStats["ZM_TANK"].maxHealth + (150*ZE.survcount)
				end	
				
				if (player.ztype == "ZM_TINY")
					player.mo.health = ZE.ZombieStats["ZM_TINY"].startHealth + (10*ZE.survcount)
					player.mo.maxHealth = ZE.ZombieStats["ZM_TINY"].maxHealth + (10*ZE.survcount)
				end	

			end
		end
	end
end

ZE.AlphaZmRage = function(player)
    if not (player.ztype == "ZM_ALPHA") then return end
	if not player.playerstate != PST_LIVE
	if (player.mo and player.mo.valid)
		player.boosttimer = $ or 0
		player.boostcount = $ or 0
			if (player.boosttimer == 0)
			and (player.boostcount > 0)
				player.boostcount = $ - 1
			end
			if (player.boostcount == 0) and (player.boosttimer == 0) and (player.cmd.buttons & BT_CUSTOM1)
				player.boosttimer = 3*TICRATE
				S_StartSound(player.mo, sfx_bstup)
			end
			if (player.boosttimer ~= 0)
				player.normalspeed = 45*FRACUNIT
				player.charability = CA_JUMPTHOK
				player.actionspd = 35*FRACUNIT
				P_SpawnGhostMobj(player.mo)
			else
				return
			end
			if (player.boosttimer > 0)
				if (player.boosttimer == 1)
					player.boostcount = 12*TICRATE
					S_StartSound(player.mo, sfx_bstdn)
				end
				player.boosttimer = $ - 1
		  end
	   end
	end
end

ZE.InitZtype = function()
	if not (gametype == GT_ZESCAPE) then return end
		for player in players.iterate
			if (player.ctfteam == 1) and (leveltime-CV.waittime <= 10*TICRATE) and (player.playerstate == PST_DEAD) then
				player.ztype = $ or 0
				
				if not (mapheaderinfo[gamemap].zombieswarm) then
					player.ztype = "ZM_ALPHA"
				end
			end
			if (player.ctfteam == 1) and (player.playerstate == PST_DEAD) and (leveltime-CV.waittime >= 10*TICRATE) then
				player.ztype = 0
			end
			if (player.ctfteam == 2) or (player.spectator == 1) then
				player.ztype = 0
			end
			if ZE.alpha_attack == 1 and player.mo and player.mo.valid and player.mo.skin == "dzombie" then
				player.ztype = "ZM_ALPHA"
			end
	end
end