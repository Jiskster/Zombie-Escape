local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

-- [Prevents player bouncing on certain maps.] --
ZE.AntiAbility = function(player)
	if mapheaderinfo[gamemap].bounceoff then
		if player and player.mo and player.mo.valid then
			if player.charability == CA_BOUNCE then
				player.charability = CA_NONE
			end
		end
	end
	if not CV.allowswim.value then
		if player and player.mo and player.mo.valid then
			if player.charability == CA_SWIM then
				player.charability = CA_NONE
			end
		end
	end
end