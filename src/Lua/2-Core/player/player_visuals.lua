local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.ZtypeAura = function()
  if not (gametype == GT_ZESCAPE) then return end
    for player in players.iterate
        if player.mo and player.mo.valid and player.mo.skin == "dzombie"
        and player.playerstate == PST_LIVE
        and not player.powers[pw_carry]
        and not P_PlayerInPain(player)
        and not player.exiting
		and player.ztype then
			if not ZE.Ztypes[player.ztype] then
				return
			end
			local fromztype = ZE.Ztypes[player.ztype].info
			if (fromztype.effect == "alpha")
				local zombienumber1 = P_SpawnGhostMobj(player.mo)
				zombienumber1.color = player.mo.color
				zombienumber1.colorized = true
				zombienumber1.fuse = 1
				zombienumber1.blendmode = AST_ADD
				P_MoveOrigin(zombienumber1, player.mo.x, player.mo.y, player.mo.z - 4*FRACUNIT)
				zombienumber1.frame = $|FF_ADD
				zombienumber1.scale = $ + FRACUNIT/3
				if zombienumber1.tracer
					zombienumber1.tracer.fuse = zombienumber1.fuse
				end
			end
			
			
			if (fromztype.effect == "zoom")
				local zombienumber1 = P_SpawnGhostMobj(player.mo)
				zombienumber1.color = player.mo.color
				zombienumber1.colorized = true
				zombienumber1.fuse = 1
				zombienumber1.blendmode = AST_ADD
				P_MoveOrigin(zombienumber1, player.mo.x, player.mo.y, player.mo.z - 4*FRACUNIT)
				zombienumber1.frame = $|FF_ADD
				if zombienumber1.tracer
					zombienumber1.tracer.fuse = zombienumber1.fuse
				end
				player.mo.colorized = true
			end	
        end
    end
end