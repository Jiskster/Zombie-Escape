local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

hud.add(function(v, player)
	if (gametype ~= GT_ZESCAPE) return end
		if player and player.valid and not player.spectator
		and player.mo and player.mo.valid
		and (player.playerstate != PST_DEAD)
		and (player.mo.state != S_PLAY_DEAD)
		if player.ctfteam == 2
		    v.drawString(272,184,"\x87\C1 \x80\- \x84\RUN",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		    v.drawString(272,192,"\x87\C2 \x80\- \x84\RELOAD",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
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
		if player.alphazm == 1 then
		   v.drawString(1,176,"\x85\ALPHA ZOMBIE",V_HUDTRANS|V_SNAPTOLEFT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		   v.drawString(242,184,"\x87\C1 \x80\ - \x85\RAGE",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		   v.drawString(242,176,"\x85\RAGE\x80 COOLDOWN: "+tostring(player.boostcount/TICRATE),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		end
	end
end)


hud.add(function(v, player, camera)
	if (gametype ~= GT_ZESCAPE) then return end
	if player.mo and player.mo.valid
		if player.mo.health and player.mo.health > 0
			local mipatch = v.cachePatch("ZEHPBAR")
			--v.drawString(154,183,"\x85\HEALTH HEALTH", V_PERPLAYER|V_SNAPTOBOTTOM|V_50TRANS, "center")
			if not (player.mo.skin == "dzombie")
				v.drawStretched(0*FU,90*FU,(player.mo.health*FU)/2,FU*2, mipatch,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT)
				v.drawString(0,90, max(0,player.mo.health) + " Health", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_REDMAP|V_50TRANS, "thin")
			else 
				v.drawStretched(0*FU,90*FU,(player.mo.health*FU)/10,FU*2, mipatch,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT)
				v.drawString(0,90, max(0,player.mo.health) + " Health", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_REDMAP|V_50TRANS, "thin")
			end
		end
	end
end, "game")

hud.add(function(v, player)
	if not (player.ctfteam == 2) return end
	if (gametype ~= GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		local mipatch = v.cachePatch("ZESTBAR")
		if (player.stamina < 25*TICRATE) and not(player.stamina <= 0)
			--v.drawString(154,190,"\x85\STAMINA STAMINA", V_PERPLAYER|V_SNAPTOBOTTOM|V_50TRANS,"center")
			v.drawStretched(0*FU,100*FU,player.stamina*FU/45,FU*2, mipatch,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT)
			v.drawString(0,100, max(0,player.stamina/TICRATE)+ " Stamina", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS|V_BLUEMAP, "thin")
			
	    elseif (player.stamina > 25*TICRATE)
			--v.drawString(154,190,"\x84\STAMINA STAMINA", V_PERPLAYER|V_SNAPTOBOTTOM|V_50TRANS,"center")
			v.drawStretched(0*FU,100*FU,player.stamina*FU/45,FU*2, mipatch,V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT)
			v.drawString(0,100, max(0,player.stamina/TICRATE)+ " Stamina", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS|V_BLUEMAP, "thin")		
		elseif player.stamina <= 0
		
			v.drawString(0,50, max(0,player.stamina/TICRATE)+ " Stamina", V_PERPLAYER|V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_50TRANS|V_REDMAP,  "thin")	
		end
		
		
	end
end, "game")

hud.add(function(g,player,cam)
   local client = 0
	if not (gametype == GT_ZESCAPE) then return end
	if player.playerstate == PST_LIVE then
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
		elseif player.ctfteam == 0 then
		    str="SPECTATOR" c=V_SNAPTOTOP|V_50TRANS
		end

		g.drawString(160,0, str, c, "center") --127+yo
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
		if player.mo.skin == "amy" then
		   v.drawString(225,176,"\x87\TOSSFLAG \x80\- \x84\SHIELD BOX",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
        end
		if player.mo.skin == "tails" then
		   v.drawString(224,176,"\x87\TOSSFLAG \x80\- \x84\WOOD FENCE",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
	    end
	end
end)
