local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.SpawnPlayer = function(player)
	local servercheck = (consoleplayer == server or isserver or isdedicatedserver) 
	local minjointime = 5*TICRATE -- min jointime until server kicks in
	player.kills = $ or 0
	if (leveltime < CV.waittime) and not (leveltime > CV.waittime) then
		if servercheck and player.jointime > minjointime  then
			--CONS_Printf(server, "Forced team change")
			COM_BufInsertText(server, "serverchangeteam \$#player\ blue")
		else
			COM_BufInsertText(player, "changeteam blue")
		end
	end
	if (leveltime > CV.waittime) and (player.playerstate ~= PST_LIVE) then
		if servercheck and player.jointime > minjointime then
			--CONS_Printf(server, "Forced team change")
			COM_BufInsertText(server, "serverchangeteam \$#player\ red")
		else
			COM_BufInsertText(player, "changeteam red")
		end
	end
	if (leveltime > CV.waittime) and (player.ctfteam == 0 or player.spectator == 1) then
		if servercheck and player.jointime > minjointime then
			--CONS_Printf(server, "Forced team change")
			COM_BufInsertText(server, "serverchangeteam \$#player\ red")
		else
			COM_BufInsertText(player, "changeteam red")
		end
	end
	
	if player.mo and player.mo.valid then
		if player.mo.skin == "dzombie" and not (ZE.alpha_attack) then
			local swarm = mapheaderinfo[gamemap].zombieswarm 
			if not swarm then
				local randomztypes = ZE.Ztypes.names -- {"ZM_TANK", "ZM_ALPHA", "ZM_FAST", "ZM_TINY"} and more in int_global.lua
				if player.suicided then
					player.suicided = false
					return
				end
				
				if P_RandomChance(FU/2) then
					local pickedztype = P_RandomRange(1, #randomztypes)
					player.ztype = randomztypes[pickedztype]
					return
				end	
			end
			
			if swarm then
				-- if swarm then
				local randomztypes = ZE.Ztypes.names -- {"ZM_TANK", "ZM_ALPHA", "ZM_FAST", "ZM_TINY"} and more in int_global.lua
				if player.suicided then
					player.suicided = false
					return
				end
			
				if P_RandomChance(FU/2) then
					local pickedztype = P_RandomRange(1, #randomztypes)
					player.ztype = randomztypes[pickedztype]
					return
				end	
			end
		end
	end
end

ZE.DeathPointSave = function(mo)
	if (not mo.player) then return end
	if (mo.player.ctfteam == 1) then return end
	mo.player.deathpoint = {x=mo.x,y=mo.y,z=mo.z}
end

ZE.DeathPointTp = function(player)
	if (gametype == GT_ZESCAPE)
	       player.respawned = $ or 0
		if (player.ztype == "ZM_ALPHA") and player.ctfteam == 1 then
		   player.respawned = 1
	end
        if (leveltime > CV.waittime) and player.ctfteam == 1 and not (player.respawned == 1) and player.deathpoint and player.score != 0 then
		   P_SetOrigin(player.mo, player.deathpoint.x, player.deathpoint.y, player.deathpoint.z)
		   player.respawned = 1
		end
    end
end

ZE.SpawnSounds = function(player)
	if (gametype == GT_ZESCAPE)
	  local infsfx = {sfx_inf1, sfx_inf2}
	  local infswsfx = {sfx_zszm1, sfx_zszm2}
        if (player.ctfteam == 1) and not (leveltime < CV.waittime) then
			if mapheaderinfo[gamemap].zombieswarm
				S_StartSound(player.mo,infswsfx[P_RandomRange(1,#infswsfx)])
				return
			end
		   S_StartSound(player.mo,infsfx[P_RandomRange(1,#infsfx)])
	   end
    end
end