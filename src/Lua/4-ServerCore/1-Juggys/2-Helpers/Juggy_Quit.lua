assert(juggy, "Juggy_Definitions.lua must be defined first.")

-- hooks
local function AdminTools_QuitHandler(player, reason)

    player.shadowMuted = false
    player.canRainbowChat = false

    -- if a player leaves, other players who had him muted
    -- probably don't want to keep muting the person who's in the
    -- same node as the leaver
    for i = 0, (#players - 1) do
        local otherPlayers = players[i]
        if otherPlayers == nil then continue end

        if juggy.IsTargetMutedByPlayer(otherPlayers, player) then
            juggy.ToggleMutePlayerByIndex(otherPlayers, player)
        end
    end 
end

-- hooking
addHook("PlayerQuit", AdminTools_QuitHandler)