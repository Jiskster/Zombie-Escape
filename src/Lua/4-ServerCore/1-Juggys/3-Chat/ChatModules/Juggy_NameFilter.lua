assert(juggy, "Juggy_Definitions.lua must be defined first.")

-- Note: not a chat module despite the fact that it is in this folder.
-- This just extends from WordFilter a bit.

local CVAR_WorldFilter_FilterNames = CV_RegisterVar(
    {
        name = "jug_wordfilter_filternames",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_WorldFilter_FilterNames_PunishType = CV_RegisterVar(
    {
        name = "jug_wordfilter_filternames_punishtype",
        defaultvalue = "Quit",
        flags = CV_NETVAR,
        PossibleValue = 
        {
            Kick        = juggy.punishType.Kick,
            Ban         = juggy.punishType.Ban,
            Quit        = juggy.punishType.Quit
        }
    }
)

juggy.Chat_NameFilterTrigger_RecentChange = function()
    local punishtype = CVAR_WorldFilter_FilterNames_PunishType.value

    if punishtype ~= juggy.punishType.Quit then
        if juggy.getConsolePlayerOrServer() ~= server then return end -- server should only process this.

        local playersWhoChangedNames = {}
        for i = 0, (#players-1) do
            local player = players[i]
            if player == nil then continue end
    
            if player.jug_previousname == nil then
                player.jug_previousname = player.name
            elseif player.jug_previousname ~= player.name
                player.jug_previousname = player.name
                table.insert(playersWhoChangedNames, player)
            end
        end
    
        if #playersWhoChangedNames > 0 then
            for _, player in pairs(playersWhoChangedNames) do
                juggy.Chat_NameFilter_Process(player.name, player)
            end
        end
    else
        if consoleplayer == nil then return end
        local name = CV_FindVar("name").string
    
        if consoleplayer.jug_previousname ~= name then
            consoleplayer.jug_previousname = name
            juggy.Chat_NameFilter_Process(name, consoleplayer)
        end
    end
end

juggy.Chat_NameFilter_Process = function(name, player)
    name = juggy.WordFilter_MessageProcessing(name)
    local bannedword = juggy.WordFilter_FilterProcessing(name)

    if bannedword == nil return end
    local punishtype = CVAR_WorldFilter_FilterNames_PunishType.value
    local logMessages = 
    {
        [juggy.punishType.Kick]   = "%s - Kicked %s (#%i) for having a bad word in their name: \"%s\".",
        [juggy.punishType.Ban]    = "%s - Banned %s (#%i) for having a bad word in their name: \"%s\".",
        [juggy.punishType.Quit]   = "%s - Made %s (#%i) quit for having a bad word in their name: \"%s\"."
    }
    return juggy.WordFilter_DeterminePunishment(punishtype, player, bannedword, nil, logMessages)
end

addHook("ThinkFrame", function()
    juggy.Chat_NameFilterTrigger_RecentChange()
end)