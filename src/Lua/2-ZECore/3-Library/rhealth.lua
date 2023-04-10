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
			local ringlimit = CV.ringlimit.value + 1
			if player.mo.health > ringlimit
				player.mo.health = ringlimit --Limit please.
				player.health = player.mo.health
		end
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
					
					if shooter.player.alphazm == 1 and shooter.player.boosttimer > 0 then -- if player.boosttimer > 0 then the player is in rage
						truedmg = $1 * P_RandomRange(2, 4) -- 1.5 to
					end
					if CV.knockback.value == 1
						if ZE.F_NotTeamed(shooter.player, hurtplayer.player)
							P_Thrust(hurtplayer, hazard.angle, ZE.damagetable.knockback[catch])
						else
							if CV.friendlypushing.value == 1
								P_Thrust(hurtplayer, hazard.angle, ZE.damagetable.knockback[catch])
							end
						end
					end
					if ZE.F_NotTeamed(shooter.player, hurtplayer.player) == false
						return
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
						hurtplayer.health = $1 - truedmg
						if not(ZE.teamWin) then
							P_AddPlayerScore(shooter.player, truedmg)
						end
						hurtplayer.player.health = hurtplayer.health
						hurtplayer.player.powers[pw_invulnerability] = 25
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
						if mapheaderinfo[gamemap].zombieswarm
							shooter.maxHealth = $ + (25*ZE.Wave)
							shooter.health = $ + (25*ZE.Wave)
						end
						if not(ZE.teamWin) then
							P_AddPlayerScore(shooter.player, 250)
							shooter.player.propspawn = $ + 1
						end
					else
						S_StartSound(hurtplayer,painsfx[P_RandomRange(1,#painsfx)])

						return false
				end
			end
		end
	end
end