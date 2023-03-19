assert(juggy, "Juggy_Definitions.lua must be defined first.")

local CVAR_CanAdminsReadShadowMute = CV_RegisterVar(
    {
        name = "jug_shadowmute_adminread",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

-- chat related functions
-- mute helpers
juggy.ToggleMutePlayerByIndex = function(player, target)
    if player == nil or target == nil or
        not player.valid or not target.valid then
        return false
    end
    
    player.mutedPlayers = player.mutedPlayers or 0
    -- print("Before: "..player.mutedPlayers)
    -- counting from least significant bit
    local targetMask = (1 << (#players - #target))
    -- print("targetMask: "..player.mutedPlayers)
    -- print("target num: "..#target)
    -- toggling bit that represents player muted
    player.mutedPlayers = player.mutedPlayers ^^ targetMask

    --print("After: "..player.mutedPlayers)
end

juggy.IsTargetMutedByPlayer = function(player, target)
    if player == nil or target == nil or
        not player.valid or not target.valid then
        return false
    end

    player.mutedPlayers = player.mutedPlayers or 0

    if (player.mutedPlayers & (1 << (#players - #target))) then
        -- print(target.name + " has " + player.name + " muted.")
        return true
    end

    -- print(target.name + " does not have " + player.name + " muted.")
    return false
end
-- end mute helpers

juggy.GetNameString = function(player, type)

    -- Contructing the chat message
    local chatColor = "\128"
    if type == juggy.chatType.Say or
        type == juggy.chatType.SayTeam or
        type == juggy.chatType.Me then

        chatColor = juggy.GetChatColorFromSkinColor(SKINCOLOR_GREY)
        
        if juggy.isDedicatedServer() and player == server then
            chatColor = "\x83"
        elseif not player.spectator then
            chatColor = juggy.GetChatColorFromSkinColor(player.skincolor)
        end

    elseif type == juggy.chatType.SayTo or
            type == juggy.chatType.To then -- No chat color, PreMessageString handles this.
        chatColor = ""
    end

    -- TODO: Hiding this if you're host/admin
    local adminIcon = ""
    if juggy.IsPlayerServerOrAdmin(player) then
        if not (type == juggy.chatType.SayTo or
            type == juggy.chatType.To) then
            if (player.hasAdminBadgeOn == nil and IsPlayerAdmin(player)) or 
                player.hasAdminBadgeOn == true then
                adminIcon = "\131" + "@" + chatColor

            elseif player == server then adminIcon = "\131" + "~" + chatColor
            end

        end
    end

    local sepLeft = "<"
    local sepRight = ">"
    if type == juggy.chatType.Me then
        sepLeft = ""
        sepRight = ""
    end

    local playerName = player.name
    if juggy.isDedicatedServer() and player == server then
        playerName = "SERVER"
    end

    local name = chatColor + sepLeft + adminIcon + playerName + sepRight

    local separator = "\128 "
    if player.spectator or
        type == juggy.chatType.SayTo or
        type == juggy.chatType.To then
        separator = " "
    end

    return name, separator
end

juggy.GetPreMessageString = function(type)
    if type == juggy.chatType.Me then
        return "* "
    elseif type == juggy.chatType.SayTo
        return "\x82[PM]"
    elseif type == juggy.chatType.To
        return "\x82[TO]"
    end

    return ""
end

juggy.GetDefaultTextChatColor = function(player, msgtype)
    if player.spectator then
        return "\x86"
    elseif msgtype ~= nil and
        (msgtype == juggy.chatType.SayTo or
        msgtype == juggy.chatType.To) then

        return "\x82"
    else
        return "\128"
    end
end

juggy.isMessageAllWhitespace = function(message)
    if message == nil then return nil end

    for c in message:gmatch(".") do 
        if c:byte() ~= 32 then -- whitespace char
            return false
        end
    end

    return true
end

juggy.HandleMessageSending = function(params)
    -- when the player is shadowmuted, their message only goes back to them.
    -- nobody will be able to read it but them, except server and admins
    if params.shadowmutetype == nil then params.shadowmutetype = 0 end
    local ourConsolePlayer = juggy.getConsolePlayerOrServer()
    -- print("shadowmuted status: " + shadowMuted)
    local isShadowMuted = params.player.shadowMuted or params.shadowmutetype > 0

    if isShadowMuted and params.target == nil then      
        -- we check if the player muted themself because you can apparently do that
        -- and I find it too funny to fix it

        if juggy.IsTargetMutedByPlayer(params.player, params.player) == false then
            chatprintf(params.player, params.message, true)
        end
        
        if CVAR_CanAdminsReadShadowMute.value >= 1 then
            if juggy.IsPlayerServerOrAdmin(ourConsolePlayer) and
                not juggy.IsTargetMutedByPlayer(ourConsolePlayer, params.player) then

                -- Which type of mute is this?
                local punishText = "\x85(MUTED SOMEHOW) "
                if params.player.shadowMuted then
                    punishText = "\x85(SHADOW MUTED) "
                elseif (params.shadowmutetype & juggy.shadowMuteType.R9K) == juggy.shadowMuteType.R9K then
                    punishText = "\x85(MUTED BY R9K) "
                elseif (params.shadowmutetype & juggy.shadowMuteType.Filtered) == juggy.shadowMuteType.Filtered then
                    punishText = "\x85(FILTERED WORD) "
                elseif (params.shadowmutetype & juggy.shadowMuteType.SpamFilter) == juggy.shadowMuteType.SpamFilter then
                    punishText = "\x85(SPAMMING) "
                end

                if params.bannedword ~= nil then
                    local index = params.message:find(params.bannedword)

                    if index ~= nil then
                        params.message =
                            params.message:sub(1, index - 1) + "\x85" +
                            params.message:sub(index, index + params.bannedword:len()) +
                            juggy.GetDefaultTextChatColor(params.player) + 
                            params.message:sub(index + params.bannedword:len() + 1, params.message:len())
                    end
                end

                chatprintf(ourConsolePlayer, punishText..params.message, false)
            end
        end
    elseif params.target ~= nil then
        local name, separator = juggy.GetNameString(params.target, juggy.chatType.To)
        local preMsg = juggy.GetPreMessageString(juggy.chatType.To)
        chatprintf(params.player, (preMsg + name + separator + params.message), true)

        if params.player.jug_replyingBackTarget == nil or
            params.player.jug_replyingBackTarget ~= params.target then

            chatprintf(params.player, juggy.chatNotices.keepReplying, false)
            params.player.jug_replyingBackTarget = params.target
        end

        if isShadowMuted == false and juggy.IsTargetMutedByPlayer(params.target, params.player) == false then
            local name, separator = juggy.GetNameString(params.player, juggy.chatType.SayTo)
            local preMsg = juggy.GetPreMessageString(juggy.chatType.SayTo)
            chatprintf(params.target, (preMsg + name + separator + params.message), true)

            if params.target.jug_replyingBackTarget == nil or
                params.target.jug_replyingBackTarget ~= params.player then

                chatprintf(params.target, juggy.chatNotices.replyBack, false)
                params.target.jug_replyingBackTarget = params.player
            end
        end 
    else
        -- don't send message to them if they have this person muted
        if juggy.IsTargetMutedByPlayer(ourConsolePlayer, params.player) == false then
            chatprint(params.message, true)

            if params.pinged ~= nil then
                for _, pingedplayer in pairs(params.pinged) do
                    if ourConsolePlayer == pingedplayer then
                        S_StartSound(nil, sfx_s3kd2s)
                        break
                    end
                end
            end
            
        end
    end
end
-- end chat functions
