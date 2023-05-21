local ZE = RV_ZESCAPE
local CV = ZE.Console

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