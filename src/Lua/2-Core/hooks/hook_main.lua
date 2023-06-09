local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

addHook("MapLoad", function(mapnum) return  ZE.ResetTimers(mapnum) end)
addHook("MapChange", function(mapnum) return  ZE.MapLoad(mapnum) end)

addHook("ThinkFrame", function()
	if (gametype == GT_ZESCAPE)
	for player in players.iterate
		ZE.SetRings(player)
		ZE.InfectPlayer(player)
		ZE.AntiAbility(player) --level header + cvar (EX: Anti Bounce and Anti Swim)
	end
	ZE.WinScript()
	ZE.PlayerCount()
	ZE.RandomInfect()
	ZE.RestrictSkin()
	ZE.ShieldToHealth()
	ZE.InitZtype()
	ZE.CountDown()
	ZE.HudStuffDisable()
	ZE.Inc_Show_alpha_attack()
	ZE.CountUp()
	ZE.secretTick()
	
	ZE.SwarmParition()
	end
end)

addHook("PlayerSpawn", function(player)

	if (gametype == GT_ZESCAPE)

		if player and player.valid and not player.spectator
		and player.mo and player.mo.valid
			ZE.DeathPointTp(player)
			ZE.SpawnSounds(player)
		end
		if player and player.valid
		ZE.SpawnPlayer(player)
		ZE.InsertUnlocked(player)
		player.rvgrcount = 0
		player.submittedztypes = $ or {}
		--player.rvgrpass
		--player.gamesPlayed
		end
	end
end)

addHook("PostThinkFrame", function()
	if netgame and multiplayer then
		ZE.ZtypeAura()
	end
	
end)

addHook("MobjSpawn",function(mo) return ZE.CorkStuff(mo) end,MT_CORK)
addHook("MobjThinker",function(mo) return ZE.CorkTrail(mo) end,MT_CORK)

addHook("NetVars", function(net) return ZE.NetVars(net) end)
addHook("TeamSwitch", function(player, fromspectators, team) return ZE.TeamSwitch(player, fromspectators, team) end)
addHook("TouchSpecial", function(poked, poker) return ZE.IgnoreRings(poked, poker) end,MT_NULL)
addHook("TouchSpecial", function(obj, play) return ZE.HealthOrb(obj, play) end,MT_MEGAHP)
addHook("MobjDeath", function(mo) return  ZE.DeathPointSave(mo) end,MT_PLAYER)
addHook("ShouldDamage", function(hurtplayer, hazard, shooter, damage) return ZE.rhDamage(hurtplayer, hazard, shooter, damage) end,MT_PLAYER)
addHook("LinedefExecute", ZE.survWin, "SURVWIN") //Deprecated
addHook("LinedefExecute", ZE.zmWin, "ZMWIN") //Deprecated
addHook("LinedefExecute", ZE.executewin, "ZEWIN")
addHook("LinedefExecute", ZE.secretsound, "SECRET")