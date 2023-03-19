assert(juggy, "Juggy_Definitions.lua must be defined first.") 

juggy.Chat_MuteShortcut = function(parameters)
    if parameters.msgtype ~= juggy.chatType.SayTo and
        (parameters.message:sub(1, 6) == "/mute " or
        parameters.message:sub(1, 6) == "!mute ") then
        
        local target = parameters.message:sub(7, parameters.message:len())
        local result, message = juggy.COM_MutePlayer(parameters.player, target)
        
        chatprintf(parameters.player, message)
        parameters.returntype = true
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_MuteShortcut, juggy.CHATMOD_MODIFYING)