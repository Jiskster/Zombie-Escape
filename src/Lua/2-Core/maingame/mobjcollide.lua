local ZE = RV_ZESCAPE

ZE.ProjectileCollide = function(mo, pmo)
   if not GT_ZESCAPE then return end
     if pmo.skin ~= "dzombie" then
		return false
	end
end

ZE.HearthMobjMoveCollide = function(mo, pmo)
   if not GT_ZESCAPE then return end
   if not pmo.player or not (pmo.flags & MF_MONITOR) then return end
	if (pmo.flags & MF_MONITOR) then
		return true
	end
	
   	if pmo.skin ~= "dzombie" and pmo.health >= pmo.maxHealth
		return false
	end
end

ZE.PropMobjCollide = function(mo, pmo)
     if pmo.skin ~= "dzombie"
		  P_SetObjectMomZ(mo,mo.scale*0)
		return false
	  else
	     P_SetObjectMomZ(mo,mo.scale*-128)
		
	end
end

ZE.PropProjectileCollide = function(mo, mobj)
     if mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNAUTOMATIC")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNSCATTER")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNGRENADE")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNEXPLOSION")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNSEEKER")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNSPLASH")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_SPLASH_AOE")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNACCEL")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNWAVE")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNSTONE")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_STONEDEBRIS")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_FLASHSHOT")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNBURST")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNFLAME")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNINFINITY")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_SHOT")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_MINISHOT")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_MEGASHOT")
     or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_THROWNBOUNCE")
	 or mobj.type == ZE.GetObjectTypeOrNull("MT_CORK")
	 or mobj.type == ZE.GetObjectTypeOrNull("MT_LHRT")
	 or mobj.type == ZE.GetObjectTypeOrNull("MT_SCARFSHOT")
	 or mobj.type == ZE.GetObjectTypeOrNull("MT_SWORDDAMAGE")
	 or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_HS_SHOT")
	 or mobj.type == ZE.GetObjectTypeOrNull("MT_RS_FIST")
		return false
	end
end
