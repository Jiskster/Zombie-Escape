local RS = RingSlinger

local makeshields = function(mo)
	for i = 0, 2
		local shield = P_SpawnMobj(mo.x, mo.y, mo.z, MT_RS_PROTECTION)
		shield.target = mo
		shield.spin = ANG30 * 4 * i
	end
end

RS.AddPower({name = "Pierce",		afterimages = true,		frame = C,	color = SKINCOLOR_RED,		hudcolor = 32})
RS.AddPower({name = "Rapid Fire",	afterimages = true,		frame = D,	color = SKINCOLOR_GREEN,	hudcolor = 96})
RS.AddPower({name = "Power Toss",	afterimages = true,		frame = E,	color = SKINCOLOR_YELLOW,	hudcolor = 74})
RS.AddPower({name = "Protection",	afterimages = false,	frame = F,	color = SKINCOLOR_SILVER,	hudcolor = 4,	func = makeshields})
RS.AddPower({name = "Quick Reload",	afterimages = true,		frame = G,	color = SKINCOLOR_BLUE,		hudcolor = 148})