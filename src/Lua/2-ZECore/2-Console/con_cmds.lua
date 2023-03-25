COM_AddCommand("ze_spectate", function(player)
	 player.spectator = 1
	 player.ctfteam = 0
end, 1)

COM_AddCommand("unlockprop", function(player)
     player.propspawn = $+10
end, 1)

COM_AddCommand("liststats", function(player)
	local string1 = "\x82\<%s> -> Games Played: (%s) | Has Revenger: (%s)"
	local string2 = "\x83\<%s> -> Games Played: (%s) | Has Revenger: (%s)"
	CONS_Printf(player, string.format(string1, player.name, player.gamesPlayed, player.rvgrpass))
	for listplayer in players.iterate do
		if listplayer == player then
			continue
		end
		CONS_Printf(player, string.format(string1, listplayer.name, listplayer.gamesPlayed, listplayer.rvgrpass))
	end
end)

COM_AddCommand("cleardata", function(player,arg1) --rvgrpass
	
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