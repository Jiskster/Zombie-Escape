local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.UnlockRevenger = function(player)
	if player.rvgrpass ~= 1 then
		chatprint(string.format("\x87\%s Unlocked \x8F\Revenger! \x87\%s games played!",player.name,player.gamesPlayed))
		S_StartSound(player.mo, sfx_ideya)
		player.rvgrpass = 1
	end
end

ZE.UnlockGoldenGlow = function(player)
	if player.hasGoldenGlow ~= 1 then
		chatprint(string.format("\x87\%s Unlocked \x82\The Golden Glow! \x87\%s games played!",player.name,player.gamesPlayed))
		S_StartSound(player.mo, sfx_ideya)
		player.hasGoldenGlow = 1
	end
end



ZE.GoldenGlowThink = function(player)
	if player.ggtoggle == true then
		player.mo.color = SKINCOLOR_YELLOW
		player.mo.colorized = true
		if leveltime % 3 == 0 then
			local glowghost = P_SpawnGhostMobj(player.mo)
			glowghost.color = SKINCOLOR_YELLOW
			glowghost.colorized = true
			glowghost.fuse = 20
			glowghost.blendmode = AST_ADD
			P_TeleportMove(glowghost, player.mo.x, player.mo.y, player.mo.z - 4*FRACUNIT)
			glowghost.frame = $|FF_ADD
			if glowghost.tracer
				glowghost.tracer.fuse = glowghost.fuse
			end
		end
	end
end

ZE.CheckUnlocks = function(player)	
	if player.gamesPlayed == 25 then
		ZE.UnlockRevenger(player)
	end
	
	if player.gamesPlayed == 125 then
		ZE.UnlockGoldenGlow(player)
	end
end

