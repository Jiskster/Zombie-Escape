local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.CharacterColors = function()
	for player in players.iterate
		if player.mo and player.mo.valid then
			player.mo.color = player.skincolor
			if CV.lockcolors.value == 1 then -- i dont know why this feature is here lol.
				player.mo.color = skins[player.mo.skin].prefcolor
			end
			
			if player.mo.skin == "dzombie" then
				if player.ztype and ZE.Ztypes[player.ztype] and ZE.Ztypes[player.ztype].info and ZE.Ztypes[player.ztype].info.skincolor then
					player.mo.color = ZE.Ztypes[player.ztype].info.skincolor
				else
					player.mo.color = SKINCOLOR_ZOMBIE
				end
				
				
			end
		end
	end
end