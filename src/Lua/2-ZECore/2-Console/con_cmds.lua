COM_AddCommand("ze_spectate", function(player)
	 player.spectator = 1
	 player.ctfteam = 0
end, 1)

COM_AddCommand("unlockprop", function(player)
     player.propspawn = $+10
end, 1)