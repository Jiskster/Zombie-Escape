local ZE = RV_ZESCAPE

ZE.BuildPropWood = function(player)
		if player.mo and player.mo.valid
        P_SpawnMobj(player.mo.x+FixedMul(128*FRACUNIT, cos(player.mo.angle)),
					player.mo.y+FixedMul(128*FRACUNIT, sin(player.mo.angle)), player.mo.z, MT_PROPWOOD)
		S_StartSound(player.mo, sfx_jshard)
		player.propspawn = $-1
	end
end

ZE.BuildPropShieldBox = function(player)
		if player.mo and player.mo.valid
        P_SpawnMobj(player.mo.x+FixedMul(0*FRACUNIT, cos(player.mo.angle)),
					player.mo.y+FixedMul(0*FRACUNIT, sin(player.mo.angle)), player.mo.z, MT_PITY_BOX)
		S_StartSound(player.mo, sfx_jshard)
		player.propspawn = $-1
	end
end
ZE.ResetPropSpawn = function(player)
	if player.mo and player.mo.valid then
		player.propspawn = 2
	end
end

ZE.SpawnProps = function(player)
     if player.mo and player.mo.valid
	    player.propspawn = $ or 0
	end  
	   if (propspawn == 0) then return end
		 if player.mo and player.mo.skin == "tails"
		   if player.propspawn == 0 then return end
		      player.builddelay = $ or 0
		      if (player.cmd.buttons & BT_TOSSFLAG) and not (player.builddelay ~= 0)
		         player.builddelay = 1*TICRATE
		         ZE.BuildPropWood(player)
              end
	         if player.builddelay ~= 0 then
	            player.builddelay = $-1
		end
	end
		 if player.mo and player.mo.skin == "amy"
		   if player.propspawn == 0 then return end
		      player.builddelay = $ or 0
		     if (player.cmd.buttons & BT_TOSSFLAG) and not (player.builddelay ~= 0)
		         player.builddelay = 1*TICRATE
		         ZE.BuildPropShieldBox(player)
             end
	     if player.builddelay ~= 0 then
	        player.builddelay = $-1
		end
	end
end