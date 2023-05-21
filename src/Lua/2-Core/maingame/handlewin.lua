local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.PostWin = function(player)
	if player.gamesPlayed ~= nil then --anti softlock
		player.gamesPlayed = $ + 1
		ZE.CheckUnlocks(player)
	end
end


ZE.Win = function(team)
	ZE.teamWin = team
	for player in players.iterate do
		if team == 1
			if not(mapheaderinfo[gamemap].zombieswarm) then
				S_ChangeMusic("ZMWIN",false,player)
			else -- else if zombie swarm
				S_ChangeMusic("ZSLOSE",false,player)	
			end
			ZE.PostWin(player)
			COM_BufInsertText(player, "savestuff")
			CV.onwinscreen = 1

		else -- if team is also 2
			local survwinmus = mapheaderinfo[gamemap].survwinmus or "ZMLOSE"
			if not(mapheaderinfo[gamemap].zombieswarm) then
				S_ChangeMusic(survwinmus,false,player)
			else
				S_ChangeMusic("ZSWIN",true,player) --these music names will stay confusing lmao
			end
			ZE.PostWin(player)
			COM_BufInsertText(player, "savestuff")
			CV.onwinscreen = 1

		end
	end
	CV.winWait = 30*TICRATE
	
	if mapheaderinfo[gamemap].zombieswarm
		CV.winWait = 15*TICRATE
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

ZE.executewin = function(line, mobj, sector)
	if CV.onwinscreen then -- dont execute a million times
		return
	end
	if mobj and mobj.valid and mobj.player then
		local execplayer = mobj.player
		if execplayer.ctfteam then -- Are you teamed?
			if CV.debugmode.value then
				print(execplayer.ctfteam)
			end
			if execplayer.ctfteam == 2 then
				ZE.Win() -- Survivor win.
			else
				ZE.Win(1) -- Zombie win.
			end
			for player in players.iterate do
				ZE.SurvInv(player)
				if CV.deathonwin.value == 1 then
					ZE.survKill(player) -- kills only if they haven't finished.
				end
			end
			P_StartQuake(24*FRACUNIT, 3*TICRATE)
		end
	end
end

//Deprecated
ZE.survWin = ZE.executewin

//Deprecated
ZE.zmWin = ZE.executewin

ZE.WinScript = function()
	if gametype == GT_ZESCAPE
		for player in players.iterate do
			if ZE.survcount < 1 and not (leveltime < CV.waittime) and (ZE.teamWin == 0)
				ZE.Win(1)
			end
		end
		 if CV.survtime > 0 and not(CV.onwinscreen) and (CV.gamestarted) then
		    CV.survtime = $1-1
			if CV.survtime <= 0 then
				ZE.Win()
			end
		end
		if (leveltime > CV.waittime+CV.gametime) and (ZE.teamWin == 0)
			if ZE.survcount == 0
				ZE.Win(1)
			end
			if ZE.zombcount == 0
				ZE.Win()
			end
		end
		 if CV.gametime <= 0
		    ZE.Win(1)
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