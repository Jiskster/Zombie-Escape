local MV = MapVote
local NET = MapVoteNet
local dprint = MV.DebugPrint

-------------------------------------------------------------------------------
--MISC
-------------------------------------------------------------------------------

MV.ArrayContainsValue = function(t,v)
	for i = 0, #t
		if v == t[i]
			return true
		end
	end
	return false
end

-------------------------------------------------------------------------------
--GAMETYPE DATA
-------------------------------------------------------------------------------

--Register a gametype to work with MapVote
MV.RegisterGametype = function(id, name, minplayers, maxplayers, tol, tol2, tol3)
	if id == nil or NET.gametypedata[id]
		return
	end
	if maxplayers == 0
		maxplayers = #players
	end
	
	--Has to be done like this in case any of the tol's are nil
	local typeoflevel = 0
	if tol
		typeoflevel = $ | tol
	end
	if tol2
		typeoflevel = $ | tol2
	end
	if tol3
		typeoflevel = $ | tol3
	end
	NET.gametypedata[id] = {
		name = name,
		identifier = string.gsub(string.lower(name), " ", ""),
		minplayers = minplayers,
		maxplayers = maxplayers,
		typeoflevel = typeoflevel
	}
	dprint("Registered MapVote gametype: "..name)
end

-------------------------------------------------------------------------------
--MAP DATA
-------------------------------------------------------------------------------

--Returns the extended map number as a string
--Returns nil if n is an invalid map number
MV.GetExtMapnumFromInt = function(n)
	if n == nil or n < 0 or n > 1035
		return nil
	end
	if n < 10
		return "MAP0" + n
	end
	if n < 100
		return "MAP" + n
	end
	local x = n-100
	local p = x/36
	local q = x - (36*p)
	local a = string.char(65 + p)
	local b
	if q < 10
		b = q
	else
		b = string.char(55 + q)
	end
	return "MAP" + a + b
end

--Returns the name of a map such as "Greenflower 1" or "Jade Valley"
--Returns MAPXX as a string if the map doesn't have a valid title
MV.GetNameFromMapnum = function(m)
	if m == nil
		return nil
	end
	local h = mapheaderinfo[m]
	if h and h.lvlttl
		local n = h.lvlttl
		if h.actnum > 0
			n = $ + " " + h.actnum
		end
		return n
	end
	return MV.IntToExtMapnum(m)
end

--Returns the name of a map such as "Greenflower 1" or "Jade Valley"
--Returns MAPXX as a string if the map doesn't have a valid title
MV.GetAuthorFromMapnum = function(m)
	if m == nil
		return nil
	end
	local h = mapheaderinfo[m]
	if h
		if mapheaderinfo[m].author
			return " by " + mapheaderinfo[m].author
		end
	end
	return ""
end

MV.GetFullTitle = function(map, gt)
	if gt != nil
		return ""..MV.GetNameFromMapnum(map)..MV.GetAuthorFromMapnum(map).." ("..NET.gametypedata[gt].name..")"
	end
	return ""..MV.GetNameFromMapnum(map)..MV.GetAuthorFromMapnum(map)
end

MV.StringSplit = function(s, delimiter)
    local result = {}
    for m in string.gmatch(s..delimiter, "(.-)"..delimiter)
        table.insert(result, m)
    end
    return result
end

MV.DrawLevelName = function(v, name, gtname, xx, yy, textflags)
	name = MV.StringSplit(name, " ")
	local yoff = 0
	local i = 1
	local str = ""
	for i = 1, #name
		if str == ""
			str = name[i]
		else
			str = $.." "..name[i]
		end
		if i == #name or string.len(str..""..name[i + 1]) > 15
			v.drawString(xx, yy + yoff, str, tflags, "thin")
			str = ""
			yoff = $ + 8
		end
	end
	v.drawString(xx, yy + yoff, gtname, tflags, "small")
end

--JJK
--Returns integer id of a character
MV.GetNumFromChar = function(char)
    return string.byte(char)-string.byte("A")
end

--JJK
--Returns integer id of an extended mapnum
MV.ExtMapnumToInt = function(ext)
	ext = ext:upper()
	if ext:sub(1, 3) == "MAP"
		ext = ext:sub(4,5)
	end
	
    local num = tonumber(ext)
    if num != nil then
        return num
    end
	
	if ext:len() != 2
		return nil
	end
	
    local x = ext:sub(1,1)
	if tonumber(x)
		return nil
	end
	
    local y = ext:sub(2,2)
    local p = MV.GetNumFromChar(x)
    local q = tonumber(y)
    if q == nil then
        q = 10 + MV.GetNumFromChar(y)
    end
    return ((36*p + q) + 100)
end

--Returns the extended map number as a string
--Returns nil if n is an invalid map number
MV.IntToExtMapnum = function(n)
	if n < 0 or n > 1035
		return nil
	end
	if n < 10
		return "MAP0" + n
	end
	if n < 100
		return "MAP" + n
	end
	local x = n-100
	local p = x/36
	local q = x - (36*p)
	local a = string.char(65 + p)
	local b
	if q < 10
		b = q
	else
		b = string.char(55 + q)
	end
	return "MAP" + a + b
end

--Convert a typeoflevel flag into an array of typeoflevels
MV.GetArrayFromTOL = function(tol)
	local a = {}
	for i = 1, 32
		if tol & (2^i)
			table.insert(a, (2^i))
		end
	end
	return a
end

--Returns an array of available gametypes from a mapnum
MV.GetGametypesFromMapnum = function(mapnum)
	local header = mapheaderinfo[mapnum]
	if not header
		return nil
	end
	
	local available_gametypes = {}
	for i = GT_COOP, #NET.gametypedata
		if NET.gametypedata[i] and MV.ArrayContainsValue(NET.enabled_gametypes,i)
			local gtdata = NET.gametypedata[i]
			local tol_list = MV.GetArrayFromTOL(gtdata.typeoflevel)
			local playercount = 0
			for p in players.iterate
				playercount = $ + 1
			end
			
			if playercount >= gtdata.minplayers and playercount <= gtdata.maxplayers
				for j = 1, #tol_list
					local tol = tol_list[j]
					if header.typeoflevel & tol
						table.insert(available_gametypes, i)
					end
				end
			end
		end
	end
	
	if #available_gametypes == 0
		return nil
	end
	
	return available_gametypes
end

--Put all maps into the table
--Seraches through all maps with a level header and returns an array of them
MV.GetValidMaps = function()
	local arr = {}
	
	for m = 1, #mapheaderinfo
		local mapenabled = false
		--Whitelist check
		if #NET.mapwhitelist == 0
			mapenabled = true
		elseif MV.ArrayContainsValue(NET.mapwhitelist,m)
			mapenabled = true
		end
		--Blacklist check
		if MV.ArrayContainsValue(NET.mapblacklist,m)
			mapenabled = false
		end
		--Header check
		if mapheaderinfo[m] and mapenabled
			if MV.GetGametypesFromMapnum(m)
				dprint("Found map: " + m + " - " + MV.GetExtMapnumFromInt(m) + " - " + MV.GetNameFromMapnum(m))
				table.insert(arr, m)
			end
		end
	end
	return arr
end

--Returns an array of mapnums with length amt, and removes those from NET.mapqueue
MV.GetRandomMaps = function(amt)
	NET.mapqueue = MV.GetValidMaps()
	if #NET.mapqueue < amt
		print("ERROR: less than "..amt.." valid maps!")
		return nil
	end
	local arr = {}
	for i = 1,amt
		local index = P_RandomRange(1,#NET.mapqueue)
		local map = NET.mapqueue[index]
		
		arr[i] = map
		table.remove(NET.mapqueue, index)
	end
	return arr
end

--Returns a random gametype that is compatible with the given mapnum and NET.enabled_gametypes
MV.GetARandomGametype = function(m)
	local gtypes = MV.GetGametypesFromMapnum(m)
	return gtypes[P_RandomRange(1,#gtypes)]
end