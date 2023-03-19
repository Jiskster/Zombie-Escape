assert(juggy, "Juggy_Definitions.lua must be defined first.")

local oldFreeslot = _G["freeslot"]

-- hardcoded and terrible but so are the enums that define the
-- first freeslot so that's life.
local startingMobjNum 	= 0
if MODID == juggy.SRB2KART then -- SRB2Kart
	startingMobjNum 	= MT_NAMECHECK
elseif MODID == juggy.SRB2 then -- SRB2
	startingMobjNum 	= MT_RAY
end
local startingStatesNum = S_NAMECHECK

local currentAddedMobjs = 0;
local currentAddedStates = 0;
local currentAddedSfx = 0;
local currentAddedSprites = 0;

if MODID == juggy.SRB2KART then -- SRB2Kart
	currentAddedSfx = sfx_kgloat
	currentAddedSprites = SPR_VIEW
elseif MODID == juggy.SRB2 then -- SRB2
	currentAddedSfx = sfx_kc6e
	currentAddedSprites = SPR_GWLR
end

local currentAddedSPR2s = 0
local currentAddedSkinColors = 0

local totalSPR2s = 127

if MODID == juggy.SRB2 then
	currentAddedSPR2s = SPR2_XTRA
	currentAddedSkinColors = SKINCOLOR_SUPERTAN5
end

local newFreeslot = function(...)
	for i = 1, select('#', ...) do
		local v = select(i, ...)

		local substring = v:sub(1, 4)
		local intValue = oldFreeslot(v)

		if substring:sub(1, 3) == "MT_" then
			currentAddedMobjs = (intValue + 1)
		elseif substring:sub(1, 2) == "S_" then
			currentAddedStates = (intValue + 1)
		elseif substring == "sfx_" then
			currentAddedSfx = intValue
		elseif substring == "SPR_" then
			currentAddedSprites = intValue
		elseif substring == "SPR2" then
			currentAddedSPR2s = intValue
		elseif substring == "SKIN" then
			currentAddedSkinColors = intValue
		end

	end
end

_G["freeslot"] = newFreeslot

local function freeslotcount(player)
	CONS_Printf(player, "Number of mobjs:\t" + (startingMobjNum + currentAddedMobjs) + " out of " + #mobjinfo)
	CONS_Printf(player, "Number of sfx:\t\t" + currentAddedSfx + " out of " + #sfxinfo)
	CONS_Printf(player, "Number of states:\t" + (startingStatesNum + currentAddedStates) + " out of " + #states)
	CONS_Printf(player, "Number of sprites:\t" + currentAddedSprites + " out of " + #sprnames)
	if MODID == juggy.SRB2 then
	CONS_Printf(player, "Number of SPR2s:\t" + currentAddedSPR2s + " out of " + totalSPR2s)
	CONS_Printf(player, "Number of colors:\t" + currentAddedSkinColors + " out of " + MAXSKINCOLORS)
	end
end

COM_AddCommand("freeslotcount", freeslotcount, 1)