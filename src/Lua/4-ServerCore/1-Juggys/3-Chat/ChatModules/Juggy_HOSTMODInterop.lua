assert(juggy, "Juggy_Definitions.lua must be defined first.")

-- This is a hostmod-exclusive interaction that hides messages
-- if a vote is ongoing.
juggy.Chat_HOSTMODInterop = function(parameters)
    if (server.HMvtimer ~= nil and server.HMvtimer)
        or (server.HMvresolve ~= nil and server.HMvresolve) then
        local whatsThis = parameters.message:lower()
        if whatsThis == "y" or whatsThis == "n" or 
            whatsThis == "idc" or whatsThis == "dc" or whatsThis == "j" then

            parameters.returntype = true
            return parameters
        end
    end

    if _G.HM_InGame ~= nil and
        parameters.msgtype == juggy.chatType.Say and
        parameters.message:sub(1, 3):lower() == "rtv" then

        parameters.returntype = true
        return parameters -- don't process this
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_HOSTMODInterop, juggy.CHATMOD_INTEROP)