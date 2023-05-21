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
			if (player.ztype == "ZM_ALPHA")
				local zombienumber1 = P_SpawnGhostMobj(player.mo)
				zombienumber1.color = P_RandomRange(SKINCOLOR_RED, SKINCOLOR_RUBY)
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
			
			
			if (player.ztype == "ZM_FAST")
				local zombienumber1 = P_SpawnGhostMobj(player.mo)
				zombienumber1.color = SKINCOLOR_MOSS
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