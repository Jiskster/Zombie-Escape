local discord_link = CV_RegisterVar({"discord_link", "", CV_NETVAR, nil})
COM_AddCommand("discord", function(player)
	if not string.len(discord_link.string) then
		CONS_Printf(player, "This server does not have a discord server. Change this with command discord_link")
		CONS_Printf(player, "Contact the administrator if you believe this is a issue.")
		return
	end
	
	CONS_Printf(player, "Discord Server:")
	CONS_Printf(player, discord_link.string)
end, 0)
