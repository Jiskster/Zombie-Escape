local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console
CV.allowcreatezombie = CV_RegisterVar{
	name = "ze_allowcreatezombie",
	defaultvalue = "On",
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
	
	if ZE.Ztypes[arg1] == nil then
		CONS_Printf(player, "Invalid Ztype.")
		return
	end
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

COM_AddCommand("ze_generatezombie", function(player, name, ... )
	local is_server
	local isclone
	if player == server then 
		is_server = true 
	end
	if not is_server then
		if (not IsPlayerAdmin(player) and not CV.allowcreatezombie.value) then --if not admin and cvar is false
			CONS_Printf(player, "You are not allowed to run this command.")
			return
		end
	end

	
	local p_name = "ZOMBIE" .. tostring(P_RandomRange(1,10000))
	local p_skincolor = P_RandomRange(1,#skincolors)
	local p_normalspeed = P_RandomRange(16,21)*FRACUNIT
	local p_jumpfactor = 24 * FRACUNIT / P_RandomRange(10,25)
	local p_charability = CA_NONE
	local p_charability2 = CA2_NONE
	local p_startHealth = P_RandomRange(500, 800)
	local p_maxHealth = P_RandomRange(500, 800)
	local p_scale = P_RandomRange(10,20)*FRACUNIT/10
	local p_schm = 0
	local p_effect 
	if name then
		p_name = name
	end
	for i,v in ipairs(ZE.Ztypes.names)
		if v == p_name then
			CONS_Printf(player, p_name.." already exists!")
			return
		end
	end
	if name and name:len() > 25 and not IsPlayerAdmin(player) then
		CONS_Printf(player, "The name must be below 25 characters.")
		return
	end
	
	if name and name:find(" ") then
		CONS_Printf(player, "The name must have no spaces.")
		return
	end
	--zombscript interpeter
	for _,v in ipairs({...}) do
		local commands = {
			[1] = "ns:",
			[2] = "sh:",
			[3] = "mh:",
			[4] = "schm:",
			[5] = "scale:",
			[6] = "color:",
			[7] = "effect:",
		}

		-- [normalspeed] --
		if v:sub(1,#commands[1]) == commands[1] then
			local lastarg = v:sub(#commands[1] + 1)
			if lastarg and tonumber(lastarg) then --does it exist? and can it be a number without being nil?
				p_normalspeed = tonumber(lastarg)*FRACUNIT
			end
		end

		-- [startHealth] --
		if v:sub(1,#commands[2]) == commands[2] then
			local lastarg = v:sub(#commands[2] + 1)
			if lastarg and tonumber(lastarg) then
				p_startHealth = tonumber(lastarg)
			end
		end
		-- [maxHealth] --
		if v:sub(1,#commands[3]) == commands[3] then
			local lastarg = v:sub(#commands[3] + 1)
			if lastarg and tonumber(lastarg) then
				p_maxHealth = tonumber(lastarg)
			end
		end

		-- [schm / survivorcounthealthmultiplier] --
		if v:sub(1,#commands[4]) == commands[4] then
			local lastarg = v:sub(#commands[4] + 1)
			if lastarg and tonumber(lastarg) then
				p_schm = tonumber(lastarg)
			end
		end
		
		-- [scale] --
		if v:sub(1,#commands[5]) == commands[5] then
			local lastarg = v:sub(#commands[5] + 1)
			if lastarg and tonumber(lastarg) then
				p_scale = tonumber(lastarg)*FRACUNIT
			end
		end
		
		-- [skincolor] --
		-- WIP -- 
		if v:sub(1,#commands[6]) == commands[6] then
			local lastarg = v:sub(#commands[6] + 1)
			if lastarg and tonumber(lastarg) then
				if not p_skincolor == ZE.GetSkincolor(lastarg) then
					CONS_Printf(player, "Invalid skin color in [color:].")
				end
				p_skincolor = ZE.GetSkincolor(lastarg)
				
			end
		end
		
		if v:sub(1,#commands[7]) == commands[7] then
			local lastarg = v:sub(#commands[7] + 1)
			if lastarg and tonumber(lastarg) then
				p_effect = lastarg
			end
		end
	end
	local submittedztypes = #player.submittedztypes
	if not IsPlayerAdmin(player) or not is_server then  -- i trust the admins
		if submittedztypes + 1 > CV.maxztypeperplayer.value then
			CONS_Printf(player, "Reached maximum submitted ztypes [\$submittedztypes\], rejoin or wait for the limit to rise.")
			return
		end
	end
	table.insert(player.submittedztypes, p_name)

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
		author = player, -- player_t
		effect = p_effect,
	})

	chatprint("\x82* The zombie type \x83" .. p_name:upper() .. "\x82\ has been added.")
end)

COM_AddCommand("ze_listzombies", function(player)
	if ((not IsPlayerAdmin(player) or not player == server) and not CV.allowcreatezombie.value) then --if not admin and cvar is false
		CONS_Printf(player, "You are not allowed to run this command.")
		return
	end
	for i,v in ipairs(ZE.Ztypes.names)
		if ZE.Ztypes[v] then
			local the_color = skincolors[ZE.Ztypes[v].info.skincolor].name
			CONS_Printf(player,"\x85 ".. ZE.Ztypes[v].name.. " | Color: "..the_color)
		end
	end
end)
COM_AddCommand("ze_clearzombies", function(player)
	ZE.ClearZombies()
	for player in players.iterate do
		player.submittedztypes = {}
	end
	CONS_Printf(player, "Cleared every custom zombie")
end)

COM_AddCommand("ze_removezombie", function(player, ztype)
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
