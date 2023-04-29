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
	local resetlevelneeded = false
	local gotfile = false
	if leveltime == 1
		if server_init == false
			local lastmap = io.openlocal("ZombieEscape/lastmap.dat", "r")
			if isdedicatedserver then
				if lastmap then
					COM_BufInsertText(server, lastmap:read("*a"))
					gotfile = true
				end
				if not lastmap then
					resetlevelneeded = true
				end
			end
			server_init = true
		end
	end
	
	if resetlevelneeded then
		CONS_Printf(server, "ZombieEscape/lastmap.dat not found, going to first map.")
		COM_BufInsertText(server, "map 01 -gametype 8")
	end
	if leveltime == 3 then
		if gamemap != 1035 and isdedicatedserver then
			if G_IsSpecialStage(gamemap) then return end
			if gametype ~= GT_ZESCAPE and gotfile == false and server_init == true then 
				CONS_Printf(server, "ZombieEscape/lastmap.dat not found, going to first map.")
				COM_BufInsertText(server, "map 01 -gametype 8")
				return 
			end
			local lastmap = io.openlocal("ZombieEscape/lastmap.dat", "w")
			lastmap:write("map "..gamemap.." -gametype 8")
			lastmap:close()
		end
	end


end)
