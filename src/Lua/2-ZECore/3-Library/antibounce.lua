local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.AntiBounce = function(player)
	if not mapheaderinfo[gamemap].bounceoff then return end
	
	if player and player.mo and player.mo.valid and CV.gamestarted then
		if player.charability == CA_BOUNCE then
			player.charability = CA_NONE
		end
	end
end