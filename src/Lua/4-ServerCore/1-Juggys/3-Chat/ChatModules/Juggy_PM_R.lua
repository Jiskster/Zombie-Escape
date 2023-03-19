assert(juggy, "Juggy_Definitions.lua must be defined first.") 

juggy.Chat_PM_R = function(parameters)
    if parameters.msgtype ~= juggy.chatType.SayTo then
        -- is pming (shortcut)
        if parameters.message:sub(1, 4):lower() == "!pm " or
            parameters.message:sub(1, 4) == "/pm " then

            parameters.message = parameters.message:sub(5, parameters.message:len())

            -- let's get the parameters.target
            local playernum = nil
            
            --[[
                If the first character is a number, assume it's for a node.
                If the first character is ", assume it's a name with spaces, also it will end.
                If the first character is a char, assume it's a name (no spaces).
            ]]
            local firstChar = parameters.message:sub(1, 1);
            if firstChar:byte() >= 48 and firstChar:byte() <= 57 then -- Numeric
                local nextSpaceStartsIn = parameters.message:find(" ")

                playernum = juggy.ProcessTarget(tonumber(parameters.message:sub(1, nextSpaceStartsIn)))
                if type(playernum) == "string" then
                    chatprintf(parameters.player, playernum, false)
                    
                    parameters.returntype = true
                    return parameters
                end

                parameters.message = parameters.message:sub(nextSpaceStartsIn + 1, parameters.message:len())
                if parameters.message:len() == 0 or juggy.isMessageAllWhitespace(parameters.message) then
                    chatprintf(parameters.player, juggy.chatNotices.noPMMessage, false)
                    
                    parameters.returntype = true
                    return parameters
                end

                parameters.msgtype = juggy.chatType.SayTo
                parameters.target = playernum
            elseif firstChar == "\"" then
                local whatIsTheName = parameters.message:sub(2, parameters.message:len())
                local lastQuotePos = whatIsTheName:find("\"")
                if lastQuotePos == nil then
                    chatprintf(parameters.player, juggy.chatNotices.noQuoteClosing, false)
                    
                    parameters.returntype = true
                    return parameters
                end

                whatIsTheName = whatIsTheName:sub(1, lastQuotePos-1)
                playernum = juggy.ProcessTarget(whatIsTheName)
                if type(playernum) == "string" then
                    chatprintf(parameters.player, playernum, false)
                    
                    parameters.returntype = true
                    return parameters
                end

                parameters.message = parameters.message:sub(lastQuotePos+3, parameters.message:len())
                if parameters.message:len() == 0 or juggy.isMessageAllWhitespace(parameters.message) then
                    chatprintf(parameters.player, juggy.chatNotices.noPMMessage, false)
                    
                    parameters.returntype = true
                    return parameters
                end

                parameters.msgtype = juggy.chatType.SayTo
                parameters.target = playernum
            else
                local findNextSpace = parameters.message:find(" ")
                if findNextSpace == nil then
                    chatprintf(parameters.player, juggy.chatNotices.mustDefineMSG, false)
                    
                    parameters.returntype = true
                    return parameters
                end
                local playername = parameters.message:sub(1, findNextSpace-1)
                local playernum = juggy.ProcessTarget(playername)
                if type(playernum) == "string" then
                    chatprintf(parameters.player, playernum, false)
                    
                    parameters.returntype = true
                    return parameters
                end

                parameters.message = parameters.message:sub(findNextSpace+1, parameters.message:len())
                if parameters.message:len() == 0 or juggy.isMessageAllWhitespace(parameters.message) then
                    chatprintf(parameters.player, juggy.chatNotices.noPMMessage, false)
                    
                    parameters.returntype = true
                    return parameters
                end
                
                parameters.msgtype = juggy.chatType.SayTo
                parameters.target = playernum
            end
        elseif parameters.message:sub(1, 3):lower() == "!r " or parameters.message:sub(1, 3):lower() == "/r "then
            if parameters.player.jug_replyingBackTarget == nil or
                not parameters.player.jug_replyingBackTarget.valid then
                
                chatprintf(parameters.player, juggy.chatNotices.noOneToReplyTo, false)
                
                parameters.returntype = true
                return parameters
            end

            parameters.message = parameters.message:sub(4, parameters.message:len())
            if parameters.message:len() == 0 or juggy.isMessageAllWhitespace(parameters.message) then
                chatprintf(parameters.player, juggy.chatNotices.noPMMessage, false)
                
                parameters.returntype = true
                return parameters
            end

            parameters.msgtype = juggy.chatType.SayTo
            parameters.target = parameters.player.jug_replyingBackTarget
        end
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_PM_R, juggy.CHATMOD_MODIFYING)