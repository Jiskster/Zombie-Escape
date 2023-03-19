assert(juggy, "Juggy_Definitions.lua must be defined first.")

local function AdminTools_MessageHandler(player, msgtype, target, msg)
    if #msg > 220 then
        -- overflow crash handler
        -- as usual, do the modus operandi of sending the message back to them
        -- the funniest shit is that this will cause *them* to crash instead.
        local name, separator = juggy.GetNameString(player, msgtype)
        local preMsg = juggy.GetPreMessageString(msgtype)
        local completeMessage = preMsg + name + separator + (msg:sub(1, 220))
        if #completeMessage > 220 then
            completeMessage = $:sub(1, 220)
        end
        chatprintf(player, completeMessage, true)
        return true
    end

    --[[
    if not juggy.doWeHavePlayerLists() or not player.valid then
        print("fuck off")
        return false
    end
    ]]

    -- fix for dedicated logging (thanks Lonsfor!)
    --[[
    if juggy.isDedicatedServer() and player == server then
        return false
    end
    ]]

    if msgtype == juggy.chatType.CSay then return false end

    local params =
    {
        player = player,
        msgtype = msgtype,
        target = target,
        message = msg,
        shadowmutetype = 0,
        returntype = nil
    }

    params = juggy.processChatModules(params)
    if params.returntype ~= nil then return params.returntype end

    -- Message creation for PMs/sayto is handled on a per-player
    -- basis and must be created in HandleMessageSending instead of here.
    if params.msgtype ~= juggy.chatType.SayTo then
        local name, separator = juggy.GetNameString(params.player, params.msgtype)
        local preMsg = juggy.GetPreMessageString(params.msgtype)
        params.message = preMsg + name + separator + params.message
    end

    if #params.message > 254 then -- char 255 is newline
        params.message = params.message:sub(1, 254)
    end

    -- finally handle this message
    juggy.HandleMessageSending(params)

    return true
end

addHook("PlayerMsg", AdminTools_MessageHandler)