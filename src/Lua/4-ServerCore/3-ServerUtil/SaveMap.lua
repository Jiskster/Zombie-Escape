local server_init = false

addHook("NetVars", function(n)
	 server_init = n($)
end)

addHook("PlayerThink", function(player)
	if player.cpu != true
		COM_BufInsertText(player, "cpusleep 0")
		player.cpu = true
	end
end)

addHook("ThinkFrame", function()
	if leveltime == 1
		if server_init == false
			COM_BufInsertText(server, "exec luafiles/client/MultiWorld/ZE/lastmap.dat")
			server_init= true
		end
	end
	if leveltime == 2
		if gamemap != 1035
			if G_IsSpecialStage(gamemap) then return end
			local lastmap = io.openlocal("client/MultiWorld/ZE/lastmap.dat", "w")
			lastmap:write("map "..gamemap)
			lastmap:close()
		end
	end
end)
