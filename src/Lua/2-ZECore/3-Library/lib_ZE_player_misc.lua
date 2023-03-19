local ZE = RV_ZESCAPE

ZE.CharacterColors = function()
   for player in players.iterate
	if (player.mo and player.mo.valid)
			if (player.mo.skin == "sonic")
			   player.mo.color = SKINCOLOR_BLUE
			elseif (player.mo.skin == "tails")
			   player.mo.color = SKINCOLOR_ORANGE
			elseif (player.mo.skin == "knuckles")
			   player.mo.color = SKINCOLOR_RED
			elseif (player.mo.skin == "amy")
			   player.mo.color = SKINCOLOR_ROSY
			elseif (player.mo.skin == "metalsonic")
			   player.mo.color = SKINCOLOR_COBALT
			elseif (player.mo.skin == "fang")
			   player.mo.color = SKINCOLOR_LAVENDER
			elseif (player.mo.skin == "bob")
			   player.mo.color = SKINCOLOR_YELLOW
			elseif (player.mo.skin == "revenger")
			   player.mo.color = SKINCOLOR_BLACK
			elseif (player.mo.skin == "scarf")
			   player.mo.color = SKINCOLOR_CARBON
			elseif (player.mo.skin == "dzombie")
			   player.mo.color = SKINCOLOR_MOSS
		   end
		end
	end
end

mobjinfo[MT_CORK].speed = 152*FRACUNIT //Balance tweak to preserve some of the challenge

ZE.CorkStuff = function(mo)
	return true //Overwrite default behavior so that corks won't damage invulnerable players
end

//Add ghost trail to the cork to improve its visibility
ZE.CorkTrail = function(mo)
	if mo.flags&MF_MISSILE and mo.target and mo.target.player then
		local ghost = P_SpawnGhostMobj(mo)
		ghost.destscale = ghost.scale*4
		if not(gametyperules&GTR_FRIENDLY) //Add color trail to competitive gametypes
			ghost.colorized = true
			ghost.color = mo.target.player.skincolor
		end
	end
end