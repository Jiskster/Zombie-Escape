assert(juggy, "Juggy_Definitions.lua must be defined first.")

-- forcerespawn
local function COM_ForceRespawn(player, target)

    local isValid, possiblePlayer = juggy.ValidatePlayerAndTarget(player, target, juggy.commandExplanations.forcerespawn)
    if not isValid then return end 

    possiblePlayer.playerstate = PST_REBORN

    -- notifying
    if player == possiblePlayer then
        chatprintf(player, "\135You have respawned yourself.")
    else
        chatprintf(player, "\135You have respawned " + possiblePlayer.name)
        chatprintf(possiblePlayer, "\135" + player.name + " has respawned you.")
    end


    if juggy.CVAR_Logging.value >= 1 then -- logging
        local who = "themselves."
        if player != possiblePlayer then
            who = possiblePlayer.name
        end

        CONS_Printf(server, juggy.JUG_LOGNAME.." - "..player.name..
        " (#"..#player..") has force-respawned "..who.." (#"..#possiblePlayer..").");
    end

end

COM_AddCommand("forcerespawn", COM_ForceRespawn, 1)
-- end forcerespawn