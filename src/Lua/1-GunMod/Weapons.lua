local RS = RingSlinger

RS.AddWeapon({
	name = "Normal",
	hudsprite = "RINGIND",
	viewsprite = "TRNGD0V0",
	viewoffset = 5*FRACUNIT,
	delay = 12,
	cost = 1
})
RS.AddWeapon({
	name = "Automatic",
	viewsprite = "RNGAD0",
	hudsprite = "AUTOIND",
	mt = MT_RS_THROWNAUTOMATIC,
	sound = sfx_rs_aut,
	scale = FRACUNIT * 5/6,
	viewoffset = -15*FRACUNIT,
	auto = true,
	delay = 4,
	cost = 1,
	shake = 1
})
RS.AddWeapon({
	name = "Bounce",
	viewsprite = "RNGBD0",
	hudsprite = "BNCEIND",
	mt = MT_RS_THROWNBOUNCE,
	sound = sfx_rs_bou,
	scale = FRACUNIT * 3/2,
	viewoffset = 10*FRACUNIT,
	fuse = TICRATE * 2,
	delay = 18,
	cost = 4
})
RS.AddWeapon({
	name = "Scatter",
	viewsprite = "RNGSD0",
	hudsprite = "SCATIND",
	mt = MT_RS_THROWNSCATTER,
	fuse = 25,
	delay = 25,
	cost = 6,
	shake = 2,
	slingfunc = function(mo, weapon)
		local player = mo.player
		local mt = weapon.mt
		local spread = 4
		S_StartSound(mo, sfx_shgn)
		for i = -1, 1
			local shot = P_SPMAngle(mo, mt, mo.angle + i * ANG1*spread, 1, 0)
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		for i = -1, 1, 2
			local prevaim = player.aiming
			player.aiming = $ + i * ANG1*spread
			local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
			player.aiming = prevaim
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		if not P_IsObjectOnGround(mo)
			local aim = max(-FRACUNIT, min(FRACUNIT, -player.aiming/13000))
			if P_MobjFlip(mo) * aim > 0
				aim = $ * 2/8
			end
			mo.momz = $ + FixedMul(mo.scale, aim)
			P_Thrust(mo, mo.angle, -FRACUNIT*9)
		end
		return true
	end
})
RS.AddWeapon({
	name = "Grenade",
	viewsprite = "RNGGD0",
	hudsprite = "GRENIND",
	mt = MT_RS_THROWNGRENADE,
	sound = sfx_rs_gre,
	scale = FRACUNIT * 7/4,
	viewoffset = 25*FRACUNIT,
	fuse = 40,
	delay = 20,
	cost = 5,
	dropshadow = true
})
RS.AddWeapon({
	name = "Explosion",
	viewsprite = "RNGED0",
	hudsprite = "BOMBIND",
	mt = MT_RS_THROWNEXPLOSION,
	flags2 = MF2_EXPLOSION,
	sound = sfx_rs_exp,
	delay = 31,
	shake = 2,
	cost = 6
})

local ring = function(x,y,z,scale,angle)
	local th = P_SpawnMobj(x, y, z, MT_THOK)
	if th and th.valid
		th.angle = angle + ANGLE_90
		th.spriteyoffset = -20*FRACUNIT
		th.sprite = SPR_STAB
		th.frame = FF_PAPERSPRITE|TR_TRANS80
		th.color = SKINCOLOR_WHITE
		th.blendmode = AST_ADD
		th.colorized = true
		th.scale = scale
		th.destscale = th.scale*6
		th.scalespeed = $ * 2
		th.tics = 6
	end
end
RS.AddWeapon({
	name = "Rail",
	viewsprite = "RNGRD0",
	hudsprite = "RAILIND",
	scale = FRACUNIT*6/5,
	delay = 64,
	cost = 10,
	shake = 10,
	slingfunc = function(mo, weapon)
		local player = mo.player
		S_StartSound(mo, sfx_rail1)
		S_StartSoundAtVolume(mo, sfx_cdfm16, 60)
		local rail = P_SPMAngle(mo, MT_RS_RAILSHOT, mo.angle, 1, MF2_DONTDRAW)
		
		if rail and rail.valid
			local range = 28
			if mo.ringslinger.powers[RSPOWER_POWERTOSS]
				range = $ * 3/2
			end
			if mo.ringslinger.powers[RSPOWER_PIERCE]
				rail.pierce = true
			end
			for i = 0, range
				if i % 2 == 0
					local spark = P_SpawnMobj(rail.x, rail.y, rail.z, MT_SPARK)
					if spark and spark.valid
						if i % 3 == 0
							spark.color = player.skincolor
							spark.colorized = true
						else
							spark.scale = $ * 3/4
							if mo.ringslinger.powers[RSPOWER_PIERCE]
								spark.color = SKINCOLOR_RED
								spark.colorized = true
							end
						end
					end
					if (i - 2) % 10 == 0
						ring(rail.x,rail.y,rail.z,rail.scale/2,rail.angle)
					end
				end
				
				local prevx = rail.x
				local prevy = rail.y
				local prevz = rail.z
				
				if rail.momx or rail.momy
					P_XYMovement(rail)
					if not rail.valid
						break
					end
				end
				if rail.momz
					P_ZMovement(rail)
					if not rail.valid
						break
					end
				end
				
				if (not rail.valid) or (xx == rail.x and y == rail.y and z == rail.z)
					break
				end
			end
			if rail and rail.valid
				ring(rail.x,rail.y,rail.z,rail.scale,rail.angle)
				S_StartSound(rail, sfx_rail2)
				P_KillMobj(rail)
			end
		end
		
		return true
	end
})
RS.AddWeapon({
	name = "Seeker",
	viewsprite = "RNGMW0",
	hudsprite = "HOMNIND",
	mt = MT_RS_THROWNSEEKER,
	fuse = TICRATE * 2,
	scale = FRACUNIT * 6/5,
	viewoffset = 10*FRACUNIT,
	delay = 8,
	cost = 10,
	slingfunc = function(mo, weapon)
		local player = mo.player
		local mt = weapon.mt
		S_StartSound(mo, sfx_rs_hom)
		local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
		if shot and shot.valid
			shot.color = player.skincolor
			if mo.ringslinger.powers[RSPOWER_POWERTOSS]
				shot.momx = $ * 3/2
				shot.momy = $ * 3/2
				shot.momz = $ * 3/2
			end
			if mo.ringslinger.powers[RSPOWER_PIERCE]
				shot.pierce = true
			end
			shot.aimingstart = player.aiming
		end
		
		return true
	end
})
RS.AddWeapon({
	name = "Accel",
	viewsprite = "RNGCB0",
	hudsprite = "CROSIND",
	mt = MT_RS_THROWNACCEL,
	delay = 8,
	cost = 4,
	scale = FRACUNIT * 5/4,
	slingfunc = function(mo, weapon)
		local player = mo.player
		local mt = weapon.mt
		S_StartSound(mo, sfx_rs_cro)
		for j = -1, 1
			for i = 0, 2
				local shot = P_SPMAngle(mo, mt, mo.angle + ANG10 * j, 1, 0)
				if shot and shot.valid
					shot.color = player.skincolor
					shot.scale = FRACUNIT * 4/5
					if mo.ringslinger.powers[RSPOWER_POWERTOSS]
						shot.momx = $ * 3/2
						shot.momy = $ * 3/2
						shot.momz = $ * 3/2
					end
					if mo.ringslinger.powers[RSPOWER_PIERCE]
						shot.pierce = true
					end
					shot.momx = $ * (9+i)/9
					shot.momy = $ * (9+i)/9
					shot.momz = $ * (9+i)/9
				end
			end
		end
		
		return true
	end
})
RS.AddWeapon({
	name = "Splash",
	viewsprite = "RNGPA0",
	hudsprite = "SPLAIND",
	mt = MT_RS_THROWNSPLASH,
	sound = sfx_rs_spl,
	fuse = TICRATE,
	viewoffset = 6*FRACUNIT,
	delay = 22,
	cost = 6
})
RS.AddWeapon({
	name = "Stone",
	viewsprite = "RNGKA0",
	hudsprite = "STONIND",
	mt = MT_RS_THROWNSTONE,
	sound = sfx_rs_sto,
	viewoffset = 32*FRACUNIT,
	delay = 25,
	cost = 7,
	dropshadow = true
})
RS.AddWeapon({
	name = "Flash",
	viewsprite = "BLINKHUD",
	hudsprite = "BLININD",
	viewoffset = 24*FRACUNIT,
	delay = 32,
	cost = 10,
	shake = 5,
	slingfunc = function(mo, weapon)
		mo.momx = $ / 3
		mo.momy = $ / 3
		P_SetObjectMomZ(mo, 6*FRACUNIT, false)
		mo.state = S_PLAY_SPRING
		mo.player.pflags = $ & ~(PF_JUMPED | PF_SPINNING)
		
		local player = mo.player
		S_StartSound(mo, sfx_rs_vol)
		local rail = P_SPMAngle(mo, MT_RS_FLASHSHOT, mo.angle, 1, MF2_DONTDRAW)
		
		if rail and rail.valid
			local range = 16
			if mo.ringslinger.powers[RSPOWER_POWERTOSS]
				range = $ * 3/2
			end
			if mo.ringslinger.powers[RSPOWER_PIERCE]
				rail.pierce = true
			end
			for i = 0, range
				local ang = P_RandomRange(0, 359) * ANG1
				local spark = P_SpawnMobj(rail.x + sin(ang)*5, rail.y + cos(ang)*5, rail.z, MT_BOXSPARKLE)
				if spark and spark.valid
					if i % 2
						spark.color = player.skincolor
					elseif mo.ringslinger.powers[RSPOWER_PIERCE]
						spark.color = SKINCOLOR_RED
					end
					spark.colorized = true
				end
				
				local prevx = rail.x
				local prevy = rail.y
				local prevz = rail.z
				
				if rail.momx or rail.momy
					P_XYMovement(rail)
					if not rail.valid
						break
					end
				end
				if rail.momz
					P_ZMovement(rail)
					if not rail.valid
						break
					end
				end
				
				if (not rail.valid) or (xx == rail.x and y == rail.y and z == rail.z)
					break
				end
			end
			if rail and rail.valid
				P_KillMobj(rail)
			end
		end
		
		return true
	end
})
RS.AddWeapon({
	name = "Burst",
	viewsprite = "RNGTC0",
	hudsprite = "BURSIND",
	mt = MT_RS_THROWNBURST,
	sound = sfx_rs_bur,
	scale = FRACUNIT * 4/5,
	viewoffset = -12*FRACUNIT,
	burst = 5,
	burstdelay = 2,
	delay = 17,
	cost = 6,
	dropshadow = true
})
RS.AddWeapon({
	name = "Infinity",
	viewsprite = "RNGID0",
	hudsprite = "INFNIND",
	mt = MT_RS_THROWNINFINITY,
	sound = sfx_rs_inf,
	viewoffset = -2*FRACUNIT,
	scale = FRACUNIT * 6/5,
	delay = 15,
	cost = 0
})
RS.AddWeapon({
	name = "Flame",
	viewsprite = "RNGFA0",
	hudsprite = "FLAMIND",
	mt = MT_RS_THROWNFLAME,
	mutetoss = true,
	hold = true,
	scale = FRACUNIT,
	viewoffset = 15*FRACUNIT,
	auto = true,
	delay = 2,
	cost = 1,
	slingfunc = function(mo, weapon)
		local player = mo.player
		local mt = weapon.mt
		S_StartSound(mo, sfx_rs_fla)
		local wave = sin(leveltime*ANG10) * 600
		local shot = P_SPMAngle(mo, mt, mo.angle + wave, 1, 0)
		if shot and shot.valid
			shot.color = player.skincolor
			if mo.ringslinger.powers[RSPOWER_POWERTOSS]
				shot.momx = $ * 3/2
				shot.momy = $ * 3/2
				shot.momz = $ * 3/2
			end
			if mo.ringslinger.powers[RSPOWER_PIERCE]
				shot.pierce = true
			end
		end
		if not P_IsObjectOnGround(mo)
			local aim = max(-FRACUNIT, min(FRACUNIT, -player.aiming/13000))
			if P_MobjFlip(mo) * aim > 0
				aim = $ * 2/8
			end
			mo.momz = $ + FixedMul(mo.scale, aim)
			P_Thrust(mo, mo.angle, -FRACUNIT*2/3)
		end
		return true
	end
})

RS.AddWeapon({
	name = "MACHINEGUN",
	viewsprite = "RNGAD0",
	hudsprite = "AUTOIND",
	mt = MT_RS_THROWNAUTOMATIC,
	scale = FRACUNIT * 5/6,
	fuse = 15,
	delay = 3,
	cost = 3,
	shake = 3,
	auto = true,
	slingfunc = function(mo, weapon)
		local player = mo.player
		local mt = weapon.mt
		local spread = 5
		S_StartSound(mo, sfx_rs_aut)
		for i = -1, 1, 2
			local shot = P_SPMAngle(mo, mt, mo.angle + i * ANG1*spread, 1, 0)
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		for i = -1, 1, 2
			local prevaim = player.aiming
			player.aiming = $ + i * ANG1*spread
			local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
			player.aiming = prevaim
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		
		return true
	end
})

RS.AddWeapon({
	name = "AutoScatter",
	viewsprite = "RNGSD0",
	hudsprite = "SCATIND",
	mt = MT_RS_THROWNSCATTER,
	fuse = 10,
	delay = 9,
	cost = 13,
	shake = 3,
	auto = true,
	slingfunc = function(mo, weapon)
		local player = mo.player
		local mt = weapon.mt
		local spread = 8
		S_StartSound(mo, sfx_shgn)
		for i = -1, 1
			local shot = P_SPMAngle(mo, mt, mo.angle + i * ANG1*spread, 1, 0)
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		for i = -1, 1, 2
			local prevaim = player.aiming
			player.aiming = $ + i * ANG1*spread
			local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
			player.aiming = prevaim
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		
		return true
	end
})

RS.AddWeapon({
	name = "ZMelee",
	viewsprite = 0,
	hudsprite = "VOLTIND",
	mt = MT_RS_ZMELEE,
	fuse = 2,
	delay = 13,
	cost = 0,
	shake = 0,
	slingfunc = function(mo, weapon)
		local player = mo.player
		local mt = weapon.mt
		local spread = 0
		S_StartSound(mo, sfx_ish1)
		for i = -1, 1
			local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		for i = -1, 1, 2
			local prevaim = player.aiming
			player.aiming = $ + i * ANG1*spread
			local shot = P_SPMAngle(mo, mt, mo.angle, 1, 0)
			player.aiming = prevaim
			if shot and shot.valid
				shot.color = player.skincolor
				shot.lifetime = weapon.fuse
				if mo.ringslinger.powers[RSPOWER_POWERTOSS]
					shot.momx = $ * 3/2
					shot.momy = $ * 3/2
					shot.momz = $ * 3/2
				end
				if mo.ringslinger.powers[RSPOWER_PIERCE]
					shot.pierce = true
				end
				shot.momx = $ + mo.momx / 3
				shot.momy = $ + mo.momy / 3
				shot.momz = $ + mo.momz / 3
			end
		end
		
		return true
	end
})

/*RS.AddWeapon({
	name = "Wave",
	viewsprite = "RNGWA0",
	hudsprite = "WAVEIND",
	mt = MT_RS_THROWNWAVE,
	sound = sfx_rs_wav,
	delay = 20,
	cost = 8
})/*
/*RS.AddWeapon({
	name = "Mini",
	hudsprite = "MINIIND",
	viewsprite = "TRNGD0V0",
	mt = MT_RS_MINISHOT,
	viewoffset = -20*FRACUNIT,
	scale = FRACUNIT/2,
	delay = 7,
	cost = 2
})
RS.AddWeapon({
	name = "Giga",
	hudsprite = "GIGAIND",
	viewsprite = "TRNGD0V0",
	mt = MT_RS_MEGASHOT,
	viewoffset = 65*FRACUNIT,
	scale = FRACUNIT*2,
	delay = 13,
	cost = 2
})
*/
RS.AutoGenerateMax = #RS.Weapons--Do not autogenerate any weapons added by other scripts, only autogenerate RSNEO default weapons.