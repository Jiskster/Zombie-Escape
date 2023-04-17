local function spawnmobj(player, mobj)
	local mo = player.mo
	
	if mobj == nil
		CONS_Printf(player,'spawnobject <mobj>: Spawns an object.')
		return
	end
	
	if not mo or (player ~= server and not IsPlayerAdmin(player))
		return
	end
	
	if player == server or IsPlayerAdmin(player)
		local dist = 100
		print ('You spawned in the mobj ' .. mobj .. '!')
		mobj = _G[string.upper(mobj)]
		P_SpawnMobj(mo.x + dist * cos(mo.angle), mo.y + dist * sin(mo.angle), mo.z, mobj)
		print ('The mobj code is ' .. mobj .. '.')
	end
end

COM_AddCommand ('spawnobject', spawnmobj)