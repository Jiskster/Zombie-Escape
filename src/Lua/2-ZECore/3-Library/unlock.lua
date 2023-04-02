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
		chatprint(string.format("\x87\%s Unlocked \x8F\Revenger! \x87\%s games played!",player.name,player.gamesPlayed))
		S_StartSound(player.mo, sfx_ideya)
		player.hasGoldenGlow = 1
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

