assert(juggy, "Juggy_Definitions.lua must be defined first.")

juggy.GetHelpMessage = function(player)
    local message = "These are the following aliases available to you:\n"
    local aliasesHelp = ""
        
    -- /pm and /r are always available
    aliasesHelp = $ + "\135!pm [player] [message]\128 - Alias of \"sayto\", allows you to send a " +
        "private message towards a player.\n"
    aliasesHelp = $ + "\135!r [message]\128 - Alias of \"sayto\", allows you to reply to " +
        "a player who has recently sent you a private message.\n"
    
    if juggy.CVAR_JugMeChat.value >= 1 then
        aliasesHelp = $ + "\135!me [message]\128 - Allows you to textually perform actions in the " + 
            "chat.\n"
    end
    
    if juggy.CanTheyRainbow(player) then
        aliasesHelp = $ + "\135!rb [message]\128 - Allows you to paint your message in pretty colors.\n"
    end
    
    if juggy.CanTheyGreentext(player) then
        aliasesHelp = $ + "\135>[anywhere in a message]\128 - Colors your message green, for replying to " +
            "others.\n"
    end
    
    if juggy.CVAR_AtSomeone.value >= 1 then
        aliasesHelp = $ + "\135@[name or node]\128 - Allows you to get someone's attention in the chat, " +
            "coloring their name and playing a sound on their end.\n"
    end
    
    if juggy.CVAR_IsMuteEnabled.value >= 1  then
        aliasesHelp = $ + "\135!mute [name or node]\128 - Allows you to mute somebody in the chat, " +
            "preventing you from seeing their messages.\n"
    end

    return (message..aliasesHelp)
end

juggy.GetHelp = function(player)
    CONS_Printf(player, juggy.GetHelpMessage(player))
end

COM_AddCommand("jughelp", juggy.GetHelp)