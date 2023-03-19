assert(juggy, "Juggy_Definitions.lua must be defined first.")

local CVAR_ForceColor;

local invalidColor = SKINCOLOR_NONE
if MODID == juggy.SRB2KART then -- Kart
    invalidColor = SKINCOLOR_GREEN
end

local isColorBeingForced = false
local colorToForceTo     = nil

local function ForceColorNotification()
    if CVAR_ForceColor.value <= -1 or CVAR_ForceColor.string:lower() == "none" then
        print("The server has lifted the forced color restrictons.")
        isColorBeingForced  = false
        colorToForceTo      = nil
        return
    end

    local intentionalColor = false;
    if MODID == juggy.SRB2KART or (MODID == juggy.SRB2 and SUBVERSION <= 6)  then -- Kart or SRB2 <= 2.2.6 
        if CVAR_ForceColor.value == SKINCOLOR_GREEN or string.lower(CVAR_ForceColor.string) == "green" then
            intentionalColor = true
        end
    elseif MODID == juggy.SRB2 then -- SRB2 2.2.7 RC1 or higher
        if string.lower(CVAR_ForceColor.string) == "none" then
            intentionalColor = true
        end
    end

    local skinColor;
    if MODID == juggy.SRB2 then -- SRB2
        skinColor = R_GetColorByName(CVAR_ForceColor.string)

    elseif MODID == juggy.SRB2KART then -- Kart
        if tonumber(CVAR_ForceColor.string) != nil then
            skinColor = CVAR_ForceColor.value
        else skinColor = juggy.colorNamesTable[CVAR_ForceColor.string:lower()]
        end
    end

    local isNotIntentionalColor = intentionalColor == false
    local isInvalidColor = skinColor == invalidColor

    if (isNotIntentionalColor and isInvalidColor) or
        skinColor == nil then

        CONS_Printf(server, "Please enter a valid color (\"None\" disables).")
        -- isColorBeingForced = false
        -- COM_BufInsertText(server, CVAR_ForceColor.name.." none")
        return
    end
    
    colorToForceTo = skinColor
    -- we assume this color is valid - the hook handles the change
    print("The server is restricting all players to color \""..CVAR_ForceColor.string.."\".")
    isColorBeingForced = true
end

local function AdminTools_PostFrameHandler()
    if not isColorBeingForced then return end
    if colorToForceTo == nil then return end

    for i = 0, (#players-1) do
        local player = players[i]

        if player ~= nil and player.valid then
            if player.skincolor != colorToForceTo then

                player.skincolor = colorToForceTo
                if (player.mo != nil) then
                    player.mo.color = colorToForceTo
                end
            end
        end
    end
end

addHook("ThinkFrame", AdminTools_PostFrameHandler)

CVAR_ForceColor = CV_RegisterVar(
    {
        name = "forcecolor",
        defaultvalue = "None",
        flags = CV_NETVAR|CV_NOINIT|CV_CALL,
        func = ForceColorNotification
    }
)