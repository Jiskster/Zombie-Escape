local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.ringlist = {}
ZE.survcount = 0
ZE.zombcount = 0
ZE.teamWin = 0
ZE.Wave = 0
ZE.infectdelay = 0
ZE.winTriggerDelay = 0
ZE.survskins = {"sonic", "tails", "amy", "knuckles", "fang", "metalsonic", "w", "bob"}
ZE.survskinsplay = {"sonic", "tails", "amy", "knuckles", "fang", "metalsonic", "w", "bob"}

CV.waittime = 20*TICRATE
CV.winWait = 0
CV.survtime = 0
CV.countup = 0
CV.gametime = 14*60*TICRATE
CV.timeafterwin = 0
CV.onwinscreen = 0
CV.gamestarted = false
ZE.secretshowtime = 0

ZE.npclist = {} -- mobj only

ZE.ResetTimers = function(mapnum) -- code needed to be changed?
	CV.timeafterwin = 0
	CV.winWait = 9999*TICRATE
	CV.onwinscreen = 0
	COM_BufInsertText(server, "ze_winwait 9999")
	if mapheaderinfo[mapnum].survivetime then 
		local convsurvtime = tonumber(mapheaderinfo[mapnum].survivetime)*60
		CV.survtime = convsurvtime*TICRATE
		COM_BufInsertText(server, "ze_survtime "+ convsurvtime)
		CV.countup = 0
		--print(convsurvtime)
	else
		local convsurvtime = 10*60
		CV.survtime = convsurvtime*TICRATE
		COM_BufInsertText(server, "ze_survtime "+ convsurvtime)
		CV.countup = 0
		--print("No var found, New var: " +convsurvtime)
	end

	COM_BufInsertText(server, "rh_enable 1")
end

ZE.CountUp = function()
	if CV.gamestarted == true
		CV.countup = $ + 1
	end
end

ZE.npcCount = function()
	local count = 0
	for i,npc in ipairs(ZE.npclist)
		count = $+1
	end
	
	return count
end


ZE.killNpc = function(mobj)
	for i,npc in ipairs(ZE.npclist) -- find npc and delete(i know this is weird)
		if mobj and mobj == npc then
			P_DamageMobj(mobj, nil, nil, 1, DMG_INSTAKILL)
			table.remove(ZE.npclist, i)
		end
	end
end

ZE.registerNpc = function(mobj, health, maxHealth)
	mobj.isNPC = true
	mobj.health = health
	mobj.maxHealth = maxHealth
	table.insert(ZE.npclist, mobj)
end

ZE.survKill = function(player)
    for player in players.iterate do
	 if player.mo and player.mo.valid
	  if (CV.survtime <= 0) then return end
	    if ((player.pflags & PF_FINISHED) == 0) or (player.ctfteam == 1) then
		   P_DamageMobj(player.mo, nil, nil, 1, DMG_INSTAKILL)
		   end
		end
	end
end

ZE.survKill2 = function(player)
    for player in players.iterate do
	 if player.mo and player.mo.valid
	  if (CV.survtime <= 0) then return end
	    if (player.ctfteam == 2) then
		   P_DamageMobj(player.mo, nil, nil, 1, DMG_INSTAKILL)
		   end
		end
	end
end

ZE.TeamSwitch = function(player, fromspectators, team)
    if not (gametype == GT_ZESCAPE) then return end
	if (player.ctfteam == 2) and not (player.playerstate == PST_DEAD) and (leveltime > CV.waittime) then
		return false
	end
	
	if (player.ctfteam == 0) and (leveltime > CV.waittime) then
		return nil
	end
	
	if (player.ctfteam == 1) and (leveltime > CV.waittime) then
	   return false
	end
	
	if (player.ctfteam == 2) and (leveltime < CV.waittime) then
		local textnum = P_RandomRange(1, 3)
		if textnum == 1 then
			chatprintf(player, "\x85\<Zombie>\x80\ The game still registers you in RNG. You cannot escape from being enslaved by the zombies.")
		end 
		
		if textnum == 2 then
			chatprintf(player, "\x85\<Zombie>\x80\ The zombies will always be back. You cannot escape from the RNG.")
		end
		
		if textnum == 3 then
			chatprintf(player, "\x85\<Zombie>\x80\ You will be enslaved by the zombies if you continue.")
		end
	end
end

ZE.InfectRandomPlayer = function()

local activeplayers = {}

	for player in players.iterate do
		if player.mo and player.mo.valid then
			if not ZE.infectdelay
				if (player.playerstate == PST_DEAD) or (player.playerstate == PST_REBORN) then continue end
				table.insert(activeplayers, player)
			end
		end
	end

	if #activeplayers and (ZE.survcount > 1) and not (ZE.survcount > 5) then
		P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
		ZE.infectdelay = 1
		activeplayers = {}
	end
	if #activeplayers and (ZE.survcount > 5) and not (ZE.survcount > 10) and not (ZE.survcount < 5) then
		for i=1,2 do
			P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
		end
		ZE.infectdelay = 1
		activeplayers = {}
	end
	if #activeplayers and (ZE.survcount > 10) and not (ZE.survcount > 16) and not (ZE.survcount < 10) then
		for i=1,4 do
			P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
		end
		ZE.infectdelay = 1
		activeplayers = {}
	end
	if #activeplayers and (ZE.survcount > 16) and not (ZE.survcount < 16) then
		for i=1,6 do
			P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
		end
		ZE.infectdelay = 1
		activeplayers = {}
	end
end

-- ignore rings if zombie
ZE.IgnoreRings = function(poked, poker)
   if gametype == GT_ZESCAPE
   for player in players.iterate do
	if poker.player.ctfteam == 1 --or poker.player.spectate
		return true
	else
		-- update ring table
		for _,i in ipairs(ZE.ringlist)
			if i.mobj == poked
				table.remove(ZE.ringlist,_)
				   end
				end
			end
		end
	end
end

ZE.SetRings = function(player)
  if not (gametype == GT_ZESCAPE) then return end
	for player in players.iterate do
	  if leveltime-CV.waittime == 0
		   player.rings = tonumber(CV.defaultrings.value)
	   end
	end
end

ZE.PlayerCount = function()
	if gametype == GT_ZESCAPE
		-- team count
		ZE.zombcount = 0
		ZE.survcount = 0
		end
		
		for player in players.iterate do			
			
			-- team counts
			if not player.spectator
				if player.ctfteam == 1
					ZE.zombcount = $1+1
				elseif player.ctfteam == 2
					ZE.survcount = $1+1
				end
			end
			if leveltime < CV.waittime and player.ctfteam == 1
				player.exiting = 1
			else
				player.exiting = 0
			end
		
		if (leveltime > CV.waittime+CV.gametime) and (ZE.teamWin == 0)
			if ZE.survcount == 0
				ZE.Win(1)
			end
			if ZE.zombcount == 0
				ZE.Win(2)
			end
		end
	      if (player.ctfteam == 2) and (player.playerstate == PST_DEAD) and not (leveltime < CV.waittime) then
	         ZE.survcount = $1-1
		     ZE.zombcount = $1+1
		end
	end
end

ZE.InfectPlayer = function(player)
	if player and player.valid
	 if player.mo and player.mo.valid
	   if (player.playerstate ~= PST_LIVE) and not (leveltime < CV.waittime) and not (player.ctfteam == 1) then
			COM_BufInsertText(player, "changeteam red")
		  end
       end
	end
end

ZE.RandomInfect = function()
	local first
	local second
	if gametype == GT_ZESCAPE	
		if leveltime-CV.waittime == 0
			first = getTimeMicros()
			
			ZE.InfectRandomPlayer()
			
			second = getTimeMicros()
			
			local result = (second-first)
			if CV.debugmode.value then
				print(result.." microseconds took to run zombie picking code.")
			end
		end
	end
	
	

end

ZE.CountDown = function()
	if gametype == GT_ZESCAPE
		if CV.waittime-leveltime == 0*TICRATE -- if done
			S_StartSound(player, sfx_rstart)
			CV.gamestarted = true
			if mapheaderinfo[gamemap].zombieswarm
				ZE.Wave = 1
				chatprint("\x83\<Zombie Swarm>\x80\ Wave "..ZE.Wave)
			end
			
			if P_RandomChance(FRACUNIT/10) and not(mapheaderinfo[gamemap].zombieswarm) then
				ZE.Start_alpha_attack()
			end
		end
	end
end

ZE.HudStuffDisable = function()
	if gametype == GT_ZESCAPE
		hud.disable("score")
		hud.disable("time")
		hud.disable("lives")
		hud.disable("teamscores")
		hud.disable("rings")
	else 
		hud.enable("score")
		hud.enable("time")
		hud.enable("lives")
		hud.enable("teamscores")
		hud.enable("rings")
	end
end
