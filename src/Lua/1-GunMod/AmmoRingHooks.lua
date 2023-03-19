local RS = RingSlinger

addHook("TouchSpecial", function(special, mo)
	if not (mo.ringslinger and mo.player and mo.player.playerstate == PST_LIVE)
		return
	end
	
	if mo.ringslinger.ammo < mo.ringslinger.maxammo
		mo.ringslinger.ammo = mo.ringslinger.maxammo
		S_StartSoundAtVolume(special, sfx_rs_amm, 100)
		if mo.player
			S_StartSoundAtVolume(nil, sfx_rs_amm, 100, mo.player)
			S_StopSoundByID(mo, sfx_rs_rel)
		end
		if special.parent and special.parent.valid
			P_KillMobj(special.parent)
		end
		P_KillMobj(special)
	end
	return true
end, MT_RS_AMMO)
addHook("MobjThinker", function(mo)
	if leveltime % 16 == 0
		local s = P_SpawnMobjFromMobj(mo, 0, 0, (mo.height / 2) - 8*FRACUNIT, MT_BOXSPARKLE)
		P_Thrust(s, P_RandomRange(0, 359)*ANG1, P_RandomRange(0, 40) * FRACUNIT / 10)
		s.momz = P_RandomRange(-40, 40) * FRACUNIT/10
		s.blendmode = AST_ADD
		s.destscale = $ / 2
	end
end, MT_RS_AMMO)

local makeammo = function(mo)
	local r = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_RS_AMMO)
	if r and r.valid
		r.scale = $ * 4/3
		r.spriteyoffset = -4*FRACUNIT
		r.color = SKINCOLOR_SILVER
		r.parent = mo
	end
	mo.flags = $ & ~MF_SPECIAL
	mo.flags2 = $ | MF2_DONTDRAW
end

for i = MT_BOUNCERING, MT_GRENADERING
	addHook("MobjSpawn", makeammo, i)
end