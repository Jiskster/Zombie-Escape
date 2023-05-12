local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.CharacterColors = function()
	for player in players.iterate
		if player.mo and player.mo.valid then
			player.mo.color = player.skincolor
			if CV.lockcolors.value == 1 then
				player.mo.color = skins[player.mo.skin].prefcolor
			end
			
			if player.mo.skin == "dzombie" then
				player.mo.color = SKINCOLOR_ZOMBIE
				if player.ztype == "ZM_ALPHA" then
					player.mo.color = SKINCOLOR_ALPHAZOMBIE
				end
				
				if player.ztype == "ZM_TANK" then
					player.mo.color = SKINCOLOR_SEAFOAM
				end
				
				if player.ztype == "ZM_TINY" then
					player.mo.color = SKINCOLOR_CERULEAN
				end
			end
		end
	end
end