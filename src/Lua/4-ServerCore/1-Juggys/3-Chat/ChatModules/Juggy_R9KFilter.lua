assert(juggy, "Juggy_Definitions.lua must be defined first.")

local CVAR_R9K_Filter = CV_RegisterVar(
    {
        name = "jug_r9kfilter_enabled",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_R9K_PunishType = CV_RegisterVar(
    {
        name = "jug_r9kfilter_punishtype",
        defaultvalue = "Block",
        flags = CV_NETVAR,
        PossibleValue = 
        {
            Block       = juggy.punishType.Block,
            ShadowMute  = juggy.punishType.ShadowMute
        }
    }
)

local CVAR_R9K_AdminImmunity = CV_RegisterVar(
    {
        name = "jug_r9kfilter_immunity",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

juggy.Chat_R9KFilter = function(parameters)
    if CVAR_R9K_Filter.value > 0 then
        if parameters.player.jug_r9kmessage ~= nil then
            if not (CVAR_R9K_AdminImmunity.value >= 1 and
                juggy.IsPlayerServerOrAdmin(parameters.player)) and 
                parameters.player.jug_r9kmessage == parameters.message then
                    
                -- if spam filter is also enabled, this also counts.
                -- this is to prevent spamming multiple messages at once.
                if not (juggy.CVAR_SpamFilter_AdminImmunity.value >= 1 and
                    juggy.IsPlayerServerOrAdmin(parameters.player)) and
                    juggy.CVAR_SpamFilter.value >= 1 then
                    parameters.player.jug_spamtime = juggy.CVAR_SpamFilter_SpamTime.value
                end

                if CVAR_R9K_PunishType.value == juggy.punishType.Block then
                    chatprintf(parameters.player, juggy.filterErrors.sameMessage, false)
                    parameters.returntype = true
                    return parameters
                elseif CVAR_R9K_PunishType.value == juggy.punishType.ShadowMute then
                    parameters.shadowmutetype = $ | juggy.shadowMuteType.R9K
                end
            end
        end
        parameters.player.jug_r9kmessage = parameters.message
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_R9KFilter, juggy.CHATMOD_MOD)