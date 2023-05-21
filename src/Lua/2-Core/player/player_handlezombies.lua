local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.HandleZombie = function(player) --zombie health and ztype config combined
	if gametype == GT_ZESCAPE
		if player.mo and player.mo.valid then
			if player.ctfteam == 2 then return end
			if not (player.spectator) then
				if CV.gamestarted == true then
					if player.ztype then
						if ZE.Ztypes[player.ztype] and ZE.Ztypes[player.ztype].info.scale then
							player.mo.scale = ZE.Ztypes[player.ztype].info.scale
						end
						if not (player.boost == 1) then -- if not alpha boosting
							player.normalspeed = ZE.Ztypes[player.ztype].info.normalspeed
							player.jumpfactor = ZE.Ztypes[player.ztype].info.jumpfactor
						end
					end
				end
				
				if player.powers[pw_flashing] == 0 then return end -- stop if not invincible frames on spawn
				
				--survcounthealthmulti
				
				local normal_schm = 35 -- server count health multiplier for common zombies
				if not (player.ztype) then -- if ur not special
					player.mo.health = ZE.ZombieStats["ZM_NORMAL"].startHealth + (normal_schm*ZE.survcount)
					player.mo.maxHealth = ZE.ZombieStats["ZM_NORMAL"].maxHealth + (normal_schm*ZE.survcount) 
					return 
				end
				
				local myschm = ZE.Ztypes[player.ztype].info.schm --schm = servercount health multiplier
				if myschm then
					player.mo.health = ZE.Ztypes[player.ztype].info.startHealth + (myschm*ZE.survcount) 
					player.mo.maxHealth = ZE.Ztypes[player.ztype].info.maxHealth + (myschm*ZE.survcount)
				else
					player.mo.health = ZE.Ztypes[player.ztype].info.startHealth
					player.mo.maxHealth = ZE.Ztypes[player.ztype].info.maxHealth
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