local ZE = RV_ZESCAPE

ZE.AntiBounce = function(player)
	if not mapheaderinfo[gamemap].bounceoff then return end
	
	if player and player.mo and player.mo.valid then
		if player.charability == CA_BOUNCE then
			player.charability = CA_NONE
		end
	end
end