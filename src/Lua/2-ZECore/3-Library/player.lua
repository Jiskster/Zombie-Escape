local ZE = RV_ZESCAPE
local CV = ZE.Console

freeslot(
"MT_RS_HS_SHOT",
"MT_RS_FIST"
)






local default = "defaultconfig"

ZE.CharacterConfig = function(player)
	if (player.mo and player.mo.valid)
		local skinname = skins[player.mo.skin].name
		local default = "defaultconfig"

		if ZE.CharacterStats[skinname] then
			player.normalspeed = ZE.CharacterStats[skinname].normalspeed
			player.runspeed = ZE.CharacterStats[skinname].runspeed
			player.jumpfactor = ZE.CharacterStats[skinname].jumpfactor
			player.charability = ZE.CharacterStats[skinname].charability
			player.charability2 = ZE.CharacterStats[skinname].charability2
			player.staminacost = ZE.CharacterStats[skinname].staminacost
			player.staminarun = ZE.CharacterStats[skinname].staminarun
			player.staminanormal = ZE.CharacterStats[skinname].staminanormal
			
			if ZE.CharacterStats[skinname].actionspd then
				player.actionspd = ZE.CharacterStats[skinname].actionspd
			end
			if ZE.CharacterStats[skinname].accelstart then
				player.accelstart = ZE.CharacterStats[skinname].accelstart
			end
			if ZE.CharacterStats[skinname].acceleration then
				player.acceleration = ZE.CharacterStats[skinname].acceleration
			end
		else 
			player.normalspeed = ZE.CharacterStats[default].normalspeed 
			player.runspeed = ZE.CharacterStats[default].runspeed 
			player.jumpfactor = ZE.CharacterStats[default].jumpfactor 
			player.charability = ZE.CharacterStats[default].charability 
			player.charability2 = ZE.CharacterStats[default].charability2
			player.staminacost = ZE.CharacterStats[default].staminacost
			player.staminarun = ZE.CharacterStats[default].staminarun
			player.staminanormal = ZE.CharacterStats[default].staminanormal  
		end
		

		
		if (player.ctfteam == TEAM_ZOMBIE)
			player.charflags = SF_NOJUMPSPIN|SF_NOJUMPDAMAGE|SF_NOSKID
			player.powers[pw_underwater] = 30*TICRATE
		end
		
		if (player.ctfteam == TEAM_SURVIVOR)
			player.charflags = SF_NOJUMPSPIN|SF_NOSKID
		end
	end
end

ZE.InsertUnlocked = function(player)
	player.rvgrpass = $ or 0
	player.gamesPlayed = $ or 0
end

ZE.CharacterStamina = function(player)
	if (gametype == GT_ZESCAPE)
		player.stamina = $ or 0
		if not (player.mo and player.mo.valid) return end
		if (player.mo.skin == "dzombie") return end
		local cmd = player.cmd
		local skinname = skins[player.mo.skin].name
		local default = "defaultconfig"

		local buttoncheck = ((not (player.stamina <= 0)) 
		and (player.cmd.buttons & BT_CUSTOM1) 
		and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0))

		local staminacheck = player.staminanormal and player.staminarun and player.staminacost
		if buttoncheck and staminacheck
			player.normalspeed = player.staminanormal
			player.runspeed = player.staminarun
			player.stamina = $ - player.staminacost
		end
		if not (player.stamina >= 100*TICRATE) and (player.stamina <= 25*TICRATE)
			player.stamina = $+2
		end
		if not (player.stamina >= 100*TICRATE) and (player.stamina >=25*TICRATE)
			player.stamina = $+4
		end
		if (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) then
			player.normalspeed = 8*FRACUNIT
		end
	end
end

ZE.ZtypeCfg = function(player)
	if not (gametype == GT_ZESCAPE) then return end
	if (player.mo and player.mo.valid)
		if not (player.ctfteam == TEAM_SURVIVOR) and CV.gamestarted then
			if (player.ztype == "ZM_ALPHA") then
				player.mo.scale = ZE.ZombieStats["ZM_ALPHA"].scale
			end

			if (player.ztype == "ZM_TANK") then
				player.mo.scale = ZE.ZombieStats["ZM_TANK"].scale
			end
		elseif (player.ctfteam == TEAM_SURVIVOR) or (player.spectator == 1) then
			return
		end

		if not (leveltime < CV.waittime) and not (player.ctfteam == TEAM_SURVIVOR)  then
			if (player.ztype) and not (player.boost == 1) then
				player.normalspeed = ZE.ZombieStats[player.ztype].normalspeed
				player.jumpfactor = ZE.ZombieStats[player.ztype].jumpfactor
			end
			/*
			if (player.ztype == ZM_FAST)
				player.normalspeed = ZE.ZombieStats["Fast"].normalspeed
				player.jumpfactor = ZE.ZombieStats["Fast"].jumpfactor
			end

			if (player.ztype == ZM_TANK)
				player.normalspeed = ZE.ZombieStats["Tank"].normalspeed
				player.jumpfactor = ZE.ZombieStats["Tank"].jumpfactor
			end
			*/
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

ZE.ZtypeAura = function()
  if not (gametype == GT_ZESCAPE) then return end
    for player in players.iterate
        if player.mo and player.mo.valid and player.mo.skin == "dzombie"
        and player.playerstate == PST_LIVE
        and not player.powers[pw_carry]
        and not P_PlayerInPain(player)
        and not player.exiting
			if (player.ztype == "ZM_ALPHA")
				local zombienumber1 = P_SpawnGhostMobj(player.mo)
				zombienumber1.color = P_RandomRange(SKINCOLOR_RED, SKINCOLOR_RUBY)
				zombienumber1.colorized = true
				zombienumber1.fuse = 1
				zombienumber1.blendmode = AST_ADD
				P_TeleportMove(zombienumber1, player.mo.x, player.mo.y, player.mo.z - 4*FRACUNIT)
				zombienumber1.frame = $|FF_ADD
				zombienumber1.scale = 15*FRACUNIT/10
				if zombienumber1.tracer
					zombienumber1.tracer.fuse = zombienumber1.fuse
				end
			end
			
			
			if (player.ztype == "ZM_FAST")
				local zombienumber1 = P_SpawnGhostMobj(player.mo)
				zombienumber1.color = SKINCOLOR_MOSS
				zombienumber1.colorized = true
				zombienumber1.fuse = 1
				zombienumber1.blendmode = AST_ADD
				P_TeleportMove(zombienumber1, player.mo.x, player.mo.y, player.mo.z - 4*FRACUNIT)
				zombienumber1.frame = $|FF_ADD
				if zombienumber1.tracer
					zombienumber1.tracer.fuse = zombienumber1.fuse
				end
				player.mo.colorized = true
				player.mo.color = SKINCOLOR_MOSS
			end	
        end
    end
end

ZE.CharacterColors = function()
	for player in players.iterate
		if player.mo and player.mo.valid then
			player.mo.color = player.skincolor
			if CV.lockcolors.value == 1 then
				player.mo.color = skins[player.mo.skin].prefcolor
			end
			
			if player.mo.skin == "dzombie" then
				player.mo.color = SKINCOLOR_ZOMBIE
				if player.ztype == "ZM_ALPHA" then
					player.mo.color = SKINCOLOR_ALPHAZOMBIE
				end
				
				if player.ztype == "ZM_TANK" then
					player.mo.color = SKINCOLOR_SEAFOAM
				end
			end
		end
	end
end

mobjinfo[MT_CORK].speed = 152*FRACUNIT //Balance tweak to preserve some of the challenge

ZE.CorkStuff = function(mo)
	return true //Overwrite default behavior so that corks won't damage invulnerable players
end

//Add ghost trail to the cork to improve its visibility
ZE.CorkTrail = function(mo)
	if mo.flags&MF_MISSILE and mo.target and mo.target.player then
		local ghost = P_SpawnGhostMobj(mo)
		ghost.destscale = ghost.scale*4
		if not(gametyperules&GTR_FRIENDLY) //Add color trail to competitive gametypes
			ghost.colorized = true
			ghost.color = mo.target.player.skincolor
		end
	end
end

ZE.StartHealth = function(player)
	local skinname = skins[player.mo.skin].name
	local default = "defaultconfig"
    if not (gametype == GT_ZESCAPE) return end
	if not (leveltime > CV.waittime) then 
		if (player.mo and player.mo.valid) then
			if ZE.CharacterStats[skinname] then
				player.mo.health = ZE.CharacterStats[skinname].startHealth
				player.mo.maxHealth = ZE.CharacterStats[skinname].maxHealth
			else
				player.mo.health = ZE.CharacterStats[default].startHealth
				player.mo.maxHealth = ZE.CharacterStats[default].maxHealth
			end
    	end
	end
end

ZE.HealthLimit = function(player)
	local skinname = skins[player.mo.skin].name
	local default = "defaultconfig"
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		local checkvars = player.mo.maxHealth and player.mo.health
		if checkvars then
			if player.mo.health > player.mo.maxHealth
				player.mo.health = player.mo.maxHealth
			end
		end
	end
end

ZE.AmyRegen = function(player)
	local checkvars = player.mo.maxHealth and player.mo.health
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
	  if not (player.mo.skin == "amy") return end
	    player.regen = $ or 0
	    if checkvars and (player.mo.health < player.mo.maxHealth) then
		  player.regen = $1 - 1
		end
		if (player.regen <= 0*TICRATE) then
		   player.mo.health = $ + 1
		   player.regen = 1*TICRATE
		else
		    return end
	end
end
ZE.ZombieRegen = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
	  if not (player.mo.skin == "dzombie") return end
	    player.regen = $ or 0
	    if ( (player.mo.health < player.mo.maxHealth) and (player.ztype ~= "ZM_ALPHA") ) then
		  player.regen = $1 - 1
		end
		if (player.regen <= 0*TICRATE) then
		   local increment = 20
		   if not (player.mo.health + increment > player.mo.maxHealth) -- kinda the limit for zombies is 1000 for healing
			  player.mo.health = $ + increment
		   else
			  player.mo.health = player.mo.maxHealth
		   end
		   player.regen = 10*TICRATE
		else
		    return end
	end
end

ZE.ZombieHealth = function(player)
	if gametype == GT_ZESCAPE
		if player.mo and player.mo.valid
			if player.ctfteam == TEAM_SURVIVOR return end
			if player.powers[pw_flashing] > 0 or not (player.spectator) then
				if (player.ctfteam == TEAM_ZOMBIE) and not (player.ztype)
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
			end
		end
	end
end

ZE.ZombieSwarmWave = function(player)
	if gametype ~= GT_ZESCAPE return end
	if player.mo and player.mo.valid
		if player.ctfteam == TEAM_SURVIVOR return end
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

ZE.HealthOrb = function(obj, play)
	local player = play.player
	if (player.mo) and (player.ctfteam == TEAM_SURVIVOR)
		player.mo.maxHealth = $ + 200
		player.mo.health = $ + 200
		P_GivePlayerRings(player, 275)
	end
end

