local MV = MapVote
local NET = MapVoteNet

MV.cv_debug = CV_RegisterVar({
    name = "mvdebug",
    defaultvalue = "Off",
    flags = CV_NETVAR,
    PossibleValue = CV_OnOff
})
MV.cv_scoretime = CV_RegisterVar({
	name = "scoretime",
	defaultvalue = tostring(10),
	flags = CV_NETVAR,
	PossibleValue = {MIN = 1, MAX = 30}
})
MV.cv_votetime = CV_RegisterVar({
	name = "votetime",
	defaultvalue = tostring(12),
	flags = CV_NETVAR,
	PossibleValue = {MIN = 1, MAX = 30}
})
MV.cv_weightedrandom = CV_RegisterVar({
    name = "weightedrandom",
    defaultvalue = "Off",
    flags = CV_NETVAR,
    PossibleValue = CV_OnOff
})
MV.cv_baseweight = CV_RegisterVar({
    name = "baseweight",
	defaultvalue = tostring(0),
	flags = CV_NETVAR,
	PossibleValue = {MIN = 0, MAX = 2}
})
COM_AddCommand("gametypelist", function(p, ...)
	local gt = {...}
	if gt == nil or #gt == 0
		print("Please supply a list of gametypes, separated by spaces.")
		print("Alternatively, use one of the following: default, ringslinger, allcustom")
	end
	
	local egt = {}
	
	if gt[1] == "default"
		egt = {GT_COMPETITION, GT_RACE, GT_MATCH, GT_TEAMMATCH, GT_TAG, GT_HIDEANDSEEK, GT_CTF}
		print("Enabled all vanilla gametypes")
	elseif gt[1] == "ringslinger"
		egt = {GT_MATCH, GT_TEAMMATCH, GT_TAG, GT_HIDEANDSEEK, GT_CTF}
		print("Enabled all vanilla ringslinger gametypes")
	elseif gt[1] == "allcustom"
		for i = GT_CTF + 1, #NET.gametypedata
			egt[i - 8] = i
		end
		print("Enabled all custom gametypes")
	elseif gt[1] == "all"
		for i = GT_COOP, #NET.gametypedata
			egt[i] = i
		end
		print("Enabled all gametypes except Co-Op")
	elseif gt[1] == "allbutcoop"
		for i = GT_COOP + 1, #NET.gametypedata
			egt[i - 1] = i
		end
		print("Enabled all gametypes")
	else
		for i = 1, #gt
			local found = false
			for j = GT_COOP, #NET.gametypedata
				if string.lower(gt[i]) == NET.gametypedata[j].identifier
					table.insert(egt, j)
					print("Added gametype: " + NET.gametypedata[j].name)
					found = true
				end
			end
			if found
				continue
			end
			
			local gametype = tonumber(gt[i])
			if gametype == nil
				print("Please list at least one gametype")
				return
			end
			if NET.gametypedata[gametype] == nil
				print("Invalid gametype: " + gametype)
				return
			end
			table.insert(egt, gametype)
			print("Added gametype: " + NET.gametypedata[gametype].name)
		end
	end
	
	NET.enabled_gametypes = egt
end, COM_ADMIN)

COM_AddCommand("gametypeconfig", function(p, gametype, config)
	if gametype == nil or config == nil
		print("gametypeconfig [gametype] [console command]")
		return
	end
	
	local found = false
	for i = GT_COOP, #NET.gametypedata
		if string.lower(gametype) == NET.gametypedata[i].identifier
			found = true
			gametype = i
		end
	end
	
	if not found
		gametype = tonumber(gametype)
		if gametype == nil
			print("gametypeconfig [gametype] [console command]")
			return
		end
	end
	
	NET.gametypedata[gametype].config = config
end, COM_ADMIN)

COM_AddCommand("mapwhitelist", function(p, ...)
	local wl = {...}
	if wl == nil or #wl == 0
		print("Please supply a list of whitelisted maps, using extended map numbers. Cleared the list.")
		NET.mapwhitelist = {}
	end
	
	local whitelist = {}
	
	for i = 1, #wl
		if wl[i] == nil
			print("nil mapnum.")
			return
		end
		local mapnum = MV.ExtMapnumToInt(wl[i])
		if mapnum == nil
			print("Invalid map: " + wl[i])
			return
		end
		table.insert(whitelist, mapnum)
		print("whitelisted map: " + mapnum)
	end
	
	NET.mapwhitelist = whitelist
end, COM_ADMIN)

COM_AddCommand("mapblacklist", function(p, ...)
	local bl = {...}
	if bl == nil or #bl == 0
		print("Please supply a list of blacklisted maps, using extended map numbers. Cleared the list.")
		NET.mapblacklist = {}
	end
	
	local blacklist = {}
	
	for i = 1, #bl
		if bl[i] == nil
			print("nil mapnum.")
			return
		end
		local mapnum = MV.ExtMapnumToInt(bl[i])
		if mapnum == nil
			print("Invalid map: " + bl[i])
			return
		end
		table.insert(blacklist, mapnum)
		print("blacklisted map: " + mapnum)
	end
	
	NET.mapblacklist = blacklist
end, COM_ADMIN)