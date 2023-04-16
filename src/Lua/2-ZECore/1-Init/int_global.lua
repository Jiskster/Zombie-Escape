rawset(_G,"RV_ZESCAPE",{})
local ZE = RV_ZESCAPE

ZE.Console = {}

G_AddGametype({
	name = "Zombie Escape",
	identifier = "zescape",
	typeoflevel = TOL_ZESCAPE,
	rules = GTR_RINGSLINGER|GTR_TEAMS|GTR_HURTMESSAGES|GTR_TIMELIMIT|GTR_ALLOWEXIT|GTR_RESPAWNDELAY|GTR_SPAWNENEMIES|GTR_CUTSCENES,
	intermissiontype = int_teammatch,
	headerleftcolor = 152,
	headerrightcolor = 40,
	description = "Escape from the Zombies! Don't get caught and eaten by them! They can catch up with you anytime..."
})

--kays#5325
ZE.GOTONHelper = function(t)
	return _G[t]
end

ZE.GetObjectTypeOrNull = function(t)
	local status, value = pcall(ZE.GOTONHelper, t)
	return status and value or MT_NULL 
end

ZE.addHP = function(mobj, hp)
	if mobj and mobj.valid then
		if mobj.health + hp > mobj.maxHealth then
			mobj.health = mobj.maxHealth
			return
		end
		mobj.health = $ + hp
	end
end

ZE.subHP = function(mobj, hp)
	if mobj and mobj.valid then
		mobj.health = $ - hp
	end
end

ZE.setHP = function(mobj, hp)
	if mobj and mobj.valid then
		if mobj.health + hp > mobj.maxHealth then
			mobj.health = mobj.maxHealth
			return
		end
		
		mobj.health = hp
	end
end

ZE.setStatDefaults = function(player)
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
	
	if ZE.CharacterStats[skinname] then
		player.mo.health = ZE.CharacterStats[skinname].startHealth
		player.mo.maxHealth = ZE.CharacterStats[skinname].maxHealth
	else
		player.mo.health = ZE.CharacterStats[default].startHealth
		player.mo.maxHealth = ZE.CharacterStats[default].maxHealth
	end
end