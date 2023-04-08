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
	local string1 = "\x82\<%s> -> Games Played: (%s) | Has Revenger: (%s) | Has GoldenGlow: (%s)"
	local string2 = "\x83\<%s> -> Games Played: (%s) | Has Revenger: (%s) | Has GoldenGlow: (%s)"
	CONS_Printf(player, string.format(string2, player.name, player.gamesPlayed, player.rvgrpass, player.hasGoldenGlow))
	for listplayer in players.iterate do
		if listplayer == player then
			continue
		end
		CONS_Printf(player, string.format(string1, listplayer.name, listplayer.gamesPlayed, listplayer.rvgrpass, listplayer.hasGoldenGlow))
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