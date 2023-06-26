local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

local function G_TicsToMTIME(tics)
    local minutes = tostring(G_TicsToMinutes(tics))
    local seconds = tostring(G_TicsToSeconds(tics))

    if minutes:len() < 2 then
        minutes = "0"..$
    end

    if seconds:len() < 2 then
        seconds = "0"..$
    end
    return minutes..":"..seconds
end

hud.add(function(v, player)
	local hudtype = CV.hudtype.value 
	if (gametype ~= GT_ZESCAPE) return end
		if player and player.valid and not player.spectator
		and player.mo and player.mo.valid
		and (player.playerstate != PST_DEAD)
		and (player.mo.state != S_PLAY_DEAD)
		
		local offset = 0
		
		if CV_FindVar("showfps").value > 0 then
			offset = 8
		end
		if player.ctfteam == 2
		    v.drawString(320,184-offset,"\x87\CUSTOM 1 \x80\- \x84\RUN",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		    v.drawString(320,192-offset,"\x87\FIRE NORMAL \x80\- \x84\RELOAD",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		end
		if player.ctfteam == 1
		   v.drawString(320,192-offset,"\x87\FIRE \x80\- \x85\ATTACK",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		end
		if player.mo.skin == "amy" then
		   v.drawString(320,168-offset,"\x87\SPIN \x80\- \x85\ATTACK\x80 or \x83\HEAL",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
        end
		if player.mo.skin == "fang" then
		   v.drawString(320,176-offset,"\x87\SPIN \x80\- \x85\ATTACK",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
	    end
		if player.mo.skin == "scarf" then --keeping this here for legacy purposes
		   v.drawString(320,168-offset,"\x87\SPIN \x80\- \x85\Melee",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		   v.drawString(320,176-offset,"\x87\HOLD SPIN \x80\- \x85\FireBall",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		end
		
		if player.ztype == "ZM_ALPHA" then
			v.drawString(320,184-offset,"\x87\CUSTOM 1 \x80\ - \x85\RAGE",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
			v.drawString(320,176-offset,"\x85\RAGE\x80 COOLDOWN: "+tostring(player.boostcount/TICRATE),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		end
		if hudtype == 1 and player.ctfteam == 1 then
		
			/*
			if player.ztype == "ZM_ALPHA" then
			   v.drawString(1,176,"\x85\ALPHA ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-left")
			end
			
			if player.ztype == "ZM_FAST" then
				v.drawString(1,176,"\x85\FAST ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-left")
			end
			
			if player.ztype == "ZM_TANK" then
				v.drawString(1,176,"\x85\TANK ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-left")
			end
			*/
			
			
			if player.ztype then
				v.drawString(1,176,"\x85\ "..ZE.Ztypes[player.ztype].name:upper().." ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			else
				v.drawString(1,176,"\x85\COMMON ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			end
		end
	end
end)


hud.add(function(v, player, camera)
	local hudtype = CV.hudtype.value 
	if (gametype ~= GT_ZESCAPE) then return end
	if player.mo and player.mo.valid
		if player.mo.health and player.mo.health > 0 and player.mo.maxHealth
			if hudtype == 1 
				v.drawString(0,183,"\x85\+", V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
				v.drawString(8,183, max(0,player.mo.health), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "left")
			end
			if hudtype == 2
				local y = 170
				local ya = y-2 
				local mipatch2 = v.cachePatch("ZEBGBAR")
				local bgbarbottom = FU*9
				if player.ctfteam == 1 then
					bgbarbottom = FU*5
				end
				v.drawStretched(0*FU,ya*FU,(125*FU/50)*TICRATE,bgbarbottom, mipatch2,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS)
				--local mipatch = v.cachePatch("ZEHPBAR")
				if player.mo.skin ~= "dzombie" then
					v.drawString(0,y, max(0,player.mo.health)+"/"+max(0,player.mo.maxHealth) + " Health", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_REDMAP, "thin")
					v.drawString(0,y+20,max(0,player.rings) + " Rings", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_YELLOWMAP, "thin")
				else
					v.drawString(0,y+5, max(0,player.mo.health)+"/"+max(0,player.mo.maxHealth) + " Health", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_REDMAP, "thin")	
				end
				
				
			end
			
			
		end
	end
end, "game")

hud.add(function(v, player)
	local hudtype = CV.hudtype.value 
	if not (player.ctfteam == 2) return end
	if (gametype ~= GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		if hudtype == 1
			if (player.stamina < 25*TICRATE)
				v.drawString(33,183,"\x85\S", V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
				v.drawString(42,183, max(0,player.stamina/TICRATE), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "left")
			elseif (player.stamina > 25*TICRATE)
				v.drawString(33,183,"\x84\S", V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
				v.drawString(42,183, max(0,player.stamina/TICRATE), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "left")		
			end
		end
		if hudtype == 2
			local y = 180
			local mipatch = v.cachePatch("ZESTBAR")
			if (player.stamina < 25*TICRATE) and not(player.stamina <= 0)
				v.drawStretched(0*FU,y*FU,player.stamina*FU/50,FU*2, mipatch,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT)
				v.drawString(0,y, max(0,player.stamina/TICRATE)+ " Stamina", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS|V_BLUEMAP, "thin")
				
			elseif (player.stamina > 25*TICRATE)
				v.drawStretched(0*FU,y*FU,player.stamina*FU/50,FU*2, mipatch,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT)
				v.drawString(0,y, max(0,player.stamina/TICRATE)+ " Stamina", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS|V_BLUEMAP, "thin")		
			elseif player.stamina <= 0
			
				v.drawString(0,y, max(0,player.stamina/TICRATE)+ " Stamina", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS|V_REDMAP,  "thin")	
			end
		end
		
	end
end, "game")

hud.add(function(g, player)
	local hudtype = CV.hudtype.value 
	if (gametype ~= GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		if hudtype == 1
		    g.drawString(90,0, "SURVIVORS:", V_BLUEMAP|V_SNAPTOTOP|V_50TRANS, "center")
			g.drawString(141, 0, tostring(ZE.survcount), V_BLUEMAP|V_SNAPTOTOP|V_50TRANS, "center")
		    g.drawString(224,0, ":ZOMBIES", V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")
			g.drawString(181, 0, tostring(ZE.zombcount), V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")	
		end
		
		if hudtype == 2
			/*
		    g.drawString(90,16, "SURVIVORS:", V_BLUEMAP|V_SNAPTOTOP|V_50TRANS, "center")
			g.drawString(141, 16, tostring(ZE.survcount), V_BLUEMAP|V_SNAPTOTOP|V_50TRANS, "center")
		    g.drawString(224,16, ":ZOMBIES", V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")
			g.drawString(181, 16, tostring(ZE.zombcount), V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")	
			*/
			local zombies = ZE.zombcount
			local survivors = ZE.survcount
			
			if mapheaderinfo[gamemap].playercountname then 
				local pcn = mapheaderinfo[gamemap].playercountname:upper()
				g.drawString(160,16, "\x86\ \$pcn\ : \x85\ \$zombies\ \x86\/\x84\ \$survivors\",V_SNAPTOTOP|V_50TRANS, "center")
				return
			else
				g.drawString(160,16, "\x86\PLAYERS : \x85\ \$zombies\ \x86\/\x84\ \$survivors\",V_SNAPTOTOP|V_50TRANS, "center")
			end
			
		end
	end
end, "game")


hud.add(function(g,player,cam)
	local client = 0
	local hudtype = CV.hudtype.value 
	if not (gametype == GT_ZESCAPE) then return end
	if player.playerstate == PST_LIVE then
		if hudtype == 1 
			client=player
			
			local yo=64
			--[[Status]]
			local str="SURVIVORS"
			local c=V_BLUEMAP|V_SNAPTOBOTTOM|V_SNAPTOLEFT
			if leveltime < CV.waittime then
				str="WAITING: "..(CV.waittime-leveltime)/TICRATE
				c=V_SNAPTOBOTTOM|V_SNAPTOLEFT
			elseif player.ctfteam == 1 then
				str="ZOMBIES" c=V_REDMAP|V_SNAPTOBOTTOM|V_SNAPTOLEFT
			elseif player.ctfteam == 0 then
				str="SPECTATOR" c=V_SNAPTOBOTTOM|V_SNAPTOLEFT
			end
			g.drawString(1,127+yo, str, c)
			if player.ctfteam == 2 then
				g.drawString(0,159,"\x82\Rings: "+player.rings, V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM) --cringe
			end
		end
		
		if hudtype == 2
			client=player
			
			local yo=64
			--[[Status]]
			local str="SURVIVOR"
			local c=V_BLUEMAP|V_SNAPTOTOP|V_50TRANS
			if leveltime < CV.waittime then
				str="WAITING: "..(CV.waittime-leveltime)/TICRATE
				c=V_SNAPTOTOP|V_50TRANS
			elseif player.ctfteam == 1 then
				str="COMMON ZOMBIE" c=V_REDMAP|V_SNAPTOTOP|V_50TRANS
				if ZE.Ztypes[player.ztype] and ZE.Ztypes[player.ztype].name then
					str = ZE.Ztypes[player.ztype].name:upper().." ZOMBIE"
				end
			elseif player.ctfteam == 0 then
				str="SPECTATOR" c=V_SNAPTOTOP|V_50TRANS
			end
		g.drawString(160,0, str, c, "center")
		
			--127+yo
		end
	end
end, "game")

hud.add(function(v, player, camera)
	if gametype == GT_ZESCAPE
		if ZE.teamWin != 0 and player.ctfteam != 0 and CV.savedendtic != 0
		    local time = TICRATE*2
			
			local ese = ease.inoutquad(( (FU) / (time) )*(CV.timeafterwin), 0, 16)
			local ese2 = ease.inoutquad(( (FU) / (time) )*(CV.timeafterwin), -50*FRACUNIT, 50*FRACUNIT)
			
			
			local function DoAnim(teamwin)
				local patches = {"ZOMBWIN", "SURVWIN"}
				if CV.timeafterwin < time then
					v.fadeScreen(0xFF00, ese)
					v.drawScaled(160*FRACUNIT, ese2, FRACUNIT, v.cachePatch(patches[teamwin]), V_PERPLAYER|V_SNAPTOBOTTOM)
				else
					v.fadeScreen(0xFF00, 16)
					v.drawScaled(160*FRACUNIT, 50*FRACUNIT, FRACUNIT, v.cachePatch(patches[teamwin]), V_PERPLAYER|V_SNAPTOBOTTOM)
				end
				if CV.showendscore.value == 1
					if CV.timeafterwin == TICRATE*2 then
						S_StartSound(nil,sfx_dmst,player)
					end
					if CV.timeafterwin > TICRATE*2 then
						local score = player.score
						v.drawString(160,130, "Score: " + score , V_PERPLAYER, "center") --127+yo
					end
				end
				if CV.winWait < 10*TICRATE then
					v.drawString(160,140, "Intermission in: " + CV.winWait/TICRATE , V_PERPLAYER|V_REDMAP|V_50TRANS, "center") --127+yo
				end
			end
		
			if player.ctfteam == ZE.teamWin
				if ZE.teamWin == 1
					DoAnim(1)
				else
					DoAnim(1)
				end
			else
				if ZE.teamWin == 2
					DoAnim(2)
				else
					DoAnim(2)
				end
			end
		end
		
		
		if ZE.alpha_attack == 1 and ZE.alpha_attack_show < 15*FRACUNIT and ZE.alpha_attack_doneshow == false then
			v.draw(160,50,v.cachePatch("ALPHATT"), V_PERPLAYER|V_SNAPTOBOTTOM|V_50TRANS)
		end
		
		if ZE.secretshowtime then
			v.draw(160,50,v.cachePatch("SECRETZE"), V_PERPLAYER|V_SNAPTOBOTTOM|V_50TRANS)
		end
	end
end, "game")

hud.add(function(v, player)
	if (gametype ~= GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		local offset = 0
		
		if CV_FindVar("showfps").value > 0 then
			offset = 8
		end
		if player.mo.skin == "amy" then
		   v.drawString(320,176-offset,"\x87\TOSSFLAG \x80\- \x84\HEAL BURST",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		   v.drawString(320,160-offset,"\x87\COST:\x84\ "+tostring(ZE.PropCosts["HealBurst"]),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
        end
		if player.mo.skin == "tails" then
		   v.drawString(320,176-offset,"\x87\TOSSFLAG \x80\- \x84\WOOD FENCE",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		   v.drawString(320,168-offset,"\x87\COST:\x84\ "+tostring(ZE.PropCosts["Wood"]),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
	    end
		
		if player.mo.skin == "metalsonic" then
		   v.drawString(320,176-offset,"\x87\TOSSFLAG \x80\- \x84\LAND MINES",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
		   v.drawString(320,168-offset,"\x87\COST:\x84\ "+tostring(ZE.PropCosts["LandMine"]),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin-right")
	    end
	end
end)



local function TimerHud(v,p,c)
	--if not mapheaderinfo[gamemap].swarmmap then return end
	local hudtype = CV.hudtype.value 
	local basetime = ((CV.survtime))
	if hudtype == 1 
		v.drawString(0,167,"\x85\Time Left: "+G_TicsToMTIME(basetime), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
	end
	if hudtype == 2
		v.drawString(160,8,"\x88\Time Left: \x82\ "+G_TicsToMTIME(basetime), V_PERPLAYER|V_SNAPTOTOP|V_50TRANS, "center")
	end


end

hud.add(TimerHud, "game")
