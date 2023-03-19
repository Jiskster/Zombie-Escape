local ZE = RV_ZESCAPE

addHook("PlayerThink", function(player)
	if not (gametype == GT_ZESCAPE) then return end
		if player and player.valid and not player.spectator
		and player.mo and player.mo.valid
		and (player.playerstate != PST_DEAD)
		and (player.mo.state != S_PLAY_DEAD)
		    ZE.StartHealth(player)
			ZE.HealthLimit(player)
			ZE.ZombieHealth(player)
			ZE.CharacterConfig(player)
			ZE.ZombieSkin(player)
			ZE.AmyRegen(player)
			ZE.CharacterStamina(player)
			ZE.AlphaZmRage(player)
			ZE.SpawnProps(player)
			ZE.AlphaZmCfg(player)
	end
end)