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