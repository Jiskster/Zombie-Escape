assert(juggy, "Juggy_Definitions.lua must be defined first.")

juggy.CVAR_SpamFilter = CV_RegisterVar(
    {
        name = "jug_spamfilter_enabled",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

juggy.CVAR_SpamFilter_SpamTime = CV_RegisterVar(
    {
        name = "jug_spamfilter_spamtime",
        defaultvalue = 20,
        flags = CV_NETVAR,
        PossibleValue = CV_Natural
    }
)

local CVAR_SpamFilter_PunishType = CV_RegisterVar(
    {
        name = "jug_spamfilter_punishtype",
        defaultvalue = "Block",
        flags = CV_NETVAR,
        PossibleValue = 
        {
            Block       = juggy.punishType.Block,
            ShadowMute  = juggy.punishType.ShadowMute
        }
    }
)

juggy.CVAR_SpamFilter_AdminImmunity = CV_RegisterVar(
    {
        name = "jug_spamfilter_immunity",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)


juggy.Chat_SpamFilter = function(parameters)
    -- Spam filter-related
    if juggy.CVAR_SpamFilter.value > 0 then
        if parameters.player.jug_spamtime == nil then
            parameters.player.jug_spamtime = 0
        end

        if not (juggy.CVAR_SpamFilter_AdminImmunity.value >= 1 and
            juggy.IsPlayerServerOrAdmin(parameters.player)) and
            parameters.player.jug_spamtime > 0 and -- you're posting too quickly.
            -- this is necesary due to pauses. Time doesn't continue
            -- if the game is paused so if it's equal we can assume it is
            -- paused and messages can continue.
            -- Makes the spam filter not work while paused, obviously,
            -- but sometimes you take Ls, sometimes you take Ws.
            parameters.player.jug_spamtime ~= juggy.CVAR_SpamFilter_SpamTime.value then

            if CVAR_SpamFilter_PunishType.value == juggy.punishType.Block then
                chatprintf(parameters.player, juggy.filterErrors.tooQuickly, false)
                -- ends early, we need to set it here too.
                parameters.player.jug_spamtime = juggy.CVAR_SpamFilter_SpamTime.value

                parameters.returntype = true
                return parameters
            elseif CVAR_SpamFilter_PunishType.value == juggy.punishType.ShadowMute then
                parameters.shadowmutetype = $ | juggy.shadowMuteType.SpamFilter
            end
        end

        parameters.player.jug_spamtime = juggy.CVAR_SpamFilter_SpamTime.value
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_SpamFilter, juggy.CHATMOD_MOD)

local function AdminTools_SpamTimer()
    if juggy.CVAR_SpamFilter.value > 0 then
        for i = 0, (#players-1) do
            local player = players[i]

            if player == nil then continue end

            if player.jug_spamtime == nil then
                player.jug_spamtime = 0
            end
    
            if player.jug_spamtime > 0 then
                player.jug_spamtime = $ - 1
                -- print(player.jug_spamtime)
            end
        end
    end
end

addHook("ThinkFrame", AdminTools_SpamTimer)
addHook("IntermissionThinker", AdminTools_SpamTimer)
if MODID == juggy.SRB2Kart then
    addHook("VoteThinker", AdminTools_SpamTimer)
end