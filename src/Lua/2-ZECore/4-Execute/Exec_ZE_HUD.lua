local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

hud.add(function(v, player)
	local hudtype = CV.hudtype.value 
	if (gametype ~= GT_ZESCAPE) return end
		if player and player.valid and not player.spectator
		and player.mo and player.mo.valid
		and (player.playerstate != PST_DEAD)
		and (player.mo.state != S_PLAY_DEAD)
		if player.ctfteam == 2
		    v.drawString(272,184,"\x87\C1 \x80\- \x84\RUN",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		    v.drawString(272,192,"\x87\FN \x80\- \x84\RELOAD",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		end
		if player.ctfteam == 1
		   v.drawString(262,192,"\x87\FIRE \x80\- \x85\ATTACK",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		end
		if player.mo.skin == "amy" then
		   v.drawString(225,168,"\x87\SPIN \x80\- \x85\ATTACK\x80 or \x83\HEAL",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
        end
		if player.mo.skin == "fang" then
		   v.drawString(262,176,"\x87\SPIN \x80\- \x85\ATTACK",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
	    end
		if player.mo.skin == "scarf" then
		   v.drawString(235,168,"\x87\SPIN \x80\- \x85\Melee",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		   v.drawString(235,176,"\x87\HOLD SPIN \x80\- \x85\FireBall",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		end
		if hudtype == 1
			if player.ztype == ZM_ALPHA then
			   v.drawString(1,176,"\x85\ALPHA ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			   v.drawString(262,184,"\x87\C1 \x80\ - \x85\RAGE",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			   v.drawString(242,176,"\x85\RAGE\x80 COOLDOWN: "+tostring(player.boostcount/TICRATE),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			end
			
			if player.ztype == ZM_DARK then
				v.drawString(1,176,"\x85\DARK ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			end
			
			
			if player.ztype == ZM_FAST then
				v.drawString(1,176,"\x85\FAST ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			end
			
			if player.ztype == ZM_POISON then
				v.drawString(1,176,"\x85\POISON ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			end
			
			if player.ztype == ZM_GOLDEN then
				v.drawString(1,176,"\x85\GOLDEN ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
			end
		end
	end
end)


hud.add(function(v, player, camera)
	local hudtype = CV.hudtype.value 
	if (gametype ~= GT_ZESCAPE) then return end
	if player.mo and player.mo.valid
		if player.mo.health and player.mo.health > 0
			if hudtype == 1 
				v.drawString(0,183,"\x85\+", V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
				v.drawString(8,183, max(0,player.mo.health), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "left")
			end
			if hudtype == 2
				local y = 170
				local ya = y-2 
				local mipatch2 = v.cachePatch("ZEBGBAR")
				v.drawStretched(0*FU,ya*FU,(125*FU/50)*TICRATE,FU*6, mipatch2,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS)
				local mipatch = v.cachePatch("ZEHPBAR")
				if player.mo.skin ~= "dzombie" then
					v.drawString(0,y, max(0,player.mo.health)+"/"+max(0,player.mo.maxHealth) + " Health", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_REDMAP, "thin")
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
		    g.drawString(90,16, "SURVIVORS:", V_BLUEMAP|V_SNAPTOTOP|V_50TRANS, "center")
			g.drawString(141, 16, tostring(ZE.survcount), V_BLUEMAP|V_SNAPTOTOP|V_50TRANS, "center")
		    g.drawString(224,16, ":ZOMBIES", V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")
			g.drawString(181, 16, tostring(ZE.zombcount), V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")	
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
				str="ZOMBIE" c=V_REDMAP|V_SNAPTOTOP|V_50TRANS
				if player.ztype == ZM_ALPHA then
					str="ALPHA ZOMBIE" c=V_REDMAP|V_SNAPTOTOP|V_50TRANS
				end
				
				if player.ztype == ZM_DARK then
					str="DARK ZOMBIE" c=V_REDMAP|V_SNAPTOTOP|V_50TRANS
				end

				if player.ztype == ZM_FAST then
					str="FAST ZOMBIE" c=V_REDMAP|V_SNAPTOTOP|V_50TRANS
				end
				
				if player.ztype == ZM_POISON then
					str="POISON ZOMBIE" c=V_REDMAP|V_SNAPTOTOP|V_50TRANS
				end
				
				if player.ztype == ZM_GOLDEN then
					str="GOLDEN ZOMBIE" c=V_REDMAP|V_SNAPTOTOP|V_50TRANS
				end
			elseif player.ctfteam == 0 then
				str="SPECTATOR" c=V_SNAPTOTOP|V_50TRANS
			end
		g.drawString(160,0, str, c, "center") --127+yo
		end
	end
end, "game")

hud.add(function(v, player, camera)
	if gametype == GT_ZESCAPE
		if ZE.teamWin != 0 and player.ctfteam != 0 and CV.savedendtic != 0
		    local time = TICRATE*2
			local ese = ease.inoutquad(( (FU) / (time) )*(CV.timeafterwin), 0, 16)
			local ese2 = ease.inoutquad(( (FU) / (time) )*(CV.timeafterwin), -50, 50)
			
			local function DoAnim(teamwin)
				local patches = {"ZOMBWIN", "SURVWIN"}
				if CV.timeafterwin < time then
					v.fadeScreen(0xFF00, ese)
					v.draw(160,ese2,v.cachePatch(patches[teamwin]), V_PERPLAYER|V_SNAPTOBOTTOM)
				else
					v.fadeScreen(0xFF00, 16)
					v.draw(160,50,v.cachePatch(patches[teamwin]), V_PERPLAYER|V_SNAPTOBOTTOM)
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
			v.draw(160,50,v.cachePatch("ALPHATT"), V_PERPLAYER|V_SNAPTOBOTTOM)
		end
	end
end, "game")

hud.add(function(v, player)
	if (gametype ~= GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		if player.mo.skin == "amy" and player.propspawn ~= nil then
		   v.drawString(225,176,"\x87\TOSSFLAG \x80\- \x84\HEAL STATION",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		   v.drawString(262,160,"\x87\Stations: \x80\- \x84\ "+tostring(player.propspawn),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
        end
		if player.mo.skin == "tails" and player.propspawn ~= nil then
		   v.drawString(224,176,"\x87\TOSSFLAG \x80\- \x84\WOOD FENCE",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		   v.drawString(262,168,"\x87\Fences: \x80\- \x84\ "+tostring(player.propspawn),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
	    end
		
		if player.mo.skin == "metalsonic" and player.propspawn ~= nil then
		   v.drawString(224,176,"\x87\TOSSFLAG \x80\- \x84\LAND MINES",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		   v.drawString(240,168,"\x87\Landmines: \x80\- \x84\ "+tostring(player.propspawn),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
	    end
	end
end)

local function TimerHud(v,p,c)
	--if not mapheaderinfo[gamemap].swarmmap then return end
	local hudtype = CV.hudtype.value 
	local basetime = ((CV.survtime/TICRATE))
	if hudtype == 1 
		v.drawString(0,167,"\x85\Time Left: "+basetime, V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
	end
	if hudtype == 2
		v.drawString(160,8,"\x85\Time Left: "+basetime, V_PERPLAYER|V_REDMAP|V_SNAPTOTOP|V_50TRANS, "center")
	end


end

hud.add(TimerHud, "game")
