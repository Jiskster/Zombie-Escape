local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.CharacterStats = {
	["defaultconfig"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_NONE,
		charability2 = CA2_NONE,
    },
	["sonic"] = {
		normalspeed = 22 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_JUMPTHOK,
		charability2 = CA2_NONE,
		actionspd = 18 * FRACUNIT,
	},
	["tails"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_NONE,
		charability2 = CA2_NONE,
    },
    ["knuckles"] = {
        normalspeed = 18 * FRACUNIT,
        runspeed = 100 * FRACUNIT,
        jumpfactor = 17 * FRACUNIT / 19,
        charability = CA_NONE,
        charability2 = CA2_NONE,
    },
    ["amy"] = {
        normalspeed = 18 * FRACUNIT,
        runspeed = 100 * FRACUNIT,
        jumpfactor = 17 * FRACUNIT / 19,
        charability = CA_NONE,
        charability2 = CA2_MELEE,
    },
    ["metalsonic"] = {
        normalspeed = 18 * FRACUNIT,
        runspeed = 100 * FRACUNIT,
        jumpfactor = 17 * FRACUNIT / 19,
        charability = CA_NONE,
        charability2 = CA2_NONE,
    },
	["dzombie"] = {
	    normalspeed = 25*FRACUNIT,
		runspeed = 100*FRACUNIT,
		jumpfactor = 1*FRACUNIT,
		charability = CA_NONE,
		charability2 = CA2_NONE,
	},
	["milne"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 12 * FRACUNIT/10,
		charability = CA_NONE,
		charability2 = CA2_NONE,
		charflags = SF_NOJUMPSPIN|SF_NOSKID,
	},
	["scarf"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_NONE,
		charability2 = CA2_NONE,
	},
	["bob"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_NONE,
		charability2 = CA2_GUNSLINGER,
	},
	["revenger"] = {
		normalspeed = 18*FRACUNIT,
		runspeed = 14 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_NONE,
		charability2 = CA2_NONE,
	},
	["w"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 18 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_AIRDRILL,
		charability2 = CA2_NONE,
	},
	["serpentine"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT/19,
		charability = CA_NONE,
		charability2 = CA2_NONE,
	},
	["steve"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT / 19,
		charability = CA_NONE,
		charability2 = CA2_NONE,
	},
	["oof"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		jumpfactor = 17 * FRACUNIT/19,
		charability = CA_NONE,
		charability2 = CA2_NONE,
	},
	["peppino"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		charability = CA_SWIM,
		charability2 = CA2_GUNSLINGER,
	},
	["noise"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		charability = CA_BOUNCE,
		charability2 = CA2_NONE,
	},
	["snick"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		charability = CA_JUMPTHOK,
		charability2 = CA2_NONE,
		actionspd = 5 * FRACUNIT,
	},
	["fakepep"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		charability = CA_DOUBLEJUMP,
		charability2 = CA2_NONE,
	},
	["motobugze"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		charability = CA_DOUBLEJUMP,
		charability2 = CA2_NONE,
	},
	["chaoze"] = {
		normalspeed = 18 * FRACUNIT,
		runspeed = 100 * FRACUNIT,
		charability = CA_DOUBLEJUMP,
		charability2 = CA2_NONE,
	},
}

ZE.CharacterConfig = function(player)
	if (player.mo and player.mo.valid)
		local skinname = skins[player.mo.skin].name
		local default = "defaultconfig"
		player.normalspeed = ZE.CharacterStats[skinname].normalspeed or ZE.CharacterStats[default].normalspeed 
		player.runspeed = ZE.CharacterStats[skinname].runspeed or ZE.CharacterStats[default].runspeed
		player.jumpfactor = ZE.CharacterStats[skinname].jumpfactor or ZE.CharacterStats[default].jumpfactor
		player.charability = ZE.CharacterStats[skinname].charability or ZE.CharacterStats[default].charability
		player.charability2 = ZE.CharacterStats[skinname].charability2 or ZE.CharacterStats[default].charability2
		if ZE.CharacterStats[skinname].actionspd then
			player.actionspd = ZE.CharacterStats[skinname].actionspd
		end
		if (player.ctfteam == 1)
			player.charflags = SF_NOJUMPSPIN|SF_NOJUMPDAMAGE|SF_NOSKID
			player.powers[pw_underwater] = 30*TICRATE
		end
		if (player.ctfteam == 2)
			player.charflags = SF_NOJUMPSPIN|SF_NOSKID
		end
	end
end

ZE.CharacterStamina = function(player)
	if (gametype == GT_ZESCAPE)
	    player.stamina = $ or 0
		if not (player.mo and player.mo.valid) return end
		local cmd = player.cmd
	   if (player.mo.skin == "sonic") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 31*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -15
	   elseif (player.mo.skin == "tails") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 23*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -12
	   elseif (player.mo.skin == "knuckles") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 22*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -16
	   elseif (player.mo.skin == "amy") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 24*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -12
	   elseif (player.mo.skin == "metalsonic") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 23*FRACUNIT
		   player.runspeed = 5*FRACUNIT
		   player.stamina = $ -13
	   elseif (player.mo.skin == "fang") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 23*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -11
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

ZE.AlphaZmCfg = function(player)
	if not (gametype == GT_ZESCAPE) then return end
	if (player.mo and player.mo.valid)
		if (player.alphazm == 1) and not (player.ctfteam == 2)
			player.mo.scale = 13*FRACUNIT/10
		elseif (player.ctfteam == 2) or (player.spectator == 1) then
			return
		end
		if (player.alphazm == 1) and not (player.boost == 1) and not (player.ctfteam == 2) and not (leveltime < CV.waittime) then
			player.normalspeed = 23*FRACUNIT
			player.jumpfactor = 17*FRACUNIT/22
		end
	end
end

ZE.AlphaZmRage = function(player)
    if not (player.alphazm == 1) then return end
	if not player.playerstate != PST_LIVE
	if (player.mo and player.mo.valid)
		player.boosttimer = $ or 0
		player.boostcount = $ or 0
			if (player.boosttimer == 0)
			and (player.boostcount > 0)
				player.boostcount = $ - 1
			end
			if (player.boostcount == 0) and (player.boosttimer == 0) and (player.cmd.buttons & BT_CUSTOM1)
				player.boosttimer = 5*TICRATE
				S_StartSound(player.mo, sfx_bstup)
			end
			if (player.boosttimer ~= 0)
				player.normalspeed = 40*FRACUNIT
				player.charability = CA_JUMPTHOK
				player.actionspd = 30*FRACUNIT
				P_SpawnGhostMobj(player.mo)
			else
				return
			end
			if (player.boosttimer > 0)
				if (player.boosttimer == 1)
					player.boostcount = 45*TICRATE
					S_StartSound(player.mo, sfx_bstdn)
				end
				player.boosttimer = $ - 1
		  end
	   end
	end
end

ZE.AlphaZmAura = function()
  if not (gametype == GT_ZESCAPE) then return end
    for player in players.iterate
        if player.mo and player.mo.valid and player.mo.skin == "dzombie"
        and player.playerstate == PST_LIVE
        and not player.powers[pw_carry]
        and not P_PlayerInPain(player)
        and not player.exiting
			 if (player.alphazm == 1)
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
        end
    end
end

ZE.CharacterColors = function()
	for player in players.iterate
		if (player.mo and player.mo.valid)
			player.mo.color = skins[player.mo.skin].prefcolor
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
    if not (gametype == GT_ZESCAPE) return end
	if not (leveltime > CV.waittime)
	if (player.mo and player.mo.valid)
	  if (player.mo.skin == "sonic")
		player.mo.health = 125
	elseif (player.mo.skin == "tails")
		player.mo.health = 95
	elseif (player.mo.skin == "knuckles")
		player.mo.health = 175
	elseif (player.mo.skin == "amy")
		player.mo.health = 100
	elseif (player.mo.skin == "fang")
		player.mo.health = 150
	elseif (player.mo.skin == "metalsonic")
		player.mo.health = 150
	      end
       end
	end
end

ZE.HealthLimit = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
	  if (player.mo.skin == "sonic" and player.mo.health > 125) and not (player.maxhp == 1) then
		player.mo.health = 125
	elseif (player.mo.skin == "tails" and player.mo.health > 95) and not (player.maxhp == 1) then
		player.mo.health = 95
	elseif (player.mo.skin == "knuckles" and player.mo.health > 175) and not (player.maxhp == 1) then
		player.mo.health = 175
	elseif (player.mo.skin == "amy" and player.mo.health > 200) and not (player.maxhp == 1) then
		player.mo.health = 200
	elseif (player.mo.skin == "fang" and player.mo.health > 150) and not (player.maxhp == 1) then
		player.mo.health = 150
	elseif (player.mo.skin == "metalsonic" and player.mo.health > 150) and not (player.maxhp == 1) then
		player.mo.health = 150
    elseif (survskins and player.maxhp == 1 and player.mo.health > 400) and not (player.ctfteam == 1) then
	    player.mo.health = 400
		end
	end
end

ZE.AmyRegen = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
	  if not (player.mo.skin == "amy") return end
	    player.regen = $ or 0
	    if (player.mo.health < 200) then
		  player.regen = $1 - 1
		end
		if (player.regen <= 0*TICRATE) then
		   player.mo.health = $ + 2
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
	    if ( (player.mo.health < 900) and (not player.alphazm) )
		or ( (player.mo.health < 2000) and (player.alphazm == 1) ) then
		  player.regen = $1 - 1
		end
		if (player.regen <= 0*TICRATE) then
		   if not (player.mo.health + 100 > 1000) -- kinda the limit for zombies is 1000 for healing
			  player.mo.health = $ + 100
		   end
		   player.regen = 12*TICRATE
		else
		    return end
	end
end

ZE.ZombieHealth = function(player)
if gametype == GT_ZESCAPE
 if player.mo and player.mo.valid
  if player.ctfteam == 2 return end
   if (player.ctfteam == 1) and not (player.spectator) and not (player.alphazm == 1)
     and player.powers[pw_flashing] > 0
		player.mo.health = 900 --normal zombie health
		end
		 if (player.alphazm == 1) and player.powers[pw_flashing] > 0 then
		   player.mo.health = 2000 -- alpha zombie health
		   end
	   end
	end
end

ZE.HealthOrb = function(obj, play)
	local player = play.player
	if (player.mo) and (player.ctfteam == 2)
		player.maxhp = 1
		player.mo.health = $ +200
	end
end

