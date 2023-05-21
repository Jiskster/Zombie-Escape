local rs_loaded = false

freeslot(
"MT_RS_ZCLAWS",
"MT_RS_HS_SHOT",
"MT_RS_FIST",
"SFX_CLWM",
"SFX_CLWH",
"SFX_RCHT1",
"SFX_PSL1"
)
mobjinfo[MT_RS_ZCLAWS] = {
	spawnstate = S_RRNG1,
	deathstate = S_SPRK1,
	deathsound = sfx_clwm,
	speed = 32*FRACUNIT,
	radius = 32*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}

mobjinfo[MT_RS_FIST] = {
	spawnstate = S_RRNG1,
	deathstate = S_SPRK1,
	deathsound = sfx_clwm,
	speed = 32*FRACUNIT,
	radius = 32*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}

mobjinfo[MT_RS_HS_SHOT] = {
	spawnstate = S_RRNG1,
	deathstate = S_SPRK1,
	deathsound = sfx_rcht1,
	speed = 128*FRACUNIT,
	radius = 24*FRACUNIT,
	height = 32*FRACUNIT,
	flags = MF_NOBLOCKMAP|MF_MISSILE|MF_NOGRAVITY,
}

local claws_ring = function(x,y,z,scale,angle)
	local th = P_SpawnMobj(x, y, z, MT_THOK)
	if th and th.valid
		th.angle = angle + ANGLE_90
		th.spriteyoffset = -20*FRACUNIT
		th.sprite = SPR_BARX
		th.frame = FF_PAPERSPRITE|TR_TRANS90
		th.color = SKINCOLOR_RED
		th.blendmode = AST_ADD
		th.colorized = true
		th.scale = scale
		th.destscale = th.scale*6
		th.scalespeed = $ * 2
		th.tics = 3
	end
end

local fist_ring = function(x,y,z,scale,angle)
	local th = P_SpawnMobj(x, y, z, MT_THOK)
	if th and th.valid
		th.angle = angle + ANGLE_90
		th.spriteyoffset = -20*FRACUNIT
		th.sprite = SPR_BARX
		th.frame = FF_PAPERSPRITE|TR_TRANS90
		th.color = SKINCOLOR_RED
		th.blendmode = AST_ADD
		th.colorized = true
		th.scale = scale
		th.destscale = th.scale*6
		th.scalespeed = $ * 2
		th.tics = 3
	end
end

local pistol_ring = function(x,y,z,scale,angle)
	local th = P_SpawnMobj(x, y, z, MT_THOK)
	if th and th.valid
		th.angle = angle + ANGLE_90
		th.spriteyoffset = -20*FRACUNIT
		th.sprite = SPR_BARX
		th.blendmode = AST_ADD
		th.scale = scale
		th.destscale = th.scale*3/256
		th.scalespeed = $ * 2
		th.tics = 8
	end
end

addHook("ThinkFrame", do
	if RingSlinger and not rs_loaded
		rs_loaded = true;
		RingSlinger.Skins["milne"] = {
			ammo = 30,
			weapons = {RSWPN_SCATTER, RSWPN_BURST}
		}
		RingSlinger.Skins["w"] = {
			ammo = 55,
			weapons = {RSWPN_SPLASH, RSWPN_INFINITY}
		}
		RingSlinger.Skins["bob"] = {
			ammo = 80,
			weapons = {RSWPN_BOBFLASH, RSWPN_BURST}
		}
RingSlinger.AddWeapon({
	name = "Claws",
	viewsprite = "CLWSA0",
	hudsprite = "CLWSIND",
	scale = FRACUNIT*6/5,
	hold = true,
	viewoffset = 0*FRACUNIT,
	mutetoss = true,
	delay = 21,
	cost = 0,
	shake = 3,
	auto = true,
	slingfunc = function(mo, weapon)
		local player = mo.player
		S_StartSound(mo, sfx_clwh)
		S_StartSoundAtVolume(mo, sfx_cdfm16, 60)
		local claws = P_SPMAngle(mo, MT_RS_ZCLAWS, mo.angle, 1, MF2_DONTDRAW)
		
		if claws and claws.valid
			local range = 2
			if mo.ringslinger.powers[RSPOWER_POWERTOSS]
				range = $ * 3/2
			end
			if mo.ringslinger.powers[RSPOWER_PIERCE]
				claws.pierce = true
			end
			for i = 0, range
					if (i - 2) % 10 == 0
						claws_ring(claws.x,claws.y,claws.z,claws.scale/2,claws.angle)
					end
				
				local prevx = claws.x
				local prevy = claws.y
				local prevz = claws.z
				
				if claws.momx or claws.momy
					P_XYMovement(claws)
					if not claws.valid
						break
					end
				end
				if claws.momz
					P_ZMovement(claws)
					if not claws.valid
						break
					end
				end
				
				if (not claws.valid) or (xx == claws.x and y == claws.y and z == claws.z)
					break
				end
			end
			if claws and claws.valid
				claws_ring(claws.x,claws.y,claws.z,claws.scale,claws.angle)
				P_KillMobj(claws)
			end
		end
		
		return true
	end
})

RingSlinger.Skins["dzombie"] = {
	ammo = 1,
	weapons = {RSWPN_CLAWS, RSWPN_ZMELEE}
}

RingSlinger.AddWeapon({
	name = "Pistol",
	hudsprite = "PGUNIND",
	viewsprite = "PGUNA0",
	hold = true,
	delay = 12,
	cost = 7,
	auto = true,
	shake = 0,
	scale = FRACUNIT*6/12,
	viewoffset = 0*FRACUNIT,
	mutetoss = true,
	slingfunc = function(mo, weapon)
		local player = mo.player
		S_StartSound(mo, sfx_psl1)
		S_StartSoundAtVolume(mo, sfx_cdfm16, 60)
		local pistol = P_SPMAngle(mo, MT_RS_HS_SHOT, mo.angle, 1, MF2_DONTDRAW)
		
		if pistol and pistol.valid
			local range = 32
			if mo.ringslinger.powers[RSPOWER_POWERTOSS]
				range = $ * 3/2
			end
			if mo.ringslinger.powers[RSPOWER_PIERCE]
				pistol.pierce = true
			end
			for i = 0, range
				
				local prevx = pistol.x
				local prevy = pistol.y
				local prevz = pistol.z
				
				if pistol.momx or pistol.momy
					P_XYMovement(pistol)
					if not pistol.valid
						break
					end
				end
				if pistol.momz
					P_ZMovement(pistol)
					if not pistol.valid
						break
					end
				end
				
				if (not pistol.valid) or (xx == pistol.x and y == pistol.y and z == pistol.z)
					break
				end
			end
			if pistol and pistol.valid
				pistol_ring(pistol.x,pistol.y,pistol.z,pistol.scale,pistol.angle)
				P_KillMobj(pistol)
			end
		end
		
		return true
	end
})

RingSlinger.Skins["revenger"] = {
	ammo = 65,
	weapons = {RSWPN_PISTOL, RSWPN_SCATTER}
}

RingSlinger.AddWeapon({
	name = "Fist",
	viewsprite = "FSTSA0",
	hudsprite = "FSTSIND",
	scale = FRACUNIT*6/5,
	hold = true,
	viewoffset = 0*FRACUNIT,
	mutetoss = true,
	delay = 64,
	cost = 0,
	shake = 3,
	auto = true,
	slingfunc = function(mo, weapon)
		local player = mo.player
		S_StartSound(mo, sfx_clwh)
		S_StartSoundAtVolume(mo, sfx_cdfm16, 60)
		local fist = P_SPMAngle(mo, MT_RS_FIST, mo.angle, 1, MF2_DONTDRAW)
		
		if fist and fist.valid
			local range = 2
			if mo.ringslinger.powers[RSPOWER_POWERTOSS]
				range = $ * 3/2
			end
			if mo.ringslinger.powers[RSPOWER_PIERCE]
				fist.pierce = true
			end
			for i = 0, range
					if (i - 2) % 10 == 0
						fist_ring(fist.x,fist.y,fist.z,fist.scale/2,fist.angle)
					end
				
				local prevx = fist.x
				local prevy = fist.y
				local prevz = fist.z
				
				if fist.momx or fist.momy
					P_XYMovement(fist)
					if not fist.valid
						break
					end
				end
				if fist.momz
					P_ZMovement(fist)
					if not fist.valid
						break
					end
				end
				
				if (not fist.valid) or (xx == fist.x and y == fist.y and z == fist.z)
					break
				end
			end
			if fist and fist.valid
				fist_ring(fist.x,fist.y,fist.z,fist.scale,fist.angle)
				P_KillMobj(fist)
			end
		end
		
		return true
	end
})
	end
end)