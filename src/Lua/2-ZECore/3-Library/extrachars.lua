local ZE = RV_ZESCAPE
local CV = ZE.Console

freeslot(
"MT_RS_HS_SHOT",
"MT_RS_FIST"
)

ZE.survskins = {"sonic", "tails", "amy", "knuckles", "fang", "metalsonic", "bob", "revenger", "scarf", "milne", "w", "serpentine", "steve", "peppino", "noise", "snick", "fakepep"}
ZE.survskinsplay = {"sonic", "tails", "knuckles"}

ZE.ExtraCharsStamina = function(player)
	if (gametype == GT_ZESCAPE)
	    player.stamina = $ or 0
		if not (player.mo and player.mo.valid) return end
		local cmd = player.cmd
	    if (player.mo.skin == "milne") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 22*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -10
	   elseif (player.mo.skin == "bob") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 24*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -11
	   elseif (player.mo.skin == "revenger") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 26*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -8
	   elseif (player.mo.skin == "scarf") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 25*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -12
	   elseif (player.mo.skin == "w") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 25*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -9
	   elseif (player.mo.skin == "serpentine") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
		   player.normalspeed = 25*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -12
	   elseif (player.mo.skin == "steve") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 24*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -12
	   elseif (player.mo.skin == "oof") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 23*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -12
	   elseif (player.mo.skin == "peppino") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 25*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -10
	   elseif (player.mo.skin == "noise") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 26*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -9
	   elseif (player.mo.skin == "snick") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 28*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -7
	   elseif (player.mo.skin == "fakepep") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 24*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -12
	   elseif (player.mo.skin == "chaoze") and not (player.stamina <= 0) and (player.cmd.buttons & BT_CUSTOM1) and (cmd.forwardmove > 0 or cmd.forwardmove < 0 or cmd.sidemove < 0 or cmd.sidemove > 0)
	       player.normalspeed = 18*FRACUNIT
		   player.runspeed = 16*FRACUNIT
		   player.stamina = $ -8
	   end
	end
end

ZE.ExtraCharsStartHealth = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if not (leveltime > CV.waittime)
	if (player.mo and player.mo.valid)
	  if (player.mo.skin == "milne")
		player.mo.health = 75
	elseif (player.mo.skin == "bob")
		player.mo.health = 115
	elseif (player.mo.skin == "revenger")
		player.mo.health = 130
	elseif (player.mo.skin == "scarf")
		player.mo.health = 125
	elseif (player.mo.skin == "w")
		player.mo.health = 120
	elseif (player.mo.skin == "serpentine")
	    player.mo.health = 120
	elseif (player.mo.skin == "steve")
		player.mo.health = 200
	elseif (player.mo.skin == "oof")
		player.mo.health = 120
	elseif (player.mo.skin == "peppino")
		player.mo.health = 110
	elseif (player.mo.skin == "noise")
		player.mo.health = 135
	elseif (player.mo.skin == "snick")
		player.mo.health = 110
	elseif (player.mo.skin == "fakepep")
		player.mo.health = 150
	elseif (player.mo.skin == "motobugze")
		player.mo.health = 1
	elseif (player.mo.skin == "chaoze")
		player.mo.health = 50
	      end
       end
	end
end

ZE.ExtraCharsHealthLimit = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
	  if (player.mo.skin == "milne" and player.mo.health > 100) and not (player.maxhp == 1) then
		player.mo.health = 100
	elseif (player.mo.skin == "bob" and player.mo.health > 115) and not (player.maxhp == 1) then
		player.mo.health = 115
	elseif (player.mo.skin == "revenger" and player.mo.health > 130) and not (player.maxhp == 1) then
		player.mo.health = 130
	elseif (player.mo.skin == "scarf" and player.mo.health > 125) and not (player.maxhp == 1) then
		player.mo.health = 125
	elseif (player.mo.skin == "w" and player.mo.health > 120) and not (player.maxhp == 1) then
		player.mo.health = 120
	elseif (player.mo.skin == "serpentine" and player.mo.health > 120) and not (player.maxhp == 1) then
		player.mo.health = 120
	elseif (player.mo.skin == "steve" and player.mo.health > 300) and not (player.maxhp == 1) then
	    player.mo.health = 300 --Gameplay experiment.
	elseif (player.mo.skin == "oof" and player.mo.health > 120) and not (player.maxhp == 1) then
	    player.mo.health = 120
	elseif (player.mo.skin == "peppino" and player.mo.health > 145) and not (player.maxhp == 1) then
	    player.mo.health = 145
	elseif (player.mo.skin == "noise" and player.mo.health > 135) and not (player.maxhp == 1) then
	    player.mo.health = 135
	elseif (player.mo.skin == "snick" and player.mo.health > 110) and not (player.maxhp == 1) then
	    player.mo.health = 110
	elseif (player.mo.skin == "fakepep" and player.mo.health > 175) and not (player.maxhp == 1) then
	    player.mo.health = 175
	elseif (player.mo.skin == "chaoze" and player.mo.health > 130) and not (player.maxhp == 1) then
	    player.mo.health = 130
    elseif (survskins and player.maxhp == 1 and player.mo.health > 700) and not (player.ctfteam == 1) then
	    player.mo.health = 700
		end
	end
end

ZE.ExtraCharsProjectileCollide = function(mo, pmo)
   if not GT_ZESCAPE then return end
     if pmo.skin == "milne"
		 or pmo.skin == "bob"
		   or pmo.skin == "revenger"
		    or pmo.skin == "scarf"
			 or pmo.skin == "w"
			  or pmo.skin == "serpentine"
			   or pmo.skin == "steve"
			    or pmo.skin == "oof"
				 or pmo.skin == "peppino"
				  or pmo.skin == "noise"
				   or pmo.skin == "snick"
				    or pmo.skin == "fakepep"
					 or pmo.skin == "chaoze"
		return false
	end
end

ZE.ExtraCharsHearthMobjMoveCollide = function(mo, pmo)
   if not GT_ZESCAPE then return end
     if pmo.skin == "milne" and pmo.health >= 175
		   or pmo.skin == "bob" and pmo.health >= 115
		    or pmo.skin == "scarf" and pmo.health >= 150
			 or pmo.skin == "revenger" and pmo.health >= 130
			  or pmo.skin == "w" and pmo.health >= 120
			   or pmo.skin == "serpentine" and pmo.health >= 135
			    or pmo.skin == "steve" and pmo.health >= 156
			     or pmo.skin == "oof" and pmo.health >= 120
				  or pmo.skin == "peppino" and pmo.health >= 250
				   or pmo.skin == "noise" and pmo.health >= 300
				    or pmo.skin == "snick" and pmo.health >= 250
				     or pmo.skin == "fakepep" and pmo.health >= 275
					  or pmo.skin == "chaoze" and pmo.health >= 175
		return false
	end
end

ZE.ExtraCharsPropMobjCollide = function(mo, pmo)
     if pmo.skin == "milne"
	  or pmo.skin == "bob"
		or pmo.skin == "revenger"
		  or pmo.skin == "scarf"
			or pmo.skin == "w"
			  or pmo.skin == "serpentine"
			    or pmo.skin == "steve"
				  or pmo.skin == "oof"
				    or pmo.skin == "peppino"
				     or pmo.skin == "noise"
				      or pmo.skin == "snick"
				        or pmo.skin == "fakepep"
						 or pmo.skin == "chaoze"
		  P_SetObjectMomZ(mo,mo.scale*0)
		return false
	  else
	     P_SetObjectMomZ(mo,mo.scale*-128)
	end
end

ZE.ExtraPropProjectileCollide = function(mo, mobj)
	 if mobj.type == MT_SCARFSHOT
	 or mobj.type == MT_SWORDDAMAGE
	 or mobj.type == MT_RS_HS_SHOT
	 or mobj.type == MT_RS_FIST
		return false
	end
end