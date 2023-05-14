local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console
CV.allowcreatezombie = CV_RegisterVar{
	name = "ze_allowcreatezombie",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	PossibleValue = CV_OnOff
}
COM_AddCommand("ze_spectate", function(player)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	player.spectator = 1
	player.ctfteam = 0
end, 1)

COM_AddCommand("ze_maxrings", function(player)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	player.rings = 9999
end, 1)

COM_AddCommand("ze_liststats", function(player)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	local string1 = "\x82\<%s> -> Games Played: (%s) | Has Revenger: (%s)"
	local string2 = "\x83\<%s> -> Games Played: (%s) | Has Revenger: (%s)"
	if player.gamesPlayed == nil or player.rvgrpass == nil then return end
	CONS_Printf(player, string.format(string2, player.name, player.gamesPlayed, player.rvgrpass))
	for listplayer in players.iterate do
		if listplayer == player then
			continue
		end
		CONS_Printf(player, string.format(string1, listplayer.name, listplayer.gamesPlayed, listplayer.rvgrpass))
	end
end)

COM_AddCommand("ze_cleardata", function(player,arg1) --rvgrpass
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	local string = "\x87\Cleared save for %s"
	if not arg1 then
		player.rvgrpass = 0
		player.gamesPlayed = 0
		COM_BufInsertText(player, "savestuff")
		CONS_Printf(player,string.format(string,player.name))
	else 
		arg1 = tonumber(arg1)
		
		if not players[arg1] then
			local string2 = "\x87\Player doesn't exist. (Use getplayernum for the player number)"
			CONS_Printf(player,string2)
			return
		end
		
		players[arg1].rvgrpass = 0
		players[arg1].gamesPlayed = 0
		
		COM_BufInsertText(players[arg1], "savestuff")
		CONS_Printf(players[arg1],string.format(string,players[arg1].name))
		
	end
end,1)

COM_AddCommand("ze_forcewin", function(player, arg1)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	arg1 = tonumber(arg1)
	if arg1 ~= nil and arg1 <= 2 and arg1 > 0 then
		if arg1 == 1 then
			ZE.Win(1)
		end
		
		if arg1 == 2 then
			ZE.Win(2)
		end
	else
		CONS_Printf(player, "Invalid number")
	end
end,1)

/*
COM_AddCommand("ze_spawnzombienpc", function(player)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	ZE.SpawnZombieNPC(player)
end,1)
*/

COM_AddCommand("ze_changeztype", function(player, arg1)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	arg1 = tonumber(arg1)
	if player.mo and player.mo.valid and arg1 ~= nil then
		player.ztype = arg1
	end
end,1)


COM_AddCommand("ze_suicide", function(player)
	if player.mo and player.mo.valid then
		player.suicided = true
		P_DamageMobj(player.mo, nil, nil, 1, DMG_INSTAKILL)
	end
end)

COM_AddCommand("ze_generatezombie", function(player, name)
	if (not (IsPlayerAdmin(player)) and CV.allowcreatezombie.value == false) then
		CONS_Printf(player, "You are not allowed to run this command.")
		return
	end
	local p_name = "ZombieType" .. tostring(P_RandomRange(1,10000))
	local p_skincolor = P_RandomRange(1,#skincolors)
	local p_normalspeed = P_RandomRange(16,21)*FRACUNIT
	local p_jumpfactor = 24 * FRACUNIT / P_RandomRange(10,25)
	local p_charability = CA_NONE
	local p_charability2 = CA2_NONE
	local p_startHealth = P_RandomRange(500, 800)
	local p_maxHealth = P_RandomRange(500, 800)
	local p_scale = P_RandomRange(10,20)*FRACUNIT/10
	local p_schm = P_RandomRange(40, 60)
	if name then
		p_name = name
	end


	ZE.AddZombie(p_name, {
		skincolor = p_skincolor,
		normalspeed = p_normalspeed,
		jumpfactor = p_jumpfactor,
		charability = CA_NONE,
		charability2 = CA2_NONE,
		startHealth = p_startHealth,
		maxHealth = p_maxHealth,
		scale = p_scale,	
		schm = p_schm, --servercount health multiplier
	})

	chatprint("\x82\* The zombie type \x83\ " .. p_name:upper() .. "\x82\ has been added.")
end)

COM_AddCommand("ze_listzombies", function(player)
	if (not (IsPlayerAdmin(player)) and CV.allowcreatezombie.value == false) then
		CONS_Printf(player, "You are not allowed to run this command.")
		return
	end
	for i,v in ipairs(ZE.Ztypes.names)
		if ZE.Ztypes[v] then
			CONS_Printf(player,"\x85\ ".. ZE.Ztypes[v].name)
		end
	end
end)


COM_AddCommand("ze_removezombie", function(player, ztype)
	local protectedlist = {"ZM_ALPHA", "ZM_FAST", "ZM_TANK", "ZM_TINY"}
	if not ztype or type(ztype) ~= "string" or not ZE.Ztypes[ztype] then
		CONS_Printf(player,"\x85\ ERROR: INVALID ZTYPE")
		return
	end
	if ZE.Ztypes[ztype].protected then
		CONS_Printf(player,"\x85\ ERROR: CANNOT DELETE PROTECTED ZTYPE")
		return
	end
	for i,v in ipairs(ZE.Ztypes.names) do -- FIND ZTYPE
		if v == ztype then
			table.remove(ZE.Ztypes.names, i)
			ZE.Ztypes[ztype] = nil
			CONS_Printf(player,"\x82\ SUCCESSFULLY REMOVED ZTYPE")
			break
		end
	end
end)
