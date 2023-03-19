assert(juggy, "Juggy_Definitions.lua must be defined first.")

local CVAR_Greentext = CV_RegisterVar(
    {
        name = "jug_greentext_enabled",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_GreentextForAdmins = CV_RegisterVar(
    {
        name = "jug_greentext_admins",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

juggy.CanTheyGreentext = function(player)
    return CVAR_Greentext.value >= 1 or
        (juggy.IsPlayerServerOrAdmin(player) and CVAR_GreentextForAdmins.value >= 1)
end

juggy.Chat_Greentext = function(parameters)
    -- is greentexting
    local greentextStartsIn = parameters.message:find(">")
    if greentextStartsIn ~= nil then
        if juggy.CanTheyGreentext(parameters.player) then
            parameters.message =
                parameters.message:sub(1, greentextStartsIn-1) + "\131" +
                parameters.message:sub(greentextStartsIn, parameters.message:len())
        end
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_Greentext)