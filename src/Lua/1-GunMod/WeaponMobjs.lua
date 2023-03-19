freeslot(

"MT_RS_SHOT",
"MT_RS_MINISHOT",
"MT_RS_MEGASHOT",

"MT_RS_THROWNAUTOMATIC",

"MT_RS_THROWNBOUNCE",

"MT_RS_THROWNSCATTER",
"S_RS_THROWNSCATTER1",
"S_RS_THROWNSCATTER2",
"S_RS_THROWNSCATTER3",
"S_RS_THROWNSCATTER4",
"S_RS_THROWNSCATTER5",
"S_RS_THROWNSCATTER6",
"S_RS_THROWNSCATTER7",

"MT_RS_THROWNGRENADE",

"MT_RS_THROWNEXPLOSION",

"MT_RS_THROWNSEEKER",
"S_RS_THROWNSEEKER1",
"S_RS_THROWNSEEKER2",
"S_RS_THROWNSEEKER3",
"S_RS_THROWNSEEKER4",
"S_RS_THROWNSEEKER5",
"S_RS_THROWNSEEKER6",
"S_RS_THROWNSEEKER7",
"SPR_THER",
"SPR_RNGM",

"MT_RS_THROWNSPLASH",
"S_RS_THROWNSPLASH1",
"S_RS_THROWNSPLASH2",
"S_RS_SPLASHBOOM",
"SPR_RNGP",
"MT_RS_SPLASH_AOE",

"MT_RS_THROWNACCEL",
"S_RS_THROWNACCEL1",
"S_RS_THROWNACCEL2",
"S_RS_THROWNACCEL3",
"S_RS_THROWNACCEL4",
"SPR_RNGC",

"MT_RS_THROWNWAVE",
"S_RS_THROWNWAVE",
"SPR_RNGW",

"MT_RS_THROWNSTONE",
"S_RS_THROWNSTONE1",
"S_RS_THROWNSTONE2",
"S_RS_THROWNSTONE3",
"S_RS_THROWNSTONE4",
"S_RS_STONEBREAK",
"MT_RS_STONEDEBRIS",
"S_RS_STONEDEBRIS",
"SPR_RNGK",
"SPR_ROIQ",

"MT_RS_FLASHSHOT",
"S_RS_FLASHBURST",

"MT_RS_THROWNBURST",
"S_RS_THROWNBURST1",
"S_RS_THROWNBURST2",
"S_RS_THROWNBURST3",
"S_RS_THROWNBURST4",
"S_RS_THROWNBURST5",
"S_RS_THROWNBURST6",
"S_RS_THROWNBURST7",
"S_RS_THROWNBURST8",
"SPR_RNGT",

"MT_RS_THROWNFLAME",
"S_RS_THROWNFLAME1",
"S_RS_THROWNFLAME2",
"S_RS_THROWNFLAME3",
"SPR_RNGF",

"MT_RS_THROWNINFINITY",

//Don't include MT_RS_RAILSHOT in some of the hook stuff
"MT_RS_RAILSHOT",

"MT_RS_ZMELEE",
"S_RS_ZMELEETHROWN1",
"S_RS_ZMELEETHROWN2",
"S_RS_ZMELEETHROWN3"
)

mobjinfo[MT_RS_ZMELEE] = {
	spawnstate = S_RS_ZMELEETHROWN1,
	deathstate = S_SPRK1,
	deathsound = 0,
	speed = 48*FRACUNIT,
	radius = 32*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
mobjinfo[MT_RS_ZMELEE].name = "Zombie melee"

states[S_RS_ZMELEETHROWN1] = {
	nextstate = S_RS_ZMELEETHROWN2,
	sprite = SPR_RNGV,
	frame = FF_FULLBRIGHT|1,
	tics = 1,
	action = A_ThrownRing
}

states[S_RS_ZMELEETHROWN2] = {
	nextstate = S_RS_ZMELEETHROWN3,
	sprite = SPR_RNGV,
	frame = FF_FULLBRIGHT|2,
	tics = 1,
	action = A_ThrownRing
}

states[S_RS_ZMELEETHROWN3] = {
	nextstate = S_RS_ZMELEETHROWN1,
	sprite = SPR_RNGV,
	frame = FF_FULLBRIGHT|3,
	tics = 1,
	action = A_ThrownRing
}

mobjinfo[MT_RS_SHOT] = {
	spawnstate = S_RRNG1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_die,
	speed = 60*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}
mobjinfo[MT_RS_SHOT].name = "Normal Ring"

mobjinfo[MT_RS_MINISHOT] = {
	spawnstate = S_RRNG1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_die,
	speed = 65*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}
mobjinfo[MT_RS_MINISHOT].name = "Mini Ring"

mobjinfo[MT_RS_MEGASHOT] = {
	spawnstate = S_RRNG1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_die,
	speed = 55*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}
mobjinfo[MT_RS_MEGASHOT].name = "Giga Ring"

mobjinfo[MT_RS_THROWNAUTOMATIC] = {
	spawnstate = S_THROWNAUTOMATIC1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_die,
	speed = 128*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}
mobjinfo[MT_RS_THROWNAUTOMATIC].name = "Automatic Ring"

mobjinfo[MT_RS_THROWNBOUNCE] = {
	spawnstate = S_THROWNBOUNCE1,
	activesound = sfx_rs_bo2,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_die,
	speed = 55*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY|MF_GRENADEBOUNCE|MF_BOUNCE
}
mobjinfo[MT_RS_THROWNBOUNCE].name = "Bounce Ring"

mobjinfo[MT_RS_THROWNSCATTER] = {
	spawnstate = S_RS_THROWNSCATTER1,
	activesound = sfx_shgn,
	deathstate = S_SPRK1,
	speed = 96*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
mobjinfo[MT_RS_THROWNSCATTER].name = "Scatter Ring"

states[S_RS_THROWNSCATTER1] = {
	nextstate = S_RS_THROWNSCATTER2,
	sprite = SPR_RNGS,
	frame = FF_FULLBRIGHT,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSCATTER2] = {
	nextstate = S_RS_THROWNSCATTER3,
	sprite = SPR_RNGS,
	frame = FF_FULLBRIGHT|5,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSCATTER3] = {
	nextstate = S_RS_THROWNSCATTER4,
	sprite = SPR_RNGS,
	frame = FF_FULLBRIGHT|10,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSCATTER4] = {
	nextstate = S_RS_THROWNSCATTER5,
	sprite = SPR_RNGS,
	frame = FF_FULLBRIGHT|15,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSCATTER5] = {
	nextstate = S_RS_THROWNSCATTER6,
	sprite = SPR_RNGS,
	frame = FF_FULLBRIGHT|20,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSCATTER6] = {
	nextstate = S_RS_THROWNSCATTER7,
	sprite = SPR_RNGS,
	frame = FF_FULLBRIGHT|25,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSCATTER7] = {
	nextstate = S_RS_THROWNSCATTER1,
	sprite = SPR_RNGS,
	frame = FF_FULLBRIGHT|30,
	tics = 1,
	action = A_ThrownRing
}

mobjinfo[MT_RS_THROWNGRENADE] = {
	spawnstate = S_THROWNGRENADE1,
	deathstate = S_RINGEXPLODE,
	deathsound = sfx_rs_gr2,
	attacksound = sfx_s3k5c,//beep
	activesound = sfx_s3k5d,//impact
	painchance = 150*FRACUNIT,
	speed = 42*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_BOUNCE|MF_GRENADEBOUNCE
}
mobjinfo[MT_RS_THROWNGRENADE].name = "Grenade Ring"

mobjinfo[MT_RS_THROWNEXPLOSION] = {
	spawnstate = S_TORPEDO,
	seesound = sfx_brakrl,
	deathstate = S_RINGEXPLODE,
	deathsound = sfx_rs_ex2,
	painchance = 192*FRACUNIT,
	speed = 65*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}
mobjinfo[MT_RS_THROWNEXPLOSION].name = "Explosion Ring"

mobjinfo[MT_RS_RAILSHOT] = {
	spawnstate = S_RRNG1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_die,
	speed = 128*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}
mobjinfo[MT_RS_RAILSHOT].name = "Rail Ring"

mobjinfo[MT_RS_THROWNSEEKER] = {
	spawnstate = S_RS_THROWNSEEKER1,
	deathstate = S_RINGEXPLODE,
	deathsound = sfx_cdfm14,
	painchance = 128*FRACUNIT,
	speed = 35*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
mobjinfo[MT_RS_THROWNSEEKER].name = "Seeker Ring"
mobjinfo[MT_RS_THROWNSEEKER].rocketforce = 8

states[S_RS_THROWNSEEKER1] = {
	nextstate = S_RS_THROWNSEEKER2,
	sprite = SPR_THER,
	frame = FF_FULLBRIGHT,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSEEKER2] = {
	nextstate = S_RS_THROWNSEEKER3,
	sprite = SPR_THER,
	frame = FF_FULLBRIGHT|1,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSEEKER3] = {
	nextstate = S_RS_THROWNSEEKER4,
	sprite = SPR_THER,
	frame = FF_FULLBRIGHT|2,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSEEKER4] = {
	nextstate = S_RS_THROWNSEEKER5,
	sprite = SPR_THER,
	frame = FF_FULLBRIGHT|3,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSEEKER5] = {
	nextstate = S_RS_THROWNSEEKER6,
	sprite = SPR_THER,
	frame = FF_FULLBRIGHT|4,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSEEKER6] = {
	nextstate = S_RS_THROWNSEEKER7,
	sprite = SPR_THER,
	frame = FF_FULLBRIGHT|5,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSEEKER7] = {
	nextstate = S_RS_THROWNSEEKER1,
	sprite = SPR_THER,
	frame = FF_FULLBRIGHT|6,
	tics = 1,
	action = A_ThrownRing
}

local A_SplashBoom = function(mo)
	for j = 1, 3
		local amtbubbles = 8 * j
		for i = 0, amtbubbles
			local fa = i*(ANGLE_180/amtbubbles)*2
			local mobj = P_SpawnMobjFromMobj(mo,0,0,0,MT_RS_SPLASH_AOE)
			if mobj and mobj.valid
				mobj.destscale = mobj.scale * 2
				mobj.sprite = SPR_BUBL
				mobj.frame = $ + (B | FF_FULLBRIGHT)
				mobj.target = mo.target
				mobj.fuse = 15 + (j * 2) + (i % 2)
				mobj.tics = mobj.fuse
				mobj.color = mo.color
				mobj.colorized = true
				if (mo.pierce)
					mobj.pierce = true
				end
				mobj.momz = FixedMul(sin(fa),mo.scale * (5 * j))
				P_InstaThrust(mobj, mo.angle+ANGLE_90,FixedMul(cos(fa),mo.scale * (5 * j)))
			end
		end
	end
	RingSlinger.RocketForce(mo, 6)
end
states[S_RS_THROWNSPLASH1] = {
	nextstate = S_RS_THROWNSPLASH2,
	sprite = SPR_RNGP,
	frame = FF_FULLBRIGHT,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSPLASH2] = {
	nextstate = S_RS_THROWNSPLASH1,
	sprite = SPR_RNGP,
	frame = FF_FULLBRIGHT|1,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_SPLASHBOOM] = {
	nextstate = S_SPRK1,
	tics = 0,
	action = A_SplashBoom
}
mobjinfo[MT_RS_THROWNSPLASH] = {
	spawnstate = S_RS_THROWNSPLASH1,
	deathstate = S_RS_SPLASHBOOM,
	deathsound = sfx_rs_sp2,
	speed = 90*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
mobjinfo[MT_RS_THROWNSPLASH].name = "Splash Ring"

mobjinfo[MT_RS_SPLASH_AOE] = {
	spawnstate = S_THOK,
	radius = 12*FRACUNIT,
	height = 24*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}
mobjinfo[MT_RS_SPLASH_AOE].name = "Splash Ring"

mobjinfo[MT_RS_THROWNACCEL] = {
	spawnstate = S_RS_THROWNACCEL1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_di2,
	speed = 12*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
mobjinfo[MT_RS_THROWNACCEL].name = "Accel Ring"

states[S_RS_THROWNACCEL1] = {
	nextstate = S_RS_THROWNACCEL2,
	sprite = SPR_RNGC,
	frame = FF_FULLBRIGHT,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNACCEL2] = {
	nextstate = S_RS_THROWNACCEL3,
	sprite = SPR_RNGC,
	frame = FF_FULLBRIGHT|1,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNACCEL3] = {
	nextstate = S_RS_THROWNACCEL4,
	sprite = SPR_RNGC,
	frame = FF_FULLBRIGHT|2,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNACCEL4] = {
	nextstate = S_RS_THROWNACCEL1,
	sprite = SPR_RNGC,
	frame = FF_FULLBRIGHT|3,
	tics = 1,
	action = A_ThrownRing
}

mobjinfo[MT_RS_THROWNWAVE] = {
	spawnstate = S_RS_THROWNWAVE,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_di2,
	speed = 50*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
mobjinfo[MT_RS_THROWNWAVE].name = "Wave Ring"

states[S_RS_THROWNWAVE] = {
	nextstate = S_RS_THROWNWAVE,
	sprite = SPR_RNGW,
	frame = FF_FULLBRIGHT,
	tics = 1,
	action = A_ThrownRing
}

local A_StoneBreak = function(mo)
	for i = -2, 2
		local ang = i * ANG1 * 22
		local mobj = P_SpawnMobjFromMobj(mo,0,0,0,MT_RS_STONEDEBRIS)
		if mobj and mobj.valid
			mobj.target = mo.target
			mobj.color = mo.color
			mobj.scale = $ * 6/5
			mobj.shadowscale = FRACUNIT
			if (mo.pierce)
				mobj.pierce = true
			end
			P_InstaThrust(mobj, mo.angle+ang, FixedMul(mobj.info.speed,mo.scale))
			local momz = 5*FRACUNIT
			if (mo.eflags & MFE_UNDERWATER)
				momz = $ * 2/3
			end
			P_SetObjectMomZ(mobj, momz, true)
			if i == 0
				S_StartSound(mobj, sfx_s3k59)
			end
		end
	end
end

mobjinfo[MT_RS_THROWNSTONE] = {
	spawnstate = S_RS_THROWNSTONE1,
	deathstate = S_RS_STONEBREAK,
	speed = 48*FRACUNIT,
	radius = 32*FRACUNIT,
	height = 64*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE
}
mobjinfo[MT_RS_THROWNSTONE].name = "Stone Ring"

states[S_RS_STONEBREAK] = {
	tics = 0,
	action = A_StoneBreak
}
states[S_RS_THROWNSTONE1] = {
	nextstate = S_RS_THROWNSTONE2,
	sprite = SPR_RNGK,
	frame = FF_FULLBRIGHT,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSTONE2] = {
	nextstate = S_RS_THROWNSTONE3,
	sprite = SPR_RNGK,
	frame = FF_FULLBRIGHT|1,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSTONE3] = {
	nextstate = S_RS_THROWNSTONE4,
	sprite = SPR_RNGK,
	frame = FF_FULLBRIGHT|2,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNSTONE4] = {
	nextstate = S_RS_THROWNSTONE1,
	sprite = SPR_RNGK,
	frame = FF_FULLBRIGHT|3,
	tics = 1,
	action = A_ThrownRing
}

mobjinfo[MT_RS_STONEDEBRIS] = {
	spawnstate = S_RS_STONEDEBRIS,
	speed = 20*FRACUNIT,
	radius = 12*FRACUNIT,
	height = 24*FRACUNIT,
	flags = MF_MISSILE|MF_BOUNCE|MF_GRENADEBOUNCE
}
mobjinfo[MT_RS_STONEDEBRIS].name = "Stone Ring"

states[S_RS_STONEDEBRIS] = {
	sprite = SPR_ROIQ,
	frame = FF_FULLBRIGHT|FF_ANIMATE,
	var1 = 7,
	var2 = 2,
	tics = 35
}

local A_FlashBurst = function(mo)
	local vfxscale = FixedMul(mo.info.painchance / 192, mo.scale)
	local vfx = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SPINDUST)
	if vfx.valid
		vfx.scale = vfxscale
		vfx.destscale = vfx.scale * 2
		vfx.frame = $ | FF_FULLBRIGHT
		vfx.color = SKINCOLOR_WHITE
		vfx.colorized = true
		vfx.state = S_NEWBOOM
		P_SetObjectMomZ(vfx, -vfx.scale, false)
	end
	
	for i = 0, 4
		local dust = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_TNTDUST)
		if dust.valid
			if i == 0
				S_StartSound(dust, sfx_s3k45)
			end
			local angle = P_RandomRange(0, 359) * ANG1
			dust.angle = angle
			dust.scale = $ / 3
			dust.destscale = dust.scale * 3
			dust.scalespeed = dust.scale / 24
			P_Thrust(dust, angle, 15 * FixedMul(P_RandomFixed(), dust.scale))
			dust.momz = P_SignedRandom()*dust.scale/64
		end
	end
	
	/*for i = 0, 20
		local smoke = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SMOKE)
		local angle = P_RandomRange(0, 359) * ANG1
		smoke.color = SKINCOLOR_WHITE
		smoke.colorized = true
		P_InstaThrust(smoke, angle, 10 * smoke.scale)
		smoke.momz = P_RandomRange(-10, 10) * smoke.scale
	end*/

	local maxdist = FixedMul(mo.info.painchance, mo.scale)
	local thok = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_THOK)
	thok.radius = maxdist
	searchBlockmap("objects", function(refmobj, foundmobj)
		if foundmobj == refmobj return end
		if not (foundmobj and foundmobj.valid) return end
		if not (foundmobj.flags & MF_SHOOTABLE) return end
		local dist = P_AproxDistance(P_AproxDistance(foundmobj.x - refmobj.x, foundmobj.y - refmobj.y), foundmobj.z - refmobj.z)
		if (dist > maxdist)
			return
		end
		P_DamageMobj(foundmobj, mo, mo.target, 1, 0)
	end, thok)
	P_RemoveMobj(thok)
end

mobjinfo[MT_RS_FLASHSHOT] = {
	spawnstate = S_RRNG1,
	deathstate = S_RS_FLASHBURST,
	deathsound = sfx_rs_die,
	speed = 43*FRACUNIT,
	radius = 6*FRACUNIT,
	height = 12*FRACUNIT,
	painchance = 165*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE,
}
states[S_RS_FLASHBURST] = {
	tics = 0,
	action = A_FlashBurst
}

mobjinfo[MT_RS_THROWNBURST] = {
	spawnstate = S_RS_THROWNBURST1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_di2,
	speed = 60*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE
}
mobjinfo[MT_RS_THROWNBURST].name = "Burst Ring"

states[S_RS_THROWNBURST1] = {
	nextstate = S_RS_THROWNBURST2,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNBURST2] = {
	nextstate = S_RS_THROWNBURST3,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT|1,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNBURST3] = {
	nextstate = S_RS_THROWNBURST4,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT|2,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNBURST4] = {
	nextstate = S_RS_THROWNBURST5,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT|3,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNBURST5] = {
	nextstate = S_RS_THROWNBURST6,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT|4,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNBURST6] = {
	nextstate = S_RS_THROWNBURST7,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT|5,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNBURST7] = {
	nextstate = S_RS_THROWNBURST8,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT|6,
	tics = 1,
	action = A_ThrownRing
}
states[S_RS_THROWNBURST8] = {
	nextstate = S_RS_THROWNBURST1,
	sprite = SPR_RNGT,
	frame = FF_FULLBRIGHT|7,
	tics = 1,
	action = A_ThrownRing
}

mobjinfo[MT_RS_THROWNFLAME] = {
	spawnstate = S_RS_THROWNFLAME1,
	deathstate = S_SPRK1,
	deathsound = sfx_s3k7e,
	speed = 80*FRACUNIT,
	radius = 24*FRACUNIT,
	height = 48*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY|MF_SLIDEME
}
mobjinfo[MT_RS_THROWNFLAME].name = "Flame Ring"

states[S_RS_THROWNFLAME1] = {
	nextstate = S_RS_THROWNFLAME2,
	sprite = SPR_RNGF,
	frame = FF_FULLBRIGHT|FF_TRANS50|1,
	tics = 10
}
states[S_RS_THROWNFLAME2] = {
	nextstate = S_RS_THROWNFLAME3,
	sprite = SPR_RNGF,
	frame = FF_FULLBRIGHT|FF_TRANS40|2,
	tics = 10
}
states[S_RS_THROWNFLAME3] = {
	frame = FF_FULLBRIGHT|FF_TRANS30|3,
	tics = 20
}

//THIS MOBJ SHOULD BE THE LAST ONE, BECAUSE OF THE LOOP IN WEAPONHOOKS
mobjinfo[MT_RS_THROWNINFINITY] = {
	spawnstate = S_THROWNINFINITY1,
	deathstate = S_SPRK1,
	deathsound = sfx_rs_die,
	speed = 65*FRACUNIT,
	radius = 16*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY
}
mobjinfo[MT_RS_THROWNINFINITY].name = "Infinity Ring"