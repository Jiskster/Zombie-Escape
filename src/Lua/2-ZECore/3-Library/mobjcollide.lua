local ZE = RV_ZESCAPE

ZE.ProjectileCollide = function(mo, pmo)
   if not GT_ZESCAPE then return end
     if pmo.skin == "sonic"
	  or pmo.skin == "tails"
	   or pmo.skin == "knuckles"
	    or pmo.skin == "amy"
		 or pmo.skin == "metalsonic"
		  or pmo.skin == "fang"
		return false
	end
end

ZE.HearthMobjMoveCollide = function(mo, pmo)
   if not GT_ZESCAPE then return end
     if pmo.skin == "sonic" and pmo.health >= 125
	  or pmo.skin == "tails" and pmo.health >= 95
	   or pmo.skin == "knuckles" and pmo.health >= 200
	    or pmo.skin == "amy" and pmo.health >= 200
		 or pmo.skin == "metalsonic" and pmo.health >= 150
		  or pmo.skin == "fang" and pmo.health >= 150
		return false
	end
end

ZE.PropMobjCollide = function(mo, pmo)
     if pmo.skin == "sonic"
	  or pmo.skin == "tails"
	   or pmo.skin == "knuckles"
	    or pmo.skin == "amy"
		 or pmo.skin == "metalsonic"
		  or pmo.skin == "fang"
		  P_SetObjectMomZ(mo,mo.scale*0)
		return false
	  else
	     P_SetObjectMomZ(mo,mo.scale*-128)
	end
end

ZE.PropProjectileCollide = function(mo, mobj)
     if mobj.type == MT_RS_THROWNAUTOMATIC
     or mobj.type == MT_RS_THROWNSCATTER
     or mobj.type == MT_RS_THROWNGRENADE
     or mobj.type == MT_RS_THROWNEXPLOSION
     or mobj.type == MT_RS_THROWNSEEKER
     or mobj.type == MT_RS_THROWNSPLASH
     or mobj.type == MT_RS_SPLASH_AOE
     or mobj.type == MT_RS_THROWNACCEL
     or mobj.type == MT_RS_THROWNWAVE
     or mobj.type == MT_RS_THROWNSTONE
     or mobj.type == MT_RS_STONEDEBRIS
     or mobj.type == MT_RS_FLASHSHOT
     or mobj.type == MT_RS_THROWNBURST
     or mobj.type == MT_RS_THROWNFLAME
     or mobj.type == MT_RS_THROWNINFINITY
     or mobj.type == MT_RS_SHOT
     or mobj.type == MT_RS_MINISHOT
     or mobj.type == MT_RS_MEGASHOT
     or mobj.type == MT_RS_THROWNBOUNCE
	 or mobj.type == MT_CORK
	 or mobj.type == MT_LHRT
		return false
	end
end
