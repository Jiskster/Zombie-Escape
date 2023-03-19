assert(juggy, "Juggy_Definitions.lua must be defined first.")

juggy.CVAR_IsMuteEnabled = CV_RegisterVar(
    {
        name = "jug_mute_enabled",
        defaultvalue = "Off",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_AdminMuteImmunity = CV_RegisterVar(
    {
        name = "jug_mute_immunity",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_AdminShadowMuteImmunity = CV_RegisterVar(
    {
        name = "jug_shadowmute_immunity",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

-- mute and shadowmute
local function COM_ShadowMute(player, target)

    local isValid, possiblePlayer = juggy.ValidatePlayerAndTarget(player, target, juggy.commandExplanations.shadowmute)
    if not isValid then return end 

    if juggy.IsPlayerServerOrAdmin(possiblePlayer) and CVAR_AdminShadowMuteImmunity.value >= 1 then
        CONS_Printf(player, "\x85You cannot shadowmute an admin!")
        return
    end

    -- toggling shadowMuted status
    possiblePlayer.shadowMuted = not possiblePlayer.shadowMuted
    local status = possiblePlayer.shadowMuted

    -- notifying
    if (status) then
        CONS_Printf(player, "\x85You have shadow muted " + possiblePlayer.name + ".") -- shadow mute ON

        if juggy.CVAR_Logging.value >= 1 then -- logging
            CONS_Printf(server, juggy.JUG_LOGNAME.." - "..player.name..
            " (#"..#player..") has shadowmuted "..possiblePlayer.name.." (#"..#possiblePlayer..").");
        end
    else
        CONS_Printf(player, "\x85" + possiblePlayer.name + " is no longer shadow muted.") -- shadow mute OFF

        if juggy.CVAR_Logging.value >= 1 then -- logging
            CONS_Printf(server, juggy.JUG_LOGNAME.." - "..player.name..
            " (#"..#player..") removed "..possiblePlayer.name.."'s shadowmute (#"..#possiblePlayer..").");
        end
    end

end

juggy.COM_MutePlayer = function(player, target)
    if juggy.CVAR_IsMuteEnabled.value <= 0 then
        local reason = "\x85Muting players is disabled right now."
        CONS_Printf(player, reason)
        return false, reason
    end

    local isValid, possiblePlayer = juggy.ValidatePlayerAndTarget(player, target, juggy.commandExplanations.muteplayer)
    if not isValid then return false, possiblePlayer end 

    if juggy.IsPlayerServerOrAdmin(possiblePlayer) and CVAR_AdminMuteImmunity.value >= 1 then
        local reason = "\x85You cannot mute an admin!"
        CONS_Printf(player, reason)
        return false, reason
    end

    juggy.ToggleMutePlayerByIndex(player, possiblePlayer)
    local status = juggy.IsTargetMutedByPlayer(player, possiblePlayer)

    -- notifying
    local result = ""
    if (status) then -- mute ON
        result = "\x85You have muted " + possiblePlayer.name + "."
        CONS_Printf(player, result) 
    else  -- mute off
        result = "\x85" + possiblePlayer.name + " is no longer muted."
        CONS_Printf(player, result)
    end

    if juggy.CVAR_Logging.value >= 1 then -- logging
        local action = "muted"
        if not status then action = "un" + $ end

        CONS_Printf(server, juggy.JUG_LOGNAME.." - "..player.name..
        " (#"..#player..") "..action.." "..possiblePlayer.name.." (#"..#possiblePlayer..").");
    end

    return true, result
end

local function COM_MuteList(player, target)
    if player == nil then return end

    if juggy.CVAR_IsMuteEnabled.value <= 0 and not juggy.IsPlayerServerOrAdmin(player) then
        CONS_Printf(player, "\x85Mute List is disabled right now.")
        return
    end

    local isValid, targetToCheck = false, player
    local whoseList = "Your"

    if target != nil and juggy.IsPlayerServerOrAdmin(player) then 
        isValid, targetToCheck = juggy.ValidatePlayerAndTarget(player, target, juggy.commandExplanations.mutelist)
        if not isValid then return end

        whoseList = "Your"
        if targetToCheck != player then
            whoseList = targetToCheck.name .. "'s"
        end
    end
    
    CONS_Printf(player, "\135"..whoseList.." mute list:")
    local anyoneThere = false

    for i = 0, (#players-1) do
        local playerInLoop = players[i]
        if playerInLoop == nil then continue end

        local isMuted = juggy.IsTargetMutedByPlayer(targetToCheck, playerInLoop)

        local isShadowmuted = false
        if juggy.IsPlayerServerOrAdmin(player) and playerInLoop.shadowMuted != nil then
            isShadowmuted = playerInLoop.shadowMuted
        end
        
        if isMuted or isShadowmuted then
            anyoneThere = true
            local message = "#"..#playerInLoop.." - "..playerInLoop.name

            if isMuted then
                message = "\130(Muted) \128"..message
            end

            if isShadowmuted then 
                message = message.." - \x85SHADOW MUTED"
            end
    
            CONS_Printf(player, message)
        end
    end
    
    if not anyoneThere then
        CONS_Printf(player, "No one muted.")
    end
end

local function COM_TotalMuteList(player, arg1)
    if player == nil then return end

    local textList = ""

    for i = 0, (#players - 1) do
        local targetInLoop = players[i]
        if targetInLoop == nil then continue end

        local hasMuted = false
        local muteList = {}
        for j = 0, (#players - 1) do 
            local playerInLoop = players[j]
            if playerInLoop == nil then continue end

            if juggy.IsTargetMutedByPlayer(targetInLoop, playerInLoop) then
                table.insert(muteList, playerInLoop)
                hasMuted = true
            end
        end

        if hasMuted == false then continue end

        textList = $.."\135"..targetInLoop.name.."'s mute list:\128\n"
        for _, value in pairs(muteList) do

            textList = $.."    #"..#value.." - "..value.name

            if value.shadowMuted then
                textList = $.." \x85(SHADOW MUTED)\128"
            end
            textList = $.."\n"
        end
    end

    if textList == "" then
        textList = "No one has anybody muted."
    end

    if arg1 == "file" and
        player == server and
        juggy.getConsolePlayerOrServer() == server then
            
        local textFile = io.open("mutelist.txt", "w+")

        if textFile == nil then
            CONS_Printf(server, "We don't have enough permissions to write to mutelist.txt")
            return
        end

        textFile:write(textList)
        textFile:close()
        
        CONS_Printf(server, "Wrote mute list to mutelist.txt")
    else
        CONS_Printf(player, textList)
    end
end

COM_AddCommand("muteplayer", juggy.COM_MutePlayer)
COM_AddCommand("playermute", juggy.COM_MutePlayer)

COM_AddCommand("shadowmute", COM_ShadowMute, 1)

COM_AddCommand("mutelist", COM_MuteList)
COM_AddCommand("listmuted", COM_MuteList)

COM_AddCommand("totalmutedlist", COM_TotalMuteList, 1)
COM_AddCommand("totalmutelist", COM_TotalMuteList, 1)
-- end mute and shadowmute