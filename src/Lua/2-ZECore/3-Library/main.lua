local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.ringlist = {}
ZE.survcount = 0
ZE.zombcount = 0
ZE.teamWin = 0
ZE.infectdelay = 0
ZE.winTriggerDelay = 0
ZE.survskins = {"sonic", "tails", "amy", "knuckles", "fang", "metalsonic"}
ZE.survskinsplay = {"sonic", "tails", "knuckles"}

ZE.alpha_attack = 0
ZE.alpha_attack_show = 0 -- gui show time

CV.waittime = 20*TICRATE
CV.winWait = 0
CV.survtime = 0
CV.countup = 0
CV.gametime = 14*60*TICRATE
CV.timeafterwin = 0
CV.onwinscreen = 0

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
ZE.IsZombie = function(player)
	
end
ZE.CountUp = function()
	CV.countup = $ + (1/2)
end

ZE.PostWin = function(player)
	if player.gamesPlayed ~= nil then --anti softlock
		player.gamesPlayed = $ + 1
		ZE.CheckUnlocks(player)
	end
end
ZE.Win = function(team)
	ZE.teamWin = team
	for player in players.iterate do
		if team == player.ctfteam
			S_ChangeMusic("ZMWIN",false,player)
			ZE.PostWin(player)
			COM_BufInsertText(player, "savestuff")
			CV.onwinscreen = 1

		else
			S_ChangeMusic("ZMLOSE",false,player)
			ZE.PostWin(player)
			COM_BufInsertText(player, "savestuff")
			CV.onwinscreen = 1

		end
	end
	CV.winWait = 30*TICRATE
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

ZE.SurvInv = function(player)
    for player in players.iterate do
	 if player.mo and player.mo.valid
	    if (player.ctfteam == 2) then
		   player.powers[pw_invulnerability] = 10000
		   end
		end
	end
end

ZE.survWin = function()
	for player in players.iterate do
	  if player.mo and player.mo.valid
	     if not ZE.winTriggerDelay
	        if (gametype == GT_ZESCAPE) and not (ZE.teamWin == 1)
			S_ChangeMusic("ZMLOSE",false,player)
			ZE.winTriggerDelay = 1
			if CV.deathonwin.value == 1 then
				ZE.survKill(player)
			end
			P_StartQuake(24*FRACUNIT, 3*TICRATE)
			ZE.SurvInv(player)
			ZE.Win(team)
			   end
			end
		end
	end
end

ZE.zmWin = function()
	for player in players.iterate do
	  if player.mo and player.mo.valid
	     if not ZE.winTriggerDelay
	        if (gametype == GT_ZESCAPE) and not (ZE.teamWin == 1)
			S_ChangeMusic("ZMWIN",false,player)
			ZE.winTriggerDelay = 1
			if CV.deathonwin.value == 1 then
				ZE.survKill2(player)
			end
			P_StartQuake(24*FRACUNIT, 3*TICRATE)
			ZE.Win(1)
			   end
			end
		end
	end
end

ZE.WinScript = function()
	if gametype == GT_ZESCAPE
		for player in players.iterate do
			if ZE.survcount < 1 and not (leveltime < CV.waittime) and (ZE.teamWin == 0)
				ZE.Win(1)
			end
		end
		 if CV.survtime > 0 then
		    CV.survtime = $1-1
			if CV.survtime <= 0 then
				ZE.survWin()
			end
		end
		if (leveltime > CV.waittime+CV.gametime) and (ZE.teamWin == 0)
			if ZE.survcount == 0
				ZE.Win(1)
			end
			if ZE.zombcount == 0
				ZE.Win(2)
			end
		end
		 if CV.gametime <= 0
		    ZE.zmWin()
		end
			if CV.winWait > 0
				CV.winWait = $1-1
				if CV.onwinscreen == 1 then
					CV.timeafterwin = $1+1
				end
			
			elseif (ZE.teamWin != 0 and CV.winWait <= 0)
					G_ExitLevel()
		end
	end
end

ZE.secretsound = function()
	     COM_BufInsertText(player, "cecho A secret is revealed!")
end

ZE.TeamSwitch = function(player, fromspectators, team)
    if not (gametype == GT_ZESCAPE) then return end
	if (player.ctfteam == 2) and not (player.playerstate == PST_DEAD) and not (leveltime < CV.waittime) then
		return false
	elseif (player.ctfteam == 0) and (leveltime > CV.waittime) then
		return nil
	end
	if (player.ctfteam == 1) and not (leveltime < CV.waittime) then
	   return false
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

  if #activeplayers and (ZE.survcount > 1) and not (ZE.survcount > 8) then
    P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
	ZE.infectdelay = 1
	activeplayers = {}
  elseif #activeplayers and (ZE.survcount > 8) and not (ZE.survcount > 16) and not (ZE.survcount < 8) then
  P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
  P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
  ZE.infectdelay = 1
  activeplayers = {}
end
  if #activeplayers and (ZE.survcount > 16) and not (ZE.survcount < 16) then
  P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
  P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
  P_DamageMobj(activeplayers[P_RandomRange(1, #activeplayers)].mo, nil, nil, 1, DMG_INSTAKILL)
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
		   player.rings = 100
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

ZE.ZombieSkin = function(player)
  if not (gametype == GT_ZESCAPE) then return end
    if player and player.valid
     and player.mo and player.mo.valid
	if (player.ctfteam == 1 and player.mo.skin ~= "dzombie") then
		R_SetPlayerSkin(player, "dzombie")
	elseif (player.ctfteam == 2) and (player.mo.skin == "dzombie") then
	   R_SetPlayerSkin(player,ZE.survskinsplay[P_RandomRange(1,#ZE.survskinsplay)])
	   end
	end
end

ZE.RestrictSkin = function()
  if not (gametype == GT_ZESCAPE) then return end
		if (leveltime < CV.waittime) or (CV.waittime < 20*TICRATE) then
		   COM_BufInsertText(server, "restrictskinchange 0")
	    else
		   COM_BufInsertText(server, "restrictskinchange 1")
     end
end

ZE.SpawnPlayer = function(player)
        if (leveltime < CV.waittime) and not (leveltime > CV.waittime) then
		   COM_BufInsertText(player, "changeteam blue")
		   end
        if (leveltime > CV.waittime) and (player.playerstate ~= PST_LIVE) then
	        COM_BufInsertText(player, "changeteam red")
		end
        if (leveltime > CV.waittime) and (player.ctfteam == 0 or player.spectator == 1) then
	        COM_BufInsertText(player, "changeteam red")
    end
end

ZE.RandomInfect = function()
	if gametype == GT_ZESCAPE	
		      if leveltime-CV.waittime == 0
		         ZE.InfectRandomPlayer()
		end
		for player in players.iterate do
		  if leveltime-CV.waittime == 0
		  player.score = $+1
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
		if (player.alphazm == 1) and player.ctfteam == 1 then
		   player.respawned = 1
	end
        if (leveltime > CV.waittime) and player.ctfteam == 1 and not (player.respawned == 1) and player.deathpoint and player.score != 0 then
		   P_TeleportMove(player.mo, player.deathpoint.x, player.deathpoint.y, player.deathpoint.z)
		   player.respawned = 1
		end
    end
end

ZE.SpawnSounds = function(player)
	if (gametype == GT_ZESCAPE)
	  local infsfx = {sfx_inf1, sfx_inf2}
        if (player.ctfteam == 1) and not (leveltime < CV.waittime) then
		   S_StartSound(player.mo,infsfx[P_RandomRange(1,#infsfx)])
	   end
    end
end

ZE.CountDown = function()
	if gametype == GT_ZESCAPE
		if CV.waittime-leveltime == 0*TICRATE -- if done
		   S_StartSound(player, sfx_rstart)
		   if P_RandomChance(FRACUNIT/7) then
			  ZE.Start_alpha_attack()
		   end
        end
	end
end

ZE.BecomeAlphaZm = function()
	if not (gametype == GT_ZESCAPE) then return end
		for player in players.iterate
			if (player.ctfteam == 1) and (leveltime-CV.waittime <= 10*TICRATE) and (player.playerstate == PST_DEAD) then
				player.alphazm = $ or 0
				player.alphazm = 1
			end
			if (player.ctfteam == 1) and (player.playerstate == PST_DEAD) and (leveltime-CV.waittime >= 10*TICRATE) then
				player.alphazm = 0
			end
			if (player.ctfteam == 2) or (player.spectator == 1) then
				player.alphazm = 0
			end
			if ZE.alpha_attack == 1 and player.mo and player.mo.valid and player.mo.skin == "dzombie" then
				player.alphazm = 1
			end
	end
end
ZE.Start_alpha_attack = function()
	if gametype == GT_ZESCAPE
		ZE.alpha_attack = 1
		S_ChangeMusic("ZMATK", false)
		P_StartQuake(10*FRACUNIT, 6*TICRATE)
	end
end

ZE.Inc_Show_alpha_attack = function() --increments ZE.alpha_attack_show if its not done showing
	if ZE.alpha_attack_doneshow == false then
		if ZE.alpha_attack == 1 then
			ZE.alpha_attack_show = $ + 1
		end
		if ZE.alpha_attack_show > 15*TICRATE then
			S_ChangeMusic(mapmusname, true)
			ZE.alpha_attack_doneshow = true
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