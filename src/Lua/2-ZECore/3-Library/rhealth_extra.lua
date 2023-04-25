local ZE = RV_ZESCAPE

ZE.G_SwordDamage = function(mobj, hurthealth)
	if mobj.type == ZE.GetObjectTypeOrNull("MT_SWORDDAMAGE")
		return 1
	else
		return 0
	end
end

ZE.G_ScarfPlasmaDamage = function(mobj, hurthealth)
	if mobj.type == ZE.GetObjectTypeOrNull("MT_SCARFSHOT")
		return 50
	else
		return 0
	end
end

ZE.G_MilneCrystalDamage = function(mobj, hurthealth)
	if mobj.type == ZE.GetObjectTypeOrNull("MT_THROWNCRYSTAL")
		return 25
	else
		return 0
	end
end

ZE.G_ClawsDamage = function(mobj, hurthealth)
	if mobj.type == ZE.GetObjectTypeOrNull("MT_RS_ZCLAWS")
		return 50
	else
		return 0
	end
end

ZE.G_RSBounceDamage = function(mobj, hurthealth)
	if mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNBOUNCE")
		return 50
	else
		return 0
	end
end

ZE.G_HS_PistolDamage = function(mobj, hurthealth)
	if mobj.type == ZE.GetObjectTypeOrNull("MT_RS_HS_SHOT")
		return 65
	else
		return 0
	end
end

ZE.G_FistDamage = function(mobj, hurthealth)
	if mobj.type == ZE.GetObjectTypeOrNull("MT_RS_FIST")
		return 150
	else
		return 0
	end
end

ZE.G_ScarfRevoler = function(mobj, hurthealth)
    if mobj.type == ZE.GetObjectTypeOrNull("MT_SCARFHELLREVOLER")
        return 50
    else
        return 0
    end
end

ZE.G_SerpentineRocket = function(mobj, hurthealth)
    if mobj.type == ZE.GetObjectTypeOrNull("MT_SERPENTINE_ROCKET")
        return 75
    else
        return 0
    end
end

ZE.G_SerpentineFire = function(mobj, hurthealth)
    if mobj.type == ZE.GetObjectTypeOrNull("MT_SERPENTINE_FIRE")
        return 26
    else
        return 0
    end
end

ZE.G_SteveCrossbow = function(mobj, hurthealth)
    if mobj.type == ZE.GetObjectTypeOrNull("MT_CROSSBOW")
        return 140
    else
        return 0
    end
end

ZE.G_OofBall = function(mobj, hurthealth)
    if mobj.type == ZE.GetObjectTypeOrNull("MT_BASKETBALL")
        return 60
    else
        return 0
    end
end



ZE.G_LandMine = function(mobj, hurthealth)
    if mobj.type == ZE.GetObjectTypeOrNull("MT_LANDMINE")
        return 60
    else
        return 0
    end
end

ZE.G_AddToDamageTable(27*FRACUNIT, "%s killed %s.", ZE.G_OofBall)
ZE.G_AddToDamageTable(27*FRACUNIT, "%s killed %s.", ZE.G_SteveCrossbow)
ZE.G_AddToDamageTable(27*FRACUNIT, "%s killed %s.", ZE.G_SerpentineRocket)
ZE.G_AddToDamageTable(27*FRACUNIT, "%s killed %s.", ZE.G_SerpentineFire)
ZE.G_AddToDamageTable(27*FRACUNIT, "%s killed %s.", ZE.G_ScarfRevoler)
ZE.G_AddToDamageTable(10*FRACUNIT, "%s killed %s.", ZE.G_SwordDamage)
ZE.G_AddToDamageTable(27*FRACUNIT, "%s killed %s.", ZE.G_ScarfPlasmaDamage)
ZE.G_AddToDamageTable(16*FRACUNIT, "%s killed %s.", ZE.G_MilneCrystalDamage)
ZE.G_AddToDamageTable(1*FRACUNIT, "%s beat %s to death.", ZE.G_ClawsDamage)
ZE.G_AddToDamageTable(16*FRACUNIT, "%s killed %s.", ZE.G_RSBounceDamage)
ZE.G_AddToDamageTable(55*FRACUNIT, "%s killed %s.", ZE.G_HS_PistolDamage)
ZE.G_AddToDamageTable(48*FRACUNIT, "%s killed %s.", ZE.G_FistDamage)
ZE.G_AddToDamageTable(48*FRACUNIT, "%s exploded %s.", ZE.G_LandMine)