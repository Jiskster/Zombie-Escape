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

ZE.StartHealth = function(player)
	local skinname = skins[player.mo.skin].name
	local default = "defaultconfig"
    if not (gametype == GT_ZESCAPE) return end
	if CV.gamestarted == false then 
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
