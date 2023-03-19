assert(juggy, "Juggy_Definitions.lua must be defined first.")

local CVAR_CanEveryoneRainbow = CV_RegisterVar(
    {
        name = "jug_rainbow_enabled",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

-- rainbow
juggy.CanTheyRainbow = function(player)
    return player.canRainbowChat == true or
        CVAR_CanEveryoneRainbow.value >= 1 or
        juggy.IsPlayerServerOrAdmin(player) == true
end

juggy.RainbowfyMessage = function(message)
    if message == nil then
        return nil
    end

    local colorCodeInt = 130 + P_RandomRange(0, 12)
    local colorCode = ""
    local rainbowMessage = ""

    for char in message:gmatch(".")
        colorCode = string.char(colorCodeInt)
        rainbowMessage = rainbowMessage .. colorCode

        rainbowMessage = rainbowMessage .. char

        colorCodeInt = colorCodeInt + 1;
        if colorCodeInt > 142 then
            colorCodeInt = 130
        end
    end

    return rainbowMessage
end

local function COM_GiveRainbow(player, target)
    local isValid, possiblePlayer = juggy.ValidatePlayerAndTarget(player, target, juggy.commandExplanations.giverainbow)
    if not isValid then return end

    if (juggy.IsPlayerServerOrAdmin(possiblePlayer) or CVAR_CanEveryoneRainbow.value >= 1)
        CONS_Printf(player, "Shouldn't they already be able to do this?")
        return
    end

    -- init just in case it does not exist
    possiblePlayer.canRainbowChat = possiblePlayer.canRainbowChat or false
    -- toggle this value
    possiblePlayer.canRainbowChat = not possiblePlayer.canRainbowChat

    -- notifying
    if (possiblePlayer.canRainbowChat) then
        local rainbowText = "You now have the power of the rainbows! Try '!rb text' in the chat!"
        rainbowText = juggy.RainbowfyMessage(rainbowText)

        chatprintf(possiblePlayer, rainbowText, true) -- rainbows on
        chatprintf(player, "You have given "..possiblePlayer.name.." the power of rainbows.")

        if juggy.CVAR_Logging.value >= 1 then -- logging
            CONS_Printf(server, juggy.JUG_LOGNAME.." - "..player.name..
            " (#"..#player..") has given "..possiblePlayer.name.." (#"..#possiblePlayer..") the power of rainbows.");
        end
    else
        chatprintf(possiblePlayer, "You can no longer rainbow chat. Bummer.", true) -- rainbows off
        chatprintf(player, "You have revoked "..possiblePlayer.name.."'s power of rainbows.")

        if juggy.CVAR_Logging.value >= 1 then -- logging
            CONS_Printf(server, juggy.JUG_LOGNAME.." - "..player.name..
            " (#"..#player..") has revoked "..possiblePlayer.name.." (#"..#possiblePlayer..")'s power of rainbows.");
        end
    end
    
end

local function COM_Rainbow(player, message, ...)
    
    if not player.valid then
        return
    end

    if message == nil then
        CONS_Printf(player, juggy.commandExplanations.rainbow)
        return
    end

    -- init this variable in case it does not exist
    player.canRainbowChat = player.canRainbowChat or false

    if not juggy.CanTheyRainbow(player) then
        CONS_Printf(player, "\x86You can't use rainbow!")
        return
    end

    if type(message) == "int" then
        -- handling number-only messages
        message = tostring(message)
    end

    -- concatenating the rest of the "arguments"
    local extraVariables = select("#", ...)
    for i = 1, extraVariables do
        message = message .. " " .. select(i, ...)
    end

    -- kind of a hack to make it handle
    -- using the chat hook but OH WELL
    COM_BufInsertText(player, "say \"!rb "..message.."\"")
end

COM_AddCommand("giverainbow", COM_GiveRainbow, 1)
COM_AddCommand("rainbow", COM_Rainbow)
COM_AddCommand("rainbowsay", COM_Rainbow)

-- rainbow end