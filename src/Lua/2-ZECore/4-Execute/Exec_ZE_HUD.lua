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
			if player.mo.health
				v.drawString(0,183,"\x85\+", V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
				v.drawString(8,183, max(0,player.mo.health), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "left")
		end
	end
end, "game")

hud.add(function(v, player)
	if not (player.ctfteam == 2) return end
	if (gametype ~= GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		if (player.stamina < 25*TICRATE)
			v.drawString(33,183,"\x85\S", V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
			v.drawString(42,183, max(0,player.stamina/TICRATE), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "left")
	    elseif (player.stamina > 25*TICRATE)
			v.drawString(33,183,"\x84\S", V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM)
			v.drawString(42,183, max(0,player.stamina/TICRATE), V_PERPLAYER|V_SNAPTOLEFT|V_SNAPTOBOTTOM, "left")		
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
end, "game")

hud.add(function(v, player, camera)
	if gametype == GT_ZESCAPE
		if ZE.teamWin != 0 and player.ctfteam != 0
			if player.ctfteam == ZE.teamWin
				if ZE.teamWin == 1
					v.draw(160,50,v.cachePatch("ZOMBWIN"), V_PERPLAYER|V_SNAPTOBOTTOM)
				else
					v.draw(160,50,v.cachePatch("ZOMBWIN"), V_PERPLAYER|V_SNAPTOBOTTOM)
				end
			else
				if ZE.teamWin == 2
					v.draw(160,50,v.cachePatch("SURVWIN"), V_PERPLAYER|V_SNAPTOBOTTOM)
				else
					v.draw(160,50,v.cachePatch("SURVWIN"), V_PERPLAYER|V_SNAPTOBOTTOM)
				end
			end
		end
		
		
		if ZE.alpha_attack == 1 and ZE.alpha_attack_show < 15*FRACUNIT and ZE.alpha_attack_doneshow == false then
			v.draw(160,50,v.cachePatch("ALPHATT"), V_PERPLAYER|V_SNAPTOBOTTOM)
			
			//print(ZE.alpha_attack_show)
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
