local version = "6 RC1"

local escapeCodes = { -- HOLY FUCK THIS IS DUMB
	{a = "\\128", b = "\128"}, -- White
	{a = "\\129", b = "\129"}, -- Pink
	{a = "\\130", b = "\130"}, -- Yellow
	{a = "\\131", b = "\131"}, -- Green
	{a = "\\132", b = "\132"}, -- Blue
	{a = "\\133", b = "\133"}, -- Red
	{a = "\\134", b = "\134"}, -- Gray
	{a = "\\135", b = "\135"}, -- Orange
	{a = "\\136", b = "\136"}, -- Sky
	{a = "\\137", b = "\137"}, -- Purple
	{a = "\\138", b = "\138"}, -- Aqua
	{a = "\\139", b = "\139"}, -- Peridot
	{a = "\\140", b = "\140"}, -- Azure
	{a = "\\141", b = "\141"}, -- Brown
	{a = "\\142", b = "\142"}, -- Rosy
	{a = "\\143", b = "\143"}, -- Inverted
}

local hostmod_motd = CV_RegisterVar({
	name = "hostmod_motd",
	defaultvalue = "On",
	flags = CV_NETVAR,
	possiblevalue = CV_OnOff
})
local hostmod_motdalways = CV_RegisterVar({
	name = "hostmod_motdalways",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	possiblevalue = CV_OnOff
})
local hostmod_motddebug = CV_RegisterVar({
	name = "hostmod_motddebug",
	defaultvalue = "Off",
	flags = CV_NETVAR,
	possiblevalue = CV_OnOff
})
local hostmod_motdname = CV_RegisterVar({
	name = "hostmod_motdname",
	defaultvalue = "hostmod_motdname",
	flags = CV_NETVAR,
	possiblevalue = nil
})
local hostmod_motdcontact = CV_RegisterVar({
	name = "hostmod_motdcontact",
	defaultvalue = "hostmod_motdcontact",
	flags = CV_NETVAR,
	possiblevalue = nil
})
local hostmod_motddesc = CV_RegisterVar({
	name = "hostmod_motddesc",
	defaultvalue = "Configure this text with hostmotd_motddesc",
	flags = CV_NETVAR,
	possiblevalue = nil
})
local bigUglyColorLookupTable = {MIN = 0, White = 1, Silver = 2, Grey = 3, Nickel = 4, Black = 5, Skunk = 6, Fairy = 7, Popcorn = 8, Artichoke = 9, Pigeon = 10, Sepia = 11, Beige = 12, Walnut = 13, Brown = 14, Leather = 15, Salmon = 16, Pink = 17, Rose = 18, Brick = 19, Cinnamon = 20, Ruby = 21, Raspberry = 22, Cherry = 23, Red = 24, Crimson = 25, Maroon = 26, Lemonade = 27, Flame = 28, Scarlet = 29, Ketchup = 30, Dawn = 31, Sunset = 32, Creamsicle = 33, Orange = 34, Pumpkin = 35, Rosewood = 36, Burgundy = 37, Tangerine = 38, Peach = 39, Caramel = 40, Cream = 41, Gold = 42, Royal = 43, Bronze = 44, Copper = 45, Quarry = 46, Yellow = 47, Mustard = 48, Crocodile = 49, Olive = 50, Vomit = 51, Garden = 52, Lime = 53, Handheld = 54, Tea = 55, Pistachio = 56, Moss = 57, Camouflage = 58, RoboHood = 59, Mint = 60, Green = 61, Pinetree = 62, Emerald = 63, Swamp = 64, Dream = 65, Plague = 66, Algae = 67, Caribbean = 68, Azure = 69, Aqua = 70, Teal = 71, Cyan = 72, Jawz = 73, Cerulean = 74, Navy = 75, Platinum = 76, Slate = 77, Steel = 78, Thunder = 79, Rust = 80, Wristwatch = 81, Jet = 82, Sapphire = 83, Periwinkle = 84, Blue = 85, Blueberry = 86, Nova = 87, Pastel = 88, Moonslam = 89, Ultraviolet = 90, Dusk = 91, Bubblegum = 92, Purple = 93, Fuchsia = 94, Toxic = 95, Mauve = 96, Lavender = 97, Byzantium = 98, Pomegranate = 99, Lilac = 100}
local hostmod_motdbackground = CV_RegisterVar({
	name = "hostmod_motdbackground",
	defaultvalue = 61,
	flags = CV_NETVAR,
	possiblevalue = bigUglyColorLookupTable
})

local function doEscapeCode(str)
	for _, v in pairs(escapeCodes)
		str = str:gsub(v.a, v.b)
	end
	return str
end

local function doEscapeCodes()
	if not server then return end
	server.HMNMname = doEscapeCode(hostmod_motdname.string)
	server.HMNMcontact = ""..doEscapeCode(hostmod_motdcontact.string)
	server.HMNMdesc = doEscapeCode(hostmod_motddesc.string)
end

doEscapeCodes()

local function viewrandomplayer()
	for p in players.iterate
		if p.mo and p.mo.valid and not(p.spectator)
			return p
		end
	end
end

addHook("MapChange", do
	doEscapeCodes()
	if not hostmod_motdalways.value then return end
	for p in players.iterate
		p.HMNMtime = 0
	end
end)

addHook("ThinkFrame", do
	for p in players.iterate
		if p.spectator and not p.HMNMforced
		--	displayplayer = viewrandomplayer()
		end
		p.HMNMforced = true
		p.HMNMtime = $ or 0
		p.HMNMtime = $+1
		if hostmod_motddebug.value then
			p.HMNMtime = 2*TICRATE
		end
	end
end)

local delay = 1*TICRATE
local maxtime = 5*TICRATE
local scrolldelay = 3*TICRATE

local function xoff(i, o)
	local c = i-o
	if (i < o) or (i > maxtime) return 9999 end
	local x = 0
	if i > maxtime-10 then
		x = maxtime-i-10
	elseif c < 10 then
		x = 10-c
	end
	return x
end

local function aoff(i, o)
	if i < o return V_10TRANS end
	local c = i-o
	if i > maxtime - 10 then
		return (9 - (maxtime - i)) << V_ALPHASHIFT
	end
	if c > 9 return 0 end
	return (9-c) << V_ALPHASHIFT
end

hud.add(function(v, p, c)
	if not consoleplayer.valid then return end
	local t = consoleplayer.HMNMtime
	if not t then return end
	if t < delay then return end
	t = t - delay
	if t > maxtime+35 then return end
	local bg = v.cachePatch("MOTDBG")
	v.drawScaled((xoff(t,0))*FRACUNIT, 179*FRACUNIT, FRACUNIT, bg, V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_30TRANS|aoff(t,0), v.getColormap(TC_DEFAULT, hostmod_motdbackground.value))
	v.drawString(1+xoff(t, 0), 182, server.HMNMname, V_ALLOWLOWERCASE|V_SNAPTOBOTTOM|V_SNAPTOLEFT|aoff(t, 0))
	v.drawString(319+xoff(t, 25), 183, server.HMNMcontact, V_ALLOWLOWERCASE|V_SNAPTOBOTTOM|V_SNAPTORIGHT|aoff(t, 25), "thin-right")
	
	-- why the fuck did i implement this
	local w = v.stringWidth(server.HMNMdesc, V_ALLOWLOWERCASE|V_SNAPTOBOTTOM|V_SNAPTOLEFT|aoff(t, 0), "small")
	local scrolloff = 0
	local realwidth = v.width() / v.dupx()
	if w > realwidth and t > scrolldelay then
		local toscroll = realwidth - w - 25 -- overscroll fudge factor
		local scrollwindow = maxtime - 2*scrolldelay
		local scrollpos = min(t - scrolldelay, maxtime - scrolldelay)
		local scrollpercent = (10000*scrollpos) / (100*scrollwindow)
		scrolloff = toscroll * scrollpercent / 100
	end
	v.drawString(3+xoff(t, 0)+scrolloff, 193, server.HMNMdesc, V_ALLOWLOWERCASE|V_SNAPTOBOTTOM|V_SNAPTOLEFT|aoff(t, 0), "small")
end)