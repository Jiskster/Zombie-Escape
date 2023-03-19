freeslot("S_NEWBOOM")
states[S_NEWBOOM] = {SPR_BARX, FF_ANIMATE|FF_TRANS50|A, 9, nil, 3, 3, S_NULL}

function A_RingExplode(mo)
	mo.flags2 = $ | MF2_DEBRIS--idk what this does actually
	
	S_StartSound(mo, sfx_prloop)
	local vfxscale = FixedMul(mo.info.painchance / 192, mo.scale)
	local vfx = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SPINDUST)
	if vfx.valid
		vfx.scale = vfxscale
		vfx.destscale = vfx.scale * 2
		vfx.colorized = true
		vfx.color = SKINCOLOR_WHITE
		vfx.state = S_NEWBOOM
		P_SetObjectMomZ(vfx, -2*vfx.scale, false)
	end
	vfx = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SPINDUST)
	if vfx.valid
		vfx.scale = vfxscale / 2
		vfx.destscale = vfx.scale
		vfx.colorized = true
		vfx.color = mo.color
		vfx.state = S_NEWBOOM
		P_SetObjectMomZ(vfx, -vfx.scale, false)
	end
	
	for i = 0, 16
		local s = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_BOXSPARKLE)
		s.state = S_BOXSPARKLE2
		P_Thrust(s, P_RandomRange(0, 359)*ANG1, P_RandomRange(0, 20) * vfxscale)
		s.momz = P_RandomRange(-20, 20) * vfxscale
		s.blendmode = AST_ADD
	end
	
	for i = 0, 20
		local s = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_SPINDUST)
		s.state = S_BOXSPARKLE3
		P_Thrust(s, P_RandomRange(0, 359)*ANG1, 60 * vfxscale)
		s.blendmode = AST_ADD
		s.destscale = $ * 2
	end
	
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
		if (foundmobj == mo.target)
			local diffx = foundmobj.x - mo.x
			local diffy = foundmobj.y - mo.y
			local diffz = (foundmobj.z + foundmobj.height/2) - mo.z
			local distxy = R_PointToDist2(0, 0, diffx, diffy)
			local xyang = R_PointToAngle2(0, 0, diffx, diffy)
			local zang = R_PointToAngle2(0, 0, distxy, diffz)
			local dist = R_PointToDist2(0, 0, distxy, diffz)
			S_StartSound(foundmobj, sfx_rs_rj)
			local force = FixedMul(mo.scale, min(FRACUNIT, FRACUNIT*8/7 - (dist/192))) * (mo.info.rocketforce or 20)
			local thrustxy = P_ReturnThrustX(nil, zang, force)
			local thrustz = P_ReturnThrustY(nil, zang, force) * 3/12
			P_Thrust(foundmobj, xyang, thrustxy)
			foundmobj.momz = $ + thrustz
		end
		P_DamageMobj(foundmobj, mo, mo.target, 1, 0)
	end, thok)
	P_RemoveMobj(thok)
	
	return true
end