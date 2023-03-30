local RS = RingSlinger

local drawammobar = function(v, player, mo, cam)
	local maxammo = mo.ringslinger.maxammo
	local curammo = mo.ringslinger.ammo
	local cost = RS.Weapons[mo.ringslinger.loadout[mo.ringslinger.wepslot]].cost
	if mo.ringslinger.infinity
		cost = 0
	elseif (mo.ringslinger.wepslot != 1)
		cost = RS.GetOffhandCost($)
	end
	local reload = mo.ringslinger.reload
	local weapondelay = mo.ringslinger.weapondelay
	local x = 70
	local y = 187
	local barx = x - maxammo/2
	local bary = y + 8
	local patch1 = v.cachePatch("BARSEG1")
	local patch2 = v.cachePatch("BARSEG2")
	local patch3 = v.cachePatch("BARSEG3")
	local patch4 = v.cachePatch("BARSEG4")
	local patch5 = v.cachePatch("BARSEG5")
	local pixel = v.cachePatch("BARPIXEL")
	
	--Reloading display
	if reload
		if leveltime % 2
			v.drawString(x, y, "RELOAD", V_HUDTRANSHALF | V_PERPLAYER | V_SNAPTOBOTTOM, "thin-center")
		end
		
		local reloadammo = maxammo * (FRACUNIT - reload) / FRACUNIT
		local pos = 0
		while (pos < maxammo)
			local patch = patch3
			pos = $ + 1
			if pos <= reloadammo
				patch = patch4
			end
			v.draw(barx + pos - 1, bary, patch, V_HUDTRANSHALF | V_PERPLAYER | V_SNAPTOBOTTOM)
		end
		
	--Ammo display
	else
		--Ammo bar
		local pos = 0
		while (pos < maxammo)
			local patch = patch3
			pos = $ + 1
			if (mo.ringslinger.infinity)
				patch = v.cachePatch("BARSEG"+(5+(pos + leveltime)%4))
			else
				if pos <= curammo
					if pos > curammo - cost
						if (curammo <= cost)
							patch = patch5
						else
							patch = patch2
						end
					else
						patch = patch1
					end
				end
			end
			v.draw(barx + pos - 1, bary, patch, V_HUDTRANSHALF | V_PERPLAYER | V_SNAPTOBOTTOM)
		end
		
		--Ammo number
		local col = 0
		if curammo >= 10
			x = $ + 1
		elseif curammo <= cost
			col = V_REDMAP
		elseif curammo == maxammo
			col = V_GREENMAP
		end
		v.drawString(x, y, tostring(curammo), V_HUDTRANSHALF | V_PERPLAYER | V_SNAPTOBOTTOM | col, "thin-center")
		
		--Weapon cooldown bar
		local delayx = x - weapondelay/2
		local pos = 0
		while (pos < weapondelay)
			pos = $ + 1
			v.draw(delayx + pos - 1, bary+4, pixel, V_HUDTRANSHALF | V_PERPLAYER | V_SNAPTOBOTTOM)
		end
	end
end

//Weapon bar (main and sub weapon display)
local weapons = function(v, player, mo, cam)
	local y = (178 + mo.ringslinger.hudy) * FRACUNIT
	for i = 1, 2
		local weapon = RS.Weapons[mo.ringslinger.loadout[i]]
		local patch = v.cachePatch(weapon.hudsprite)
		
		local xoff
		if i == 1
			xoff = -10
		else
			xoff = 10
		end
		local x = (70 + xoff) * FRACUNIT
		local trans = ((mo.ringslinger.wepslot == i) and V_HUDTRANS|V_SNAPTOBOTTOM) or V_HUDTRANSHALF|V_SNAPTOBOTTOM
		local scale = FRACUNIT
		if i == 1
			scale = FRACUNIT*2/2
		end
		
		v.drawScaled(x, y, scale, patch, trans | V_SNAPTOBOTTOM | V_PERPLAYER | V_SNAPTOBOTTOM)
	end
	local xoff = 10
	local scale = FRACUNIT
	if mo.ringslinger.wepslot == 1
		xoff = -10
		scale = FRACUNIT*2/2
	end
	local x = (70 + xoff) * FRACUNIT
	local patch = v.cachePatch("CURWEAP")
	v.drawScaled(x, y, scale, patch, V_HUDTRANS | V_SNAPTOBOTTOM | V_PERPLAYER)
	
	--20 ring cost for reloading
	local blink = (mo.ringslinger.lostringstimer % 2)
	if mo.ringslinger.lostrings and mo.ringslinger.lostringstimer
		x = 70 + mo.ringslinger.lostringsxoff
		y = 174
		v.drawString(x, y, "-"+tostring(mo.ringslinger.lostrings), (blink and V_HUDTRANS or V_HUDTRANSHALF) | V_PERPLAYER | V_SNAPTOBOTTOM , "thin-center")
	end
end

//Powerup display
local powerups = function(v, player, mo, cam)
	local yoff = 0
	for i = 1, #RS.Powers
		if not mo.ringslinger.powers[i]
			continue
		end
		local x = 16
		local y = 50 + yoff
		yoff = $ + 12
		local barlength = mo.ringslinger.powers[i] / (8 * FRACUNIT)
		local power = RS.Powers[i]
		v.drawFill(x, y, barlength, 9, (V_SNAPTOLEFT | V_PERPLAYER) + power.hudcolor)
		if (mo.ringslinger.powers[i] / FRACUNIT < 2*TICRATE) and (leveltime % 2)
			continue
		end
		v.drawString(x + 1, y + 1, power.name, V_SNAPTOLEFT | V_HUDTRANS | V_PERPLAYER, "thin")
	end
	if not mo.ringslinger.infinity
		return
	end
	local x = 16
	local y = 50 + yoff
	yoff = $ + 12
	local barlength = mo.ringslinger.infinity / (8 * FRACUNIT)
	v.drawFill(x, y, barlength, 9, (V_SNAPTOLEFT | V_PERPLAYER) + 0)
	if (mo.ringslinger.infinity / FRACUNIT < 2*TICRATE) and (leveltime % 2)
		return
	end
	v.drawString(x + 1, y + 1, "Infinity", V_SNAPTOLEFT | V_HUDTRANS | V_PERPLAYER, "thin")
end

//Show your character holding the ring in firstperson
local holdingring = function(v, player, mo, cam)
	if cam.chase
		return
	end
	local weapon = RS.Weapons[mo.ringslinger.loadout[mo.ringslinger.wepslot]]
	local patch = v.cachePatch(weapon.viewsprite)
	local col = v.getColormap(TC_DEFAULT, player.skincolor)
	local scale = (weapon.scale or FRACUNIT) * 12/5
	local x, y
	if mo.ringslinger.swipe == 1
		x = 115*FRACUNIT
		y = 232*FRACUNIT
	else
		x = 230*FRACUNIT + mo.ringslinger.bobx
		y = 220*FRACUNIT + mo.ringslinger.boby + (weapon.viewoffset or 0)
	end
	
	if not splitscreen
		v.drawScaled(x, y, scale, patch, V_SNAPTOBOTTOM | V_SNAPTORIGHT | V_PERPLAYER, col)
	end
	if mo.ringslinger.swipe
		patch = v.cachePatch("SWIPE"+mo.ringslinger.swipe)
		v.draw(0, 0, patch, V_60TRANS | V_SNAPTOBOTTOM | V_PERPLAYER, col)
	end
end

//Add the hud
hud.add(function(v, player, cam)
	if not (gametyperules & GTR_RINGSLINGER or CV_FindVar("ringslinger").value)
		return
	end
	if not (player.mo and player.mo.valid and player.mo.ringslinger and player.playerstate == PST_LIVE)
		return
	end
	local mo = player.mo
	holdingring(v, player, mo, cam)
	weapons(v, player, mo, cam)
	drawammobar(v, player, mo, cam)
	powerups(v, player, mo, cam)
end, 'game')

hud.disable("weaponrings")