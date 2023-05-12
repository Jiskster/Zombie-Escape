local function piercevisual(mo)
	if not (mo and mo.valid) return end
	if mo.pierce and leveltime%2
		local g = P_SpawnGhostMobj(mo)
		if g and g.valid
			g.color = SKINCOLOR_RED
			g.colorized = true
			g.destscale = $ * 2
		end
	end
end
for i = MT_RS_SHOT, MT_RS_THROWNINFINITY
	addHook("MobjThinker", piercevisual, i)
end

local function dofuse(mo)
	if not (mo and mo.valid) return end
	if mo.lifetime == nil
		return
	end
	mo.lifetime = $ - 1
	if mo.lifetime == 0
		mo.momx = 0
		mo.momy = 0
		mo.momz = 0
		S_StopSoundByID(mo, sfx_s3kc6l)
		P_ExplodeMissile(mo)
		return
	end
	if mo.lifetime > 0 and mo.lifetime % 12 == 0 and mo.info.attacksound
		S_StartSound(mo, mo.info.attacksound)
	end
end

addHook("MobjThinker", dofuse, MT_RS_THROWNBOUNCE)
addHook("MobjThinker", dofuse, MT_RS_THROWNSCATTER)
addHook("MobjThinker", dofuse, MT_RS_ZMELEE)
addHook("MobjThinker", dofuse, MT_RS_THROWNGRENADE)
addHook("MobjThinker", dofuse, MT_RS_THROWNSEEKER)
addHook("MobjThinker", dofuse, MT_RS_THROWNSPLASH)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) return end
	if mo.state < mo.info.spawnstate or mo.state > S_RS_THROWNSEEKER7
		return
	end
	if not (mo.target and mo.target.valid and mo.target.player and mo.target.player.playerstate == PST_LIVE)
		return
	end
	
	local player = mo.target.player
	local pmo = mo.target
	local speed = R_PointToDist2(0,0,mo.momx,mo.momy)
	local newang = mo.angle + ((pmo.angle - mo.angle) / 38)
	P_InstaThrust(mo, newang, speed)
	mo.angle = newang
	local diff = player.aiming - mo.aimingstart
	mo.momz = FixedMul($ + diff / 8800, mo.scale)
	
	if mo.state == mo.info.spawnstate
		P_SpawnGhostMobj(mo).destscale = $*2
	end
end, MT_RS_THROWNSEEKER)

addHook("MobjSpawn", function(mo)
	if not (mo and mo.valid) return end
	S_StartSoundAtVolume(mo, sfx_s3kc6l, 50)
end, MT_RS_THROWNSEEKER)
addHook("MobjDeath", function(mo)
	if not (mo and mo.valid) return end
	S_StopSoundByID(mo, sfx_s3kc6l)
end, MT_RS_THROWNSEEKER)

addHook("MobjSpawn", function(mo)
	if not (mo and mo.valid) return end
	mo.state = $ + P_RandomRange(0, 6)
end, MT_RS_THROWNAUTOMATIC)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) return end
	mo.momx = $ * 12/11
	mo.momy = $ * 12/11
	mo.momz = $ * 12/11
end, MT_RS_THROWNACCEL)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) return end
	mo.momx = $ * 9/10
	mo.momy = $ * 9/10
	mo.momz = $ * 9/10
end, MT_RS_SPLASH_AOE)

addHook("MobjSpawn", function(mo)
	if not (mo and mo.valid) return end
	mo.state = $ + P_RandomRange(0, 7)
	local ang = P_RandomRange(0, 359) * ANG1
	P_Thrust(mo, ang, 300 * FRACUNIT)
end, MT_RS_THROWNBURST)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) return end
	if mo.lifetime
		if (mo.lifetime % 2) == 0
			local mobj = P_SpawnMobjFromMobj(mo,0,0,0,MT_THOK)
			if mobj and mobj.valid
				mobj.sprite = SPR_BUBL
				mobj.frame = $ + B
				mobj.fuse = TICRATE/2
				mobj.tics = mobj.fuse
				mobj.color = mo.color
				mobj.colorized = true
			end
		end
		if (mo.lifetime % 4) == 0
			S_StartSound(mo, P_RandomRange(sfx_bubbl1, sfx_bubbl5))
		end
	end
	mo.momx = $ * 94/100
	mo.momy = $ * 94/100
	mo.momz = $ * 94/100
end, MT_RS_THROWNSPLASH)

addHook("MobjThinker", function(mo)
	if not (mo and mo.valid) return end
	mo.momx = $ * 85/100
	mo.momy = $ * 85/100
	mo.momz = $ * 85/100
	P_SetObjectMomZ(mo, FRACUNIT/5, true)
end, MT_RS_THROWNFLAME)