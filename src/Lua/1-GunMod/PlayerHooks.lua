local RS = RingSlinger

local RELOADTIME = 4*TICRATE

RS.FireWeapon = function(mo, weapon)
	if not (weapon.mutetoss)
		S_StartSound(mo, sfx_rs_nor)
	end
	local player = mo.player
	local mt = MT_RS_SHOT
	if weapon.mt
		mt = weapon.mt
	end
	
	if weapon.sound
		S_StartSound(mo, weapon.sound)
	end
	local shake = 0
	if weapon.shake
		shake = weapon.shake
	end
	if mo.ringslinger.powers[RSPOWER_POWERTOSS]
		shake = $ + 1
		S_StartSoundAtVolume(mo, sfx_kc68, 90)
	end
	if mo.ringslinger.powers[RSPOWER_RAPIDFIRE]
		S_StartSoundAtVolume(mo, sfx_kc4c, 60)
	end
	if mo.ringslinger.powers[RSPOWER_PIERCE]
		shake = $ + 2
		S_StartSoundAtVolume(mo, sfx_cdfm14, 100)
	end
	if shake
		if splitscreen or player == displayplayer
			P_StartQuake(shake * FRACUNIT, min(5, shake + 2))
		end
	end
	if weapon.slingfunc and weapon.slingfunc(mo, weapon)
		return
	end
	local shot = P_SPMAngle(mo, mt, mo.angle, 1, weapon.flags2)
	if shot and shot.valid
		if mo.ringslinger.powers[RSPOWER_POWERTOSS]
			shot.momx = $ * 3/2
			shot.momy = $ * 3/2
			shot.momz = $ * 3/2
		end
		if mo.ringslinger.powers[RSPOWER_PIERCE]
			shot.pierce = true
		end
		if weapon.flags2
			shot.flags2 = $ | weapon.flags2
		end
		if weapon.dropshadow
			shot.shadowscale = FRACUNIT * 4/5
		end
		shot.color = player.skincolor
		if weapon.scale
			shot.scale = FixedMul(weapon.scale, mo.scale)
		end
		if weapon.fuse
			shot.lifetime = weapon.fuse
		end
	end
end

RS.DoReload = function(mo)
	local player = mo.player
	player.rings = max(0, $ - 20)
	mo.ringslinger.ammo = 0
	mo.ringslinger.reloadcosthud = TICRATE/2
	mo.ringslinger.reload = FRACUNIT
	S_StartSound(mo, sfx_rs_rel)
	S_StartSound(mo, sfx_antiri)
end

RS.GetOffhandCost = function(cost)
	if cost != 0
		cost = $ + max(1, $ / 3)
	end
	return cost
end

RS.GetOffhandDelay = function(delay)
	if delay != 0
		delay = $ + max(1, $ / 4)
	end
	return delay
end

RS.TryFireWeapon = function(mo, force)
	local player = mo.player
	local pbtn = player.rs_prevbuttons
	local btn = player.rs_buttons
	local weapon = RS.Weapons[mo.ringslinger.loadout[mo.ringslinger.wepslot]]
	local firebutton = force or ((not force) and ((btn & BT_ATTACK) and (weapon.auto or not (pbtn & BT_ATTACK))))
	local delay = weapon.delay
	local cost
	if weapon.cost != nil
		cost = weapon.cost
	else
		cost = 1
	end
	
	if mo.ringslinger.infinity
		cost = 0
	end
	
	if mo.ringslinger.weapondelay
		if firebutton and weapon.hold and mo.ringslinger.weapondelay < 3
			mo.ringslinger.bobx = -100*FRACUNIT
			mo.ringslinger.boby = -25*FRACUNIT
		end
		return false
	end
	
	if (not firebutton)
		return false
	end
	
	if mo.ringslinger.reload
		if not (pbtn & BT_ATTACK)
			S_StartSoundAtVolume(nil, sfx_kc44, 140, player)
		end
		return false
	end
	
	--Offhand penalty
	if mo.ringslinger.wepslot != 1
		cost = RS.GetOffhandCost($)
		delay = RS.GetOffhandDelay($)
	end
	
	--Rapid fire bonus
	if mo.ringslinger.powers[RSPOWER_RAPIDFIRE]
		delay = max(1, $ - max(1, $ / 3))
	end
	
	RS.FireWeapon(mo, weapon)
	
	--Ammo and delay
	if weapon.burst
		if mo.ringslinger.burst == 0
			mo.ringslinger.burst = weapon.burst
			mo.ringslinger.ammo = max(0, $ - cost)
			mo.ringslinger.lostrings = cost
			mo.ringslinger.lostringstimer = 18
			if mo.ringslinger.wepslot == 1
				mo.ringslinger.lostringsxoff = -10
			else
				mo.ringslinger.lostringsxoff = 10
			end
		end
		mo.ringslinger.burst = $ - 1
		if mo.ringslinger.burst == 0
			mo.ringslinger.weapondelay = delay
			if mo.ringslinger.ammo <= 0
				RS.DoReload(mo)
			end
		else
			local bd = weapon.burstdelay
			if (mo.ringslinger.wepslot == 2)
				bd = RS.GetOffhandDelay($)
			end
			mo.ringslinger.burstdelay = bd
		end
	else
		mo.ringslinger.ammo = max(0, $ - cost)
		mo.ringslinger.lostrings = cost
		mo.ringslinger.lostringstimer = 18
		if mo.ringslinger.wepslot == 1
			mo.ringslinger.lostringsxoff = -10
		else
			mo.ringslinger.lostringsxoff = 10
		end
		mo.ringslinger.weapondelay = delay
		
		if mo.ringslinger.ammo <= 0 and not weapon.burst
			RS.DoReload(mo)
		end
	end
	
	if (weapon.hold)
		mo.ringslinger.bobx = -100*FRACUNIT
		mo.ringslinger.boby = -25*FRACUNIT
	else
		mo.ringslinger.swipe = 1
		mo.ringslinger.boby = (6+weapon.delay)*FRACUNIT*7
	end
end

RS.TrySwap = function(mo)
	local player = mo.player
	local pbtn = player.rs_prevbuttons
	local btn = player.rs_buttons
	local nex = (btn & BT_WEAPONNEXT) and not (pbtn & BT_WEAPONNEXT)
	local prev = (btn & BT_WEAPONPREV) and not (pbtn & BT_WEAPONPREV)
	
	if mo.ringslinger.burst
		return
	end
	
	local newslot
	if nex or prev
		if mo.ringslinger.wepslot == 1
			newslot = 2
		else
			newslot = 1
		end
	end
	
	if newslot
		if newslot == mo.ringslinger.wepslot
			S_StartSoundAtVolume(mo, sfx_s23a, 50)
			mo.ringslinger.hudy = 1
		else
			mo.ringslinger.wepslot = newslot
			mo.ringslinger.weapondelay = max($, 5)
			mo.ringslinger.boby = 10*FRACUNIT*7
			mo.ringslinger.hudy = 5
			S_StartSoundAtVolume(mo, sfx_s25d, 120)
			S_StartSoundAtVolume(mo, sfx_s23a, 70)
		end
	end
end

RS.TryReload = function(mo)
	local player = mo.player
	local pbtn = player.rs_prevbuttons
	local btn = player.rs_buttons
	
	if (btn & BT_FIRENORMAL) and not (pbtn & BT_FIRENORMAL)
	and (mo.ringslinger.ammo < mo.ringslinger.maxammo)
	and not mo.ringslinger.reload
		RS.DoReload(mo)
	end 
end

RS.GetSkinInfo = function(skin)
	if RS.Skins[skin]
		return RS.Skins[skin]
	end
	
	local strbyte = string.byte(skin)
	local mainhand, offhand
	
	--All sonics will use scatter as their mainhand
	if string.match(skin, "sonic")
		mainhand = RSWPN_SCATTER
	end
	
	--Generate stuff based on skin's name and prefcolor
	if mainhand == nil
		mainhand = (strbyte % RS.AutoGenerateMax) + 1
	end
	if offhand == nil
		offhand = ((strbyte + skins[skin].prefcolor) % (RS.AutoGenerateMax - 1)) + 1
		if offhand >= mainhand
			offhand = $ + 1
		end
	end
	
	return {
		ammo = RS.defaultammo,
		weapons = {mainhand, offhand}
	}
end

RS.FlashNerf = function(player)
	if player.powers[pw_flashing] < (3 * TICRATE - 1)
		player.powers[pw_flashing] = min($, 2*TICRATE)
	end
end

addHook("PreThinkFrame", function()
	if not (gametyperules & GTR_RINGSLINGER or CV_FindVar("ringslinger").value)
		return
	end
	
	for player in players.iterate
		player.rs_buttons = player.cmd.buttons
		if player.mo
			player.cmd.buttons = $ & ~BT_ATTACK
			player.cmd.buttons = $ & ~BT_FIRENORMAL
		end
	end
end)

RS.ResetPlayer = function(mo, player)
	local rsskin = RS.GetSkinInfo(mo.skin)
	if (not (rsskin.weapons[1] and rsskin.weapons[2]))
		print("ERROR: skin "+mo.skin+" has incorrect weapon definitions. Check your spelling?")
	end
	mo.ringslinger = {}
	mo.ringslinger.skin = mo.skin
	mo.ringslinger.loadout = {rsskin.weapons[1] or RSWPN_NORMAL, rsskin.weapons[2] or RSWPN_NORMAL}
	mo.ringslinger.wepslot = 1
	mo.ringslinger.weapondelay = TICRATE/2
	mo.ringslinger.burst = 0
	mo.ringslinger.burstdelay = 0
	mo.ringslinger.ammo = rsskin.ammo
	mo.ringslinger.maxammo = rsskin.ammo
	mo.ringslinger.infinity = 0
	mo.ringslinger.swipe = 0
	mo.ringslinger.bob = 0
	mo.ringslinger.bobx = 0
	mo.ringslinger.boby = FRACUNIT*120
	mo.ringslinger.hudy = 0
	mo.ringslinger.reload = 0
	mo.ringslinger.reloadcosthud = 0
	mo.ringslinger.lostringstimer = 0
	mo.ringslinger.lostrings = 0
	mo.ringslinger.lostringsxoff = 0
	mo.ringslinger.powers = {}
end

addHook("ThinkFrame", function(mo)
	for player in players.iterate
	     player.reloadingdelay = $ or 0
		 player.reloadingdelay = $-1
		if (player.cmd.buttons & BT_CUSTOM2) and not (player.ctfteam == 1) and (player.reloadingdelay <= 0) then
		  local mo = player.mo
		   RS.DoReload(mo)
		   player.reloadingdelay = 4*TICRATE
	   end
	end
end)

addHook("ThinkFrame", function()
	if not (gametyperules & GTR_RINGSLINGER or CV_FindVar("ringslinger").value)
		return
	end
	
	for player in players.iterate
		if not (player.mo and player.mo.valid and player.playerstate == PST_LIVE) continue end
		local mo = player.mo
		
		if (not mo.ringslinger)
			player.rs_prevbuttons = 0
			player.rs_buttons = 0
			RS.ResetPlayer(mo, player)
			continue
		end
		
		if mo.skin != mo.ringslinger.skin
			RS.ResetPlayer(mo, player)
			continue
		end
		
		--flashing invuln nerf
		RS.FlashNerf(player)
		
		--powerup timers
		/*local emeraldcount = 0
		for i = 0, 6
			if (player.powers[pw_emeralds] & 2^i)
				emeraldcount = $ + 1
			end
		end*/
		for i = 1, #RS.Powers
			mo.ringslinger.powers[i] = $ or 0
			/*if emeraldcount == 7
				mo.ringslinger.powers[i] = 25*FRACUNIT
			end*/
			if mo.ringslinger.powers[i] > 0
				//if emeraldcount < 7
					//local deplete = FRACUNIT - (emeraldcount * FRACUNIT/10)
					mo.ringslinger.powers[i] = max(0, $ - FRACUNIT)
					if mo.ringslinger.powers[i] == 0
						S_StartSoundAtVolume(nil, sfx_s3k72, 200, player)
					end
				//end
				
				if RS.Powers[i].afterimages and (leveltime % 8 == i) and not splitscreen
					local g = P_SpawnGhostMobj(mo)
					g.frame = $ | FF_TRANS70
					g.destscale = $ * 2
					g.colorized = true
					g.color = RS.Powers[i].color
					P_Thrust(g, P_RandomRange(-50, 50)*ANG1 + mo.angle, P_RandomRange(-1, -6)*FRACUNIT)
					
					if player == displayplayer
						if  (camera == nil)
						or (camera.chase == false)
							g.flags2 = $ | MF2_DONTDRAW
						else
							g.flags2 = $ & ~MF2_DONTDRAW
						end
					end
				end
			end
		end
		
		--hud slide
		if mo.ringslinger.hudy
			mo.ringslinger.hudy = max(0, $ - 2)
		end
		
		--weapon delay
		if mo.ringslinger.weapondelay
			mo.ringslinger.weapondelay = $ - 1
		end
		
		--burst delay
		if mo.ringslinger.burstdelay
			mo.ringslinger.burstdelay = $ - 1
			if mo.ringslinger.burstdelay == 0
				RS.TryFireWeapon(mo, true)
			end
		end
		
		--infinity
		if mo.ringslinger.infinity
			mo.ringslinger.infinity = max(0, $ - FRACUNIT)
			if (leveltime % 2) and not splitscreen
				local g = P_SpawnMobjFromMobj(mo, 0, 0, mo.height / 2, MT_SPINDUST)
				g.state = S_THOK
				g.sprite = SPR_RNGI
				g.frame = FF_TRANS70
				g.color = SKINCOLOR_WHITE
				g.blendmode = AST_ADD
				g.scale = $ / 3
				g.destscale = mo.scale
				P_Thrust(g, P_RandomRange(0, 359)*ANG1, P_RandomRange(3, 10)*FRACUNIT)
				
				if player == displayplayer
					if  (camera == nil)
					or (camera.chase == false)
						g.flags2 = $ | MF2_DONTDRAW
					else
						g.flags2 = $ & ~MF2_DONTDRAW
					end
				end
			end
			if mo.ringslinger.infinity == 0
				S_StartSoundAtVolume(nil, sfx_s3k66, 200, player)
			end
		end
		
		--hurt, zoomtube, reflector nerf
		if P_PlayerInPain(player)
		or player.powers[pw_carry] == CR_ZOOMTUBE
		or (player.marine and mo.state == S_MARINE_SWIPE)
		or (player.dolldelay)
			mo.ringslinger.weapondelay = max($, 10)
			mo.ringslinger.boby = max($, 70*FRACUNIT)
		end
		
		--lost ring display timer
		if mo.ringslinger.lostringstimer
			mo.ringslinger.lostringstimer = $ - 1
		end
		
		--reload
		if mo.ringslinger.reload > 0
			if mo.ringslinger.ammo > 0
				mo.ringslinger.reload = 0
			else
				local reloadrate = FRACUNIT/RELOADTIME
				if mo.ringslinger.powers[RSPOWER_QUICKRELOAD]
					reloadrate = $ * 3
				end
				mo.ringslinger.reload = $ - reloadrate
				mo.ringslinger.boby = 100*FRACUNIT
				if mo.ringslinger.reload <= 0
					mo.ringslinger.reload = 0
					mo.ringslinger.ammo = mo.ringslinger.maxammo
					S_StartSoundAtVolume(nil, sfx_rs_amm, 120, mo.player)
					S_StopSoundByID(mo, sfx_rs_rel)
				end
			end
		end
		
		--reload cost hud
		if mo.ringslinger.reloadcosthud
			mo.ringslinger.reloadcosthud = $ - 1
		end
		
		--bobbing
		mo.ringslinger.bob = min(FixedMul(player.rmomx,player.rmomx) + FixedMul(player.rmomy,player.rmomy) / 30, 7*FRACUNIT)
		local target
		if P_IsObjectOnGround(mo)
			target = FixedMul(sin(leveltime * ANG20), mo.ringslinger.bob)
		else
			target = max(min(10*FRACUNIT, mo.momz), -10*FRACUNIT)
		end
		local diff = max(target - mo.ringslinger.boby, -45*FRACUNIT)
		mo.ringslinger.boby = $ + diff / 4
		if P_IsObjectOnGround(mo)
			target = (-player.cmd.sidemove * FRACUNIT / 18)
		else
			target = 0
		end
		diff = target - mo.ringslinger.bobx
		mo.ringslinger.bobx = $ + diff / 10
		
		--swipe
		if mo.ringslinger.swipe
			mo.ringslinger.swipe = $ + 1
			if mo.ringslinger.swipe >= 4
				mo.ringslinger.swipe = 0
			end
		end
		
		--throwing rings, swapping weapons
		RS.TrySwap(mo)
		RS.TryReload(mo)
		RS.TryFireWeapon(mo)
		
		player.rs_prevbuttons = player.rs_buttons
	end
end)

addHook("MobjDamage", function(target, inflictor, source, damage, damagetype)
	if not (gametyperules & GTR_RINGSLINGER or CV_FindVar("ringslinger").value)
		return
	end
	
	if inflictor and inflictor.type == MT_RS_THROWNINFINITY and source and source.ringslinger
		source.ringslinger.infinity = 10*TICRATE*FRACUNIT
		source.ringslinger.reload = 0
		source.ringslinger.ammo = source.ringslinger.maxammo
		S_StopSoundByID(source, sfx_rs_rel)
		S_StartSound(source, sfx_s3ka8)
	end
	
	if (target.flags & MF_ENEMY and source and source.ringslinger)
		source.ringslinger.ammo = source.ringslinger.maxammo
		S_StartSound(source, sfx_rs_amm)
		S_StopSoundByID(source, sfx_rs_rel)
	end
end)

addHook("MobjDamage", function(target, inflictor, source, damage, damagetype)
	if not (gametyperules & GTR_RINGSLINGER or CV_FindVar("ringslinger").value)
		return
	end
	
	if (inflictor and inflictor.pierce and source and source.player and (target.player.powers[pw_shield] or target.ringslinger.powers[RSPOWER_PROTECTION]))
		P_RemoveShield(target.player)
		P_RemoveShield(target.player)
		target.ringslinger.powers[RSPOWER_PROTECTION] = 0
		S_StartSoundAtVolume(nil, sfx_rs_pie, 150, target.player)
		S_StartSoundAtVolume(target, sfx_rs_pie, 150)
		S_StartSoundAtVolume(nil, sfx_rs_pie, 150, source.player)
	end
	
	if (target.ringslinger and target.ringslinger.powers[RSPOWER_PROTECTION])
		S_StartSoundAtVolume(nil, sfx_cdfm28, 160, target.player)
		S_StartSoundAtVolume(target, sfx_cdfm28, 200)
		if source and source.player
			S_StartSoundAtVolume(nil, sfx_cdfm28, 160, source.player)
		end
		target.ringslinger.powers[RSPOWER_PROTECTION] = 0
		target.player.powers[pw_flashing] = max($, 25)
		target.momx = $ / 2
		target.momy = $ / 2
		if inflictor
			target.momx = $ + inflictor.momx / 3
			target.momy = $ + inflictor.momy / 3
			target.momz = $ + inflictor.momz / 3
		end
		return true
	end
	
	if (inflictor and source and source.player and source.ringslinger and target.player and target.ringslinger)
		if splitscreen or target.player == displayplayer
			P_StartQuake(6*FRACUNIT, 5)
		end
		if inflictor.player
			S_StartSoundAtVolume(nil, sfx_rs_dmg, inflictor.player, 80)
		end
		S_StartSound(target, sfx_rs_dmg)
		S_StartSound(target, sfx_s3kb4)
	end
end, MT_PLAYER)