assert(juggy, "Juggy_Definitions.lua must be defined first.")

local function COM_AdminBadge(player, message)
    
    if not player.valid then
        return
    end

    if juggy.IsPlayerServerOrAdmin(player) == false then
        -- message to say this is admins or host only.
        CONS_Printf(player, juggy.targettingErrors.noAdmin)
        return
    end

    -- init this variable in case it does not exist
    -- print(player.hasAdminBadgeOn)
    if player.hasAdminBadgeOn == nil then
        player.hasAdminBadgeOn = true
    end
    player.hasAdminBadgeOn = not $ -- toggling.

    -- no terniaries...
    if player.hasAdminBadgeOn == true then
        CONS_Printf(player, "\x85Toggled on your admin badge!")
    else
        CONS_Printf(player, "\x85Toggled off your admin badge!")
    end
end

COM_AddCommand("adminbadge", COM_AdminBadge, 1)