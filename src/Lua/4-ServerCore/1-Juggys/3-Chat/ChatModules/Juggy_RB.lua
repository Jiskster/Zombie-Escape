assert(juggy, "Juggy_Definitions.lua must be defined first.")

juggy.Chat_Rainbow = function(parameters)
    -- is rainbowing (shortcut)
    if parameters.message:sub(1, 4):lower() == "!rb " or
        parameters.message:sub(1, 4):lower() == "/rb " then
        -- don't out people for not having rainbow powers
        parameters.message = parameters.message:sub(5, parameters.message:len())
        if juggy.CanTheyRainbow(parameters.player) then
            -- gay'st've
            parameters.message = juggy.RainbowfyMessage(parameters.message)
        end
    end

    return parameters
end

juggy.createChatModule(juggy.Chat_Rainbow)