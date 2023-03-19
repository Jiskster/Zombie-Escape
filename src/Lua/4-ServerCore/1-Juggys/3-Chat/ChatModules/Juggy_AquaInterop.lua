assert(juggy, "Juggy_Definitions.lua must be defined first.")

-- Get aqua's mapvote script for some extra handling
local CVAR_Aqua_MapRankEnabled = CV_FindVar("aqm_enabled")
local tryAgainOnLoad = true

juggy.Chat_AquaVoteInterop = function(parameters)
    -- accounting for different load orders
    if CVAR_Aqua_MapRankEnabled == nil and tryAgainOnLoad == true then
        CVAR_Aqua_MapRankEnabled = CV_FindVar("aqm_enabled")
        tryAgainOnLoad = false
    end

    if CVAR_Aqua_MapRankEnabled ~= nil and
        CVAR_Aqua_MapRankEnabled.value == 1 and 
        parameters.msgtype == juggy.chatType.Say and
        juggy.inIntermission == true then
        local this = parameters.message
        if this == "++" or
            this == "--" or
            this == "==" or
            this == "11" or
            this == "00" then

            parameters.returntype = true
            return parameters
        end
        
    end

    return parameters
end 

juggy.createChatModule(juggy.Chat_AquaVoteInterop, juggy.CHATMOD_INTEROP)