assert(juggy, "Juggy_Definitions.lua must be defined first.")

juggy.CVAR_AtSomeone = CV_RegisterVar(
    {
        name = "jug_at_enabled",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

juggy.Chat_AtSomeone = function(parameters)
    -- @ someone
    if juggy.CVAR_AtSomeone.value <= 0 then return parameters end

    local messageParse = parameters.message

    repeat
    local atStartsAt = messageParse:find("@")
    local success = false

    if atStartsAt ~= nil then
        -- is next character whitespace?
        if parameters.message:sub(atStartsAt+1, atStartsAt+1):byte() ~= 32 then

            local nameToTestAgainst =
                parameters.message:sub(atStartsAt+1,
                parameters.message:len())
            local nextSpace = nameToTestAgainst:find(" ")

            if nextSpace == nil then
                nextSpace = parameters.message:len()
            end

            nameToTestAgainst = $:sub(1, nextSpace-1)
            local target = juggy.ProcessTarget(nameToTestAgainst)

            -- print("nameToTestAgainst: " + nameToTestAgainst)

            if type(target) ~= "string" then
                -- print("proper target")
                -- this is just so the < > don't show up
                local finalName = juggy.GetNameString(target, juggy.chatType.Me)

                local preMsg = parameters.message:sub(1, atStartsAt-1)
                local postMsg =
                    parameters.message:sub(atStartsAt+nextSpace,
                    parameters.message:len())

                -- which separator?
                local afterNameColor =
                    juggy.GetDefaultTextChatColor(parameters.player, parameters.msgtype)

                parameters.message = preMsg + finalName + afterNameColor + postMsg
                
                if parameters.pinged == nil then
                    parameters.pinged = {}
                end
                table.insert(parameters.pinged, target)

                success = true
            end
        end 

        if success then
            messageParse = parameters.message -- reparse this
        else
            messageParse = messageParse:sub(atStartsAt + 1, messageParse:len())
        end
        -- print("messageParse: " + messageParse)
    end

    until atStartsAt == nil 

    return parameters
end

juggy.createChatModule(juggy.Chat_AtSomeone, juggy.CHATMOD_MODIFYING)