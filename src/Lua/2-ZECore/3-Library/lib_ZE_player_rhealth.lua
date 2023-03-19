local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.StartHealth = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if not (leveltime > CV.waittime)
	if (player.mo and player.mo.valid)
	  if (player.mo.skin == "sonic")
		player.mo.health = 125
	elseif (player.mo.skin == "tails")
		player.mo.health = 95
	elseif (player.mo.skin == "knuckles")
		player.mo.health = 175
	elseif (player.mo.skin == "amy")
		player.mo.health = 100
	elseif (player.mo.skin == "fang")
		player.mo.health = 150
	elseif (player.mo.skin == "metalsonic")
		player.mo.health = 150
	      end
       end
	end
end

ZE.HealthLimit = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
	  if (player.mo.skin == "sonic" and player.mo.health > 125) and not (player.maxhp == 1) then
		player.mo.health = 125
	elseif (player.mo.skin == "tails" and player.mo.health > 95) and not (player.maxhp == 1) then
		player.mo.health = 95
	elseif (player.mo.skin == "knuckles" and player.mo.health > 175) and not (player.maxhp == 1) then
		player.mo.health = 175
	elseif (player.mo.skin == "amy" and player.mo.health > 200) and not (player.maxhp == 1) then
		player.mo.health = 200
	elseif (player.mo.skin == "fang" and player.mo.health > 150) and not (player.maxhp == 1) then
		player.mo.health = 150
	elseif (player.mo.skin == "metalsonic" and player.mo.health > 150) and not (player.maxhp == 1) then
		player.mo.health = 150
    elseif (survskins and player.maxhp == 1 and player.mo.health > 400) and not (player.ctfteam == 1) then
	    player.mo.health = 400
		end
	end
end

ZE.AmyRegen = function(player)
    if not (gametype == GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
	  if not (player.mo.skin == "amy" or player.mo.skin == "noise") return end
	    player.regen = $ or 0
	    if (player.mo.health < 200) then
		  player.regen = $1 - 1
		end
		if (player.regen <= 0*TICRATE) then
		   player.mo.health = $ + 2
		   player.regen = 1*TICRATE
		else
		    return end
	end
end

ZE.ZombieHealth = function(player)
if gametype == GT_ZESCAPE
 if player.mo and player.mo.valid
  if player.ctfteam == 2 return end
   if (player.ctfteam == 1) and not (player.spectator) and not (player.alphazm == 1)
     and player.powers[pw_flashing] > 0
		player.mo.health = 5000
		end
		 if (player.alphazm == 1) and player.powers[pw_flashing] > 0 then
		   player.mo.health = 9999
		   end
	   end
	end
end

ZE.HealthOrb = function(obj, play)
   local player = play.player
		if (player.mo)
		and (player.ctfteam == 2)
		     player.maxhp = 1
		     player.mo.health = $ +200
	end
end