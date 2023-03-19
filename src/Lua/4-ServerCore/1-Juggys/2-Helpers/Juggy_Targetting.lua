assert(juggy, "Juggy_Definitions.lua must be defined first.")

-- targetting utilities
juggy.isDedicatedServer = function()
    local firstPlayer = players[0]
    return firstPlayer ~= server
end

juggy.doWeHavePlayerLists = function()
    for player in players.iterate do
        if player ~= nil then
            return true
        end
    end

    return false
end

juggy.getConsolePlayerOrServer = function()
    local playerToReturn = consoleplayer
    if consoleplayer == nil then
        playerToReturn = server
    end
    
    return playerToReturn
end

juggy.turnCharDelimitedStringIntoTable = function(string, char)
	if string == nil or string == "" then
		return {}, 0
	end

	local tableVar = {}
	local newString = ""
	local numThingsAdded = 0
    
	for i = 1, #string do
		local c = string:sub(i,i)
		
		if c == char then
            if newString ~= "" then
                table.insert(tableVar, newString)
                numThingsAdded = $ + 1
                newString = ""
            end
		else
			newString = $..c
		end
	end

	if newString ~= "" then
		table.insert(tableVar, newString);
		numThingsAdded = $ + 1
	end

	return tableVar, numThingsAdded
end

juggy.IsPlayerServerOrAdmin = function(player)
    return player == server or IsPlayerAdmin(player)
end

juggy.ProcessTarget = function(target)

    local errorReason = juggy.targettingErrors.unknown

    if juggy.isDedicatedServer() == false and consoleplayer.valid == false then
        return juggy.targettingErrors.dontHaveLists
    end

    -- transform string numbers into actual numbers
    if type(target) == "string" and target:len() < 3 then
        local actualNumber = tonumber(target)
        if actualNumber ~= nil then
            target = actualNumber
        end
    end

    if type(target) == "number" then
        -- player num
        if target == 0 and juggy.isDedicatedServer() then
            return server
        elseif target < #players and players[target] != nil and players[target].valid then
            return players[target]

        else errorReason = juggy.targettingErrors.invalidNumber
        end

    else 
        -- player string, we check for player's names
        -- multiple matches will error out and give a fuzzy match
        if juggy.CVAR_LooseSearch.value >= 1 then
            target = target:lower()
        end

        local playerFound;

        for i = 0, (#players-1) do
            local player = players[i]

            if player == nil then continue end

            local playerName = player.name

            if juggy.CVAR_LooseSearch.value >= 1 then
                playerName = playerName:lower()
            end

            local valid = playerName:find(target, 1, true)

            if valid != nil and valid >= 1 then
                if playerFound == nil then
                    playerFound = player
                else return juggy.targettingErrors.fuzzyMatch
                end
            end
        end

        if playerFound != nil and playerFound.valid then
            return playerFound
        end

        errorReason = juggy.targettingErrors.noMatch
    end

    return errorReason
end


juggy.ValidatePlayerAndTarget = function(player, target, commandExplanation)
    if not player.valid then
        return false
    end

    if target == nil then -- command explanation
        CONS_Printf(player, commandExplanation)
        return false
    end

    local possiblePlayer = juggy.ProcessTarget(target)

    if type(possiblePlayer) == "string" then -- error message handling
        CONS_Printf(player, possiblePlayer)
        return false, possiblePlayer
    end

    return true, possiblePlayer
end