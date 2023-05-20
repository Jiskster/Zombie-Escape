local CV = RV_ZESCAPE.Console
local hudtypefilename = "client/ZombieEscape/hudtype.dat"
local showendscorefilename = "client/ZombieEscape/showendscore.dat"
CV.hudtype = CV_RegisterVar{
	name = "hudtype",
	defaultvalue = "2",
	flags = CV_CALL|CV_NOINIT,
	PossibleValue={MIN = 1, MAX = 2},
	func = function(cv)
		if io then
			local file = io.openlocal(hudtypefilename, "w+")
			file:write(cv.value)
			file:close()
		end
	end
}

CV.showendscore = CV_RegisterVar{
	name = "showendscore",
	defaultvalue = "Off",
	flags = CV_CALL|CV_NOINIT,
	PossibleValue = CV_OnOff,
	func = function(cv)
		if io then
			local file = io.openlocal(showendscorefilename, "w+")
			file:write(cv.value)
			file:close()
		end
	end
}

CV.debug = CV_RegisterVar{
	name = "ze_debug",
	defaultvalue = "Off",
	flags = CV_CALL|CV_NOINIT,
	PossibleValue = CV_OnOff,
}
local hudtypefile = io.openlocal(hudtypefilename)
local hudtypevalue_fromfile
local showendscorefile = io.openlocal(showendscorefilename)
local showendscorevalue_fromfile
if hudtypefile
	local num = hudtypefile:read("*n")
	hudtypevalue_fromfile = num
	hudtypefile:close()
end


if showendscorefile
	local num = showendscorefile:read("*n")
	showendscorevalue_fromfile = num
	showendscorefile:close()
end
if hudtypevalue_fromfile then
	COM_BufInsertText(nil, "hudtype "..hudtypevalue_fromfile)
end

if showendscorevalue_fromfile then
	COM_BufInsertText(nil, "showendscore "..showendscorevalue_fromfile)
end