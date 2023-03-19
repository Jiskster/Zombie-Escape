local RS = RingSlinger
COM_AddCommand("testweapon", function(player, weapon1, weapon2)
	if not (player and player.mo and player.mo.ringslinger)
		print("Cannot be used while spectating or while ringslinger is disabled")
		return
	end
	local mo = player.mo
	RS.ResetPlayer(mo, player)
	
	local w1, w2
	for i = 1, #RS.Weapons
		if weapon1 and string.lower(RS.Weapons[i].name) == string.lower(weapon1)
			w1 = i
		end
		if weapon2 and string.lower(RS.Weapons[i].name) == string.lower(weapon2)
			w2 = i
		end
	end
	if w1 or w2
		player.mo.ringslinger.loadout = {w1 or 1, w2 or 1}
	else
		print("Invalid weapons. Check your spelling?")
	end
end, COM_ADMIN)