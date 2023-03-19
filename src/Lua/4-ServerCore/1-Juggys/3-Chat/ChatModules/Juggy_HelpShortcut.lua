assert(juggy, "Juggy_Definitions.lua must be defined first.") 

juggy.Chat_HelpShortcut = function(parameters)
    if parameters.msgtype ~= juggy.chatType.SayTo and
        (parameters.message:sub(1, 5) == "/help" or
        parameters.message:sub(1, 5) == "!help") then

        local helpString = juggy.GetHelpMessage(parameters.player)
        local tableStrings = juggy.turnCharDelimitedStringIntoTable(helpString, '\n')

        for _, value in pairs(tableStrings) do 
            chatprintf(parameters.player, value)
        end
        
        parameters.returntype = true
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_HelpShortcut, juggy.CHATMOD_MODIFYING)