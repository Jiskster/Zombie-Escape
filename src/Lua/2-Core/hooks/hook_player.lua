local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

addHook("PlayerThink", function(player)
	if not (gametype == GT_ZESCAPE) then return end
		if player and player.valid and not player.spectator
		and player.mo and player.mo.valid
		and (player.playerstate != PST_DEAD)
		and (player.mo.state != S_PLAY_DEAD)
			ZE.CharacterColors(player)
		    ZE.StartHealth(player)
			ZE.HealthLimit(player)
			ZE.CharacterConfig(player)
			ZE.HandleZombie(player)
			ZE.ZombieSkin(player)
			ZE.ZombieSwarmWave(player)
			ZE.AmyRegen(player)
			ZE.ZombieRegen(player)
			ZE.CharacterStamina(player)
			ZE.AlphaZmRage(player)
			ZE.SpawnProps(player)
	end
end)

addHook("PlayerQuit", function(player)
	ZE.RemoveZtypesOnLeave(player)
end)