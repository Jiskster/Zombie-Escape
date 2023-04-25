local ZE = RV_ZESCAPE

ZE.G_RailRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_REDRING
		if mobj.flags2 & MF2_RAILRING
			return 300
		else
			return 0
		end
	else
		return 0
	end
end

ZE.G_BounceRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_THROWNBOUNCE
		return 15
	else
		return 0
	end
end

ZE.G_AutomaticRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNAUTOMATIC
		return 18
	else
		return 0
	end
end

ZE.G_ExplosionRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNEXPLOSION
		return 120
	else
		return 0
	end
end

ZE.G_ScatterRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNSCATTER
		return 35
	else
		return 0
	end
end

ZE.G_GrenadeRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNGRENADE
		return 60
	else
		return 0
	end
end

ZE.G_InfinityRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNINFINITY
		return 20
	else
		return 0
	end
end

ZE.G_FlameRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNFLAME
		return 5
	else
		return 0
	end
end

ZE.G_SplashRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNSPLASH
		return 1
	else
		return 0
	end
end

ZE.G_SplashAOERSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_SPLASH_AOE
		return 1
	else
		return 0
	end
end

ZE.G_AccelRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNACCEL
		return 20
	else
		return 0
	end
end

ZE.G_SeekerRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNSEEKER
		return 60
	else
		return 0
	end
end

ZE.G_WaveRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNWAVE
		return 35
	else
		return 0
	end
end

ZE.G_StoneRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNSTONE
		return 55
	else
		return 0
	end
end


ZE.G_StoneDebrisRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_STONEDEBRIS
		return 20
	else
		return 0
	end
end

ZE.G_FlashShotRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_FLASHSHOT
		return 75
	else
		return 0
	end
end

ZE.G_BurstRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNBURST
		return 75
	else
		return 0
	end
end

ZE.G_NormalRingRS = function(mobj, hurthealth)
	if mobj.type == MT_RS_SHOT
		return 85
	else
		return 0
	end
end

ZE.G_RailRingRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_RAILSHOT
		return 150
	else
		return 0
	end
end

ZE.G_AccelRSDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_THROWNACCEL
		return 5
	else
		return 0
	end
end

ZE.G_MeleeDamage = function(mobj, hurthealth)
	if mobj.type == MT_PLAYER
		if mobj.player.powers[pw_invulnerability]
		or mobj.player.powers[pw_super]
			return 0 --Super and invulnerability damage.
		else
			return 0
		end
	else
		return 0
	end
end

ZE.G_RedRingDamage = function(mobj, hurthealth)
	if mobj.type == MT_REDRING
		if mobj.flags2 & MF2_RAILRING
			return 0
		else
			return 2
		end
	else
		return 0
	end
end

ZE.G_FireTrailDamage = function(mobj, hurthealth)
	if mobj.type == MT_SPINFIRE
		return 2
	else
		return 0
	end
end

ZE.G_HammerDamage = function(mobj, hurthealth)
	if mobj.type == MT_LHRT
		return 15
	else
		return 0
	end
end

ZE.G_ZMeleeDamage = function(mobj, hurthealth)
	if mobj.type == MT_RS_ZMELEE
		return 15
	else
		return 0
	end
end

ZE.G_CorkDamage = function(mobj, hurthealth)
	if mobj.type == MT_CORK
		return 75
	else
		return 0
	end
end

ZE.G_AddToDamageTable(35*FRACUNIT, "%s humiliated %s with the red ring of death.", ZE.G_NormalRingRS)
ZE.G_AddToDamageTable(250*FRACUNIT, "%s poked a hole in %s with a rail ring.", ZE.G_RailRingDamage)
ZE.G_AddToDamageTable(2*FRACUNIT, "%s stood in the face of %s's immortal aura.", ZE.G_MeleeDamage, true)
ZE.G_AddToDamageTable(3*FRACUNIT, "%s turned %s into swiss cheese with automatic rings.", ZE.G_AutomaticRingDamage)
ZE.G_AddToDamageTable(14*FRACUNIT, "%s bounced away %s with bounce rings.", ZE.G_BounceRingDamage)
ZE.G_AddToDamageTable(4*FRACUNIT, "%s scatterbrained %s with scatter rings.", ZE.G_ScatterRingDamage)
ZE.G_AddToDamageTable(9*FRACUNIT, "%s showed %s that the possibilities are never-ending.", ZE.G_InfinityRingDamage)
ZE.G_AddToDamageTable(0, "%s is cooking fried %s for dinner.", ZE.G_FireTrailDamage)
ZE.G_AddToDamageTable(24*FRACUNIT, "%s hit with a hammer to the %s face.", ZE.G_HammerDamage)
ZE.G_AddToDamageTable(2*FRACUNIT, "%s gave a few scratches on %s arm.", ZE.G_ZMeleeDamage)
ZE.G_AddToDamageTable(24*FRACUNIT, "%s knocked %s in the head with a cork.", ZE.G_CorkDamage)
ZE.G_AddToDamageTable(48*FRACUNIT, "%s poked a hole in %s with a rail ring.", ZE.G_RailRingRSDamage)
ZE.G_AddToDamageTable(2*FRACUNIT, "%s turned %s into fried bacon", ZE.G_FlameRSDamage)
ZE.G_AddToDamageTable(1*FRACUNIT, "%s pumped %s with bubbles (WHAT?)", ZE.G_SplashRSDamage)
ZE.G_AddToDamageTable(1*FRACUNIT, "%s pumped %s with bubbles (WHAT?)", ZE.G_SplashAOERSDamage)
ZE.G_AddToDamageTable(24*FRACUNIT, "%s exploded %s with an flash shot.", ZE.G_FlashShotDamage)
ZE.G_AddToDamageTable(27*FRACUNIT, "%s exploded %s with an seeker.", ZE.G_SeekerRSDamage)
ZE.G_AddToDamageTable(24*FRACUNIT, "%s trapped %s with a grenade ring.", ZE.G_GrenadeRingDamage)
ZE.G_AddToDamageTable(24*FRACUNIT, "%s exploded %s with an explosion ring.", ZE.G_ExplosionRingDamage)
ZE.G_AddToDamageTable(18*FRACUNIT, "%s killed %s.", ZE.G_StoneRSDamage)
ZE.G_AddToDamageTable(8*FRACUNIT, "%s killed %s.", ZE.G_StoneDebrisRSDamage)
ZE.G_AddToDamageTable(6*FRACUNIT, "%s killed %s.", ZE.G_AccelRSDamage)
ZE.G_AddToDamageTable(38*FRACUNIT, "%s killed %s.", ZE.G_FlashShotRSDamage)
ZE.G_AddToDamageTable(8*FRACUNIT, "%s killed %s.", ZE.G_BurstRSDamage)