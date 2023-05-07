local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.damagetable = {}
ZE.damagetable["damage"] = {}
ZE.damagetable["knockback"] = {}
ZE.damagetable["killmsg"] = {}
ZE.damagetable["logic"] = {}
ZE.damagetable["swapnames"] = {}
ZE.tablenum = 0

ZE.G_AddToDamageTable = function(knockback, killmsg, logic, swapnames)
	local num = ZE.tablenum + 1
	if knockback == nil
	or killmsg == nil
	or logic == nil
		print("\x82" .. "ERROR" .. "\x80" .. ": Call to G_AddToDamageTable has insufficient parameters.")
	else
		killmsg = tostring(killmsg)
		ZE.damagetable.knockback[num] = knockback
		ZE.damagetable.killmsg[num] = killmsg
		ZE.damagetable.logic[num] = logic
		if swapnames == nil
			swapnames = false
		else
			if swapnames ~= false
			and swapnames ~= true
				swapnames = false
			end
		end
		ZE.damagetable.swapnames[num] = swapnames
		print("Added entry " .. tostring(num) .. " to the damage table.")
		ZE.tablenum = $1 + 1
	end
end

ZE.F_NotTeamed = function(play1, play2)
	if play1.ctfteam == 0
	or play2.ctfteam == 0
		return true
	end
	if play1.ctfteam == play2.ctfteam
		return false
	else
		return true
	end
end

ZE.F_GetNode = function(player)
	for a=0,31 do
		if players[a] ~= nil
			if players[a] == player
				return a
			end
		end
	end
end

ZE.ShieldToHealth = function()
	if not (gametype == GT_ZESCAPE)
	and not (gametype == GT_ZSWARM) then return end
	for player in players.iterate
		if not (player.mo and player.mo.valid) return end
		if gametype == GT_MATCH
			player.ctfteam = 0
		end
		player.pity = 0
		if player.spawnrings == nil
			player.spawnrings = true
			player.painsound = 5
		end
		if player.powers[pw_shield] ~= SH_NONE
			player.mo.health = $ + 50
			player.health = player.mo.health
			player.powers[pw_shield] = SH_NONE
		end
		if player.playerstate == PST_REBORN
			player.spawnrings = true
		end
		if player.mo ~= nil
			if player.spawnrings == true
			and player.playerstate == PST_LIVE
				player.spawnrings = false
			end
		end
		/*
		local ringlimit = CV.ringlimit.value + 1
		if player.mo.health > ringlimit
			player.mo.health = ringlimit --Limit please.
			player.health = player.mo.health
		end
		*/
	end
end

ZE.rhDamage = function(hurtplayer, hazard, shooter, damage) -- damage system
   if (CV.rhenable.value == 0) then return end
	if not (gametype == GT_ZESCAPE)
	 and not (gametype == GT_ZSWARM) then return end
		local painsfx = {sfx_altow1, sfx_altow2, sfx_altow3}
		if shooter != nil
			if shooter.type != nil
				if hurtplayer.health < 1 --Do not repeat this process multiple times!
					return false
				end
				if shooter.player == nil
				or hurtplayer.player == nil
					return false
				end
				if shooter.type & MT_PLAYER
				and hurtplayer.player.powers[pw_invulnerability] < 1
				and hurtplayer != shooter --Stop hitting yourself!
					if hazard == nil
						return
					end
					if hazard.hits == nil
						hazard.hits = {}
					end
					local node = ZE.F_GetNode(hurtplayer.player)
					if hazard.hits[node] ~= nil
						if hazard.type ~= MT_PLAYER
						and hazard.type ~= MT_THROWNBOUNCE
							return false --Prevents ring multi-hitting, except for bounce rings and players. They are special cases.
						end
					else
						hazard.hits[node] = true
					end
					
					local critical = P_RandomChance(FRACUNIT/50)
					
					
					local deathmsg = "%s killed %s."
					local truedmg = 0
					local catch = 0
					for x=1,ZE.tablenum do
						local newdmg = ZE.damagetable.logic[x](hazard, hurtplayer.health)
						if tonumber(newdmg) == nil
							print("\x82" .. "ERROR" .. "\x80" .. ": Logic in damage entry " .. tostring(x) .. " returned a nil or invalid value. Use a number; return 0 for a failed check.")
							newdmg = 0
						end
						if newdmg > 0
							if CV.debug.value == 1
								print("Caught entry " .. tostring(x) .. " on damage table for " .. tostring(newdmg) .. " damage.")
							end
							truedmg = newdmg
							catch = x
						end
					end
					if truedmg < 1
						return false
					end
					local knockback = ZE.damagetable.knockback[catch]
					if shooter.player.ztype == "ZM_ALPHA" and shooter.player.boosttimer > 0 then -- rage = double damage
						truedmg = $1 * 2
					end
					if hurtplayer.player.ztype == "ZM_TANK" then
						knockback = $1 / 3
					end
					
					if hurtplayer.player.ztype == "ZM_ALPHA" then
						knockback = $1 * 2
					end
					if CV.knockback.value == 1 then  --knockbackk stuff
						if ZE.F_NotTeamed(shooter.player, hurtplayer.player)
							
							if critical then
								knockback = $1 * 7
							end
							P_Thrust(hurtplayer, hazard.angle, knockback)
						else
							if CV.friendlypushing.value == 1
								if critical then
									knockback = $1 * 7
								end
								P_Thrust(hurtplayer, hazard.angle, knockback)
							end
						end
					end
					

					if ZE.F_NotTeamed(shooter.player, hurtplayer.player) == false
						return
					end
					if critical then
						truedmg = $1 * 5
						S_StartSound(hurtplayer,sfx_critze)
						S_StartSound(nil,sfx_critze,shooter.player) -- so shooter can hear clearly too
						local goldghost = P_SpawnMobjFromMobj(hurtplayer,0,0,0,MT_THOK) --this used to be a mobj ghost so the name is that - Jisk 4/30/2023 
						goldghost.scale = $/3
						goldghost.fuse = 15
						--A_MultiShot(goldghost, MT_FLINGRING*FU+25)
						P_SetScale(goldghost, hurtplayer.scale*2)
						goldghost.color = SKINCOLOR_GOLD
					end
					if CV.debug.value == 0 and shooter.player.ctfteam == 2
						if hurtplayer.player.powers[pw_super]
							truedmg = $1 / 2
						end
						hurtplayer.health = $1 - truedmg
						if not(ZE.teamWin) then
							P_AddPlayerScore(shooter.player, truedmg)
						end
						hurtplayer.player.health = hurtplayer.health
						if hurtplayer.player.powers[pw_super] > 0
						and hurtplayer.health < 1
							hurtplayer.health = 1
							hurtplayer.player.health = 1
						end
					end
					if CV.debug.value == 0 and shooter.player.ctfteam == 1
						if hurtplayer.player.powers[pw_super]
							truedmg = $1 / 2
						end
						if mapheaderinfo[gamemap].zombieswarm then
							if ZE.Wave > 2 then
								truedmg = $1 * 2
							end
						end
						hurtplayer.health = $1 - truedmg

						if not(ZE.teamWin) then
							P_AddPlayerScore(shooter.player, truedmg)
						end
						hurtplayer.player.health = hurtplayer.health
						hurtplayer.player.powers[pw_invulnerability] = CV.survivorframes.value
					end
					if hurtplayer.health < 1 -- on death
						P_PlayerWeaponPanelBurst(hurtplayer.player)
						P_PlayerWeaponAmmoBurst(hurtplayer.player)
						P_PlayerEmeraldBurst(hurtplayer.player)
						P_PlayerFlagBurst(hurtplayer.player)
						P_KillMobj(hurtplayer, hazard, shooter)
						local name1 = shooter.player.name
						local name2 = hurtplayer.player.name
						if shooter.player.ctfteam == 1
							name1 = "\x85" .. $1 .. "\x80"
						elseif shooter.player.ctfteam == 2
							name1 = "\x84" .. $1 .. "\x80"
						end
						if hurtplayer.player.ctfteam == 1
							name2 = "\x85" .. $1 .. "\x80"
						elseif hurtplayer.player.ctfteam == 2
							name2 = "\x84" .. $1 .. "\x80"
						end
						if ZE.damagetable.swapnames[catch] == true
							print(string.format(ZE.damagetable.killmsg[catch], name2, name1))
						else
							print(string.format(ZE.damagetable.killmsg[catch], name1, name2))
						end
						
						shooter.player.kills = $ + 1
						
						if mapheaderinfo[gamemap].zombieswarm and shooter.maxHealth and shooter.health then
							
							shooter.maxHealth = $ + (15)
							shooter.health = $ + (15)
						end
						
						if hurtplayer.player.ztype == "ZM_ALPHA" and shooter.maxHealth and shooter.health then
							shooter.maxHealth = $ + (30)
							shooter.health = $ + (30)
						end
						
						if hurtplayer.player.ztype == "ZM_TANK" and shooter.maxHealth and shooter.health then
							shooter.maxHealth = $ + (125)
							shooter.health = $ + (30)
						end
						if not(ZE.teamWin) then
							if ZE.Wave then
								P_AddPlayerScore(shooter.player, 250*ZE.Wave)
							else
								P_AddPlayerScore(shooter.player, 250)
							end
							
							if not critical then
								P_GivePlayerRings(shooter.player,50)
							end
							
							if critical then
								P_GivePlayerRings(shooter.player,250)
							end
						end
					else
						S_StartSound(hurtplayer,painsfx[P_RandomRange(1,#painsfx)])

						return false
				end
			end
		end
	end
end