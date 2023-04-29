local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

COM_AddCommand("ze_spectate", function(player)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	player.spectator = 1
	player.ctfteam = 0
end, 1)

COM_AddCommand("unlockprop", function(player)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	player.propspawn = $+10
end, 1)

COM_AddCommand("liststats", function(player)
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

COM_AddCommand("togglegg", function(player)
	if (gametype ~= GT_ZESCAPE) then
		CONS_Printf(player, "The game mode must be Zombie Escape to use this command.")
		return
	end
	
	if player.hasGoldenGlow ~= 1 and IsPlayerAdmin(player) == false and not (player == server) then
		CONS_Printf(player, "You must atleast play 125 games to have this feature!")
		return
	end
	if player and player.valid and player.mo and player.mo.valid then
		if player.ggtoggle == nil then
			player.ggtoggle = true
			CONS_Printf(player,"\x87\Golden Glow On!")
		else
			player.ggtoggle = not player.ggtoggle
			CONS_Printf(player,"\x87\Golden Glow Off!")
			player.mo.colorized = false
		end
	end
end)

COM_AddCommand("cleardata", function(player,arg1) --rvgrpass
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


COM_AddCommand("zmsuicide", function(player)
	if player.mo and player.mo.valid then
		player.suicided = true
		P_DamageMobj(player.mo, nil, nil, 1, DMG_INSTAKILL)
	end
end)