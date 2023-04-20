freeslot("sfx_stop1", "sfx_stop2")

local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.RevengerAbility = function(player)
   if player.mo and player.mo.valid
    if (player.mo.skin ~= "revenger") or (player.ztype ~= ZM_DARK) then return end
	if (player.mo and player.mo.valid)
		player.rvgrtimer = $ or 0
		player.rvgrcount = $ or 0
			if (player.rvgrtimer == 0)
			and (player.rvgrcount > 0)
				player.rvgrcount = $ - 1
			end
			if (player.rvgrcount == 0) and (player.rvgrtimer == 0) and (player.cmd.buttons & BT_TOSSFLAG)
				player.rvgrtimer = 5*TICRATE
				S_StartSound(player.mo, sfx_stop1)
				P_SpawnGhostMobj(player.mo)
				P_SpawnSpinMobj(player,MT_THOK)
			end
			if (player.rvgrtimer ~= 0)
				player.normalspeed = 35*FRACUNIT
				player.mo.flags2 = $|MF2_DONTDRAW
			else
				return
			end
			if (player.rvgrtimer > 0)
				if (player.rvgrtimer == 1)
					player.rvgrcount = 15*TICRATE
					S_StartSound(player.mo, sfx_stop2)
					P_SpawnGhostMobj(player.mo)
				    P_SpawnSpinMobj(player,MT_THOK)
				end
				player.rvgrtimer = $ - 1
		  end
	   end
	end
end

addHook("MapChange", do
       for player in players.iterate do
			player.rvgrcount = 0
    end
end)

hud.add(function(v, player)
   if (gametype != GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		if (player.mo.skin == "revenger") or (player.ztype == ZM_DARK) and player.rvgrcount ~= nil then
		   v.drawString(244,176,"\x87\TF\x80 button to \x85\????",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		   v.drawString(244,168,"\x85\????\x80 COOLDOWN: "+tostring(player.rvgrcount/TICRATE),V_HUDTRANS|V_SNAPTOTOP|V_SNAPTORIGHT|V_PERPLAYER|V_SNAPTOBOTTOM, "thin")
		end
	end
end)
