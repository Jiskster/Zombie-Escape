local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.HealthOrb = function(obj, play)
	local player = play.player
	if (player.mo) and (player.ctfteam == 2)
		player.mo.maxHealth = $ + 200
		player.mo.health = $ + 200
		P_GivePlayerRings(player, 275)
	end
end