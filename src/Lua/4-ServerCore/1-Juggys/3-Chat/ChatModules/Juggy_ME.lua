assert(juggy, "Juggy_Definitions.lua must be defined first.") 

juggy.CVAR_JugMeChat = CV_RegisterVar(
    {
        name = "jug_mechat_enabled",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

juggy.Chat_Me = function(parameters)
    -- sorry, can't roleplay in private, get a room
    if juggy.CVAR_JugMeChat.value > 0 then
        if parameters.msgtype ~= juggy.chatType.SayTo and
            (parameters.message:sub(1, 4) == "/me " or
            parameters.message:sub(1, 4) == "!me ") then
            
            parameters.msgtype = juggy.chatType.Me
            parameters.message = parameters.message:sub(5, parameters.message:len());
        end
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_Me)