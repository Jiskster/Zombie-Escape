rawset(_G,"RingSlinger",{})

local RS = RingSlinger
RS.Gametypes = {}
RS.Skins = {}
RS.Weapons = {}
RS.AddWeapon = function(weapon)
	local rawsetname = "RSWPN_"+string.upper(weapon.name:gsub(" ", ""))
	local id = #RS.Weapons + 1
	rawset(_G, rawsetname, id)
	RS.Weapons[id] = weapon
	print("Added new weapon: "+weapon.name+" ("+rawsetname+")")
end
RS.Powers = {}
RS.AddPower = function(powerup)
	local rawsetname = "RSPOWER_"+string.upper(powerup.name:gsub(" ", ""))
	local id = #RS.Powers + 1
	rawset(_G, rawsetname, id)
	RS.Powers[id] = powerup
	print("Added new powerup: "+powerup.name+" ("+rawsetname+")")
end