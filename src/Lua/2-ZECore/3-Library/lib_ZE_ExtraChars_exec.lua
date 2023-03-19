local ZE = RV_ZESCAPE

addHook("PlayerThink", function(player)
	if (gametype == GT_ZESCAPE)
		if player and player.valid and not player.spectator
		and player.mo and player.mo.valid
		and (player.playerstate != PST_DEAD)
		and (player.mo.state != S_PLAY_DEAD)
		    ZE.ExtraCharsConfig(player)
			ZE.ExtraCharsStamina(player)
			ZE.ExtraCharsStartHealth(player)
			ZE.ExtraCharsHealthLimit(player)
			ZE.RevengerAbility(player)
			ZE.Revenger(player)
			ZE.MilnePlayerThink(player)
		end
	end
end)

addHook("ThinkFrame", function()
    ZE.ExtraCharsColors()
end)

addHook("AbilitySpecial", function(player) return ZE.MilneAbilitySpecial(player) end)