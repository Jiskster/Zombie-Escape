local RS = RingSlinger

local consoleplayer_camera = nil
local function getcam(v, player, camera)
    consoleplayer_camera = camera
end
hud.add(getcam, "game")

addHook("MobjThinker", function(mo)
	if not (mo.target and mo.target.valid and mo.target.player and mo.target.player.playerstate == PST_LIVE and mo.target.ringslinger and mo.target.ringslinger.powers[RSPOWER_PROTECTION])
		P_RemoveMobj(mo)
		return
	end
	mo.spin = $ + ANG2 + mo.target.player.speed * 10
	mo.angle = mo.spin + mo.target.angle
	mo.scale = mo.target.scale
	local ang = mo.angle + ANGLE_90
	P_TeleportMove(mo, mo.target.x + FixedMul(cos(ang), mo.scale * 30), mo.target.y + FixedMul(sin(ang), mo.scale * 30), mo.target.z + mo.target.height/2)
	
	if mo.target.player == consoleplayer and consoleplayer_camera and (consoleplayer_camera.chase == false)
		mo.flags2 = $ | MF2_DONTDRAW
	else
		mo.flags2 = $ & ~MF2_DONTDRAW
	end
end, MT_RS_PROTECTION)

addHook("TouchSpecial", function(special, mo)
	if not (mo.ringslinger and special.power)
		return true
	end
	//S_StartSoundAtVolume(nil, sfx_rs_rng, 120, mo.player)
	S_StartSoundAtVolume(mo, sfx_rs_itm, 180)
	S_StartSound(special, sfx_s3k76)
	P_SpawnMobjFromMobj(special, 0, 0, 0, MT_SUPERSPARK)
	
	mo.ringslinger.powers[special.power] = 25 * TICRATE * FRACUNIT
	if RS.Powers[special.power].func
		RS.Powers[special.power].func(mo)
	end
	
	if (special.icon and special.icon.valid)
		P_KillMobj(special.icon)
	end
	if special.parent and special.parent.valid
		P_KillMobj(special.parent)
	end
end, MT_RS_POWERUP)

addHook("MobjThinker", function(mo)
	mo.angle = $ + ANG1*8
	if leveltime % 2
		P_SpawnGhostMobj(mo)
	end
	local icon = mo.icon
	if icon and icon.valid
		P_TeleportMove(icon, mo.x, mo.y, mo.z)
		icon.spriteyoffset = sin(leveltime * ANG1*5) * 2
	end
end, MT_RS_POWERUP)

local makepowerup = function(mo)
	local p = P_SpawnMobjFromMobj(mo, 0, 0, 0, MT_RS_POWERUP)
	if p and p.valid
		p.power = 1 + ((mo.type - MT_BOUNCEPICKUP) % #RS.Powers)
		local power = RS.Powers[p.power]
		p.parent = mo
		local icon = P_SpawnMobjFromMobj(p, 0, 0, 0, MT_THOK)
		if icon and icon.valid
			p.icon = icon
			icon.sprite = SPR_RSPU
			icon.frame = power.frame
			icon.tics = -1
			icon.color = power.color
		end
	end
	mo.flags = $ & ~MF_SPECIAL
	mo.flags2 = $ | MF2_DONTDRAW
end

for i = MT_BOUNCEPICKUP, MT_GRENADEPICKUP
	addHook("MobjSpawn", makepowerup, i)
end