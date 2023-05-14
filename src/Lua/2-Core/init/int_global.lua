rawset(_G,"RV_ZESCAPE",{})

rawset(_G,"TEAM_ZOMBIE",1)
rawset(_G,"TEAM_SURVIVOR",2)
local ZE = RV_ZESCAPE

ZE.Ztype_names = {}
ZE.Ztypes = {}

ZE.AddZombie = function(name, info) -- "info" is optional extra information
	if name == nil or type(name) ~= "string" then
		error("NAME is invalid type or nil.")
		return
	end
	
	local ztype_name = "ZM_"..name:upper()
	ZE.Ztypes[ztype_name] = {}
	
	local ztypetable = ZE.Ztypes[ztype_name] 
	
	ztypetable.name = name
	
	table.insert(ZE.Ztype_names,ztype_name) -- insert ZM_.....
	
	if info then
		if type(info) ~= "table" then
			error("INFO is invalid type or nil.")
			return
		end
		
		ztypetable.info = info
	end
end

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

ZE.IsPlayerZombie = function(player)
	if player and player.ctfteam == TEAM_ZOMBIE then
		return true
	else
		return false
	end
end

ZE.IsPlayerSurvivor = function(player)
	if player and player.ctfteam == TEAM_SURIVOR then
		return true
	else
		return false
	end
end
