assert(juggy, "Juggy_Definitions.lua must be defined first.")

juggy.wordFilter =
{
    NoLeet      = 1 << 0,
    NoSpaces    = 1 << 1,
    WholeWords  = 1 << 2
}

local CVAR_WordFilter = CV_RegisterVar(
    {
        name = "jug_wordfilter_enabled",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_WordFilter_PunishType = CV_RegisterVar(
    {
        name = "jug_wordfilter_punishtype",
        defaultvalue = "ShadowMute",
        flags = CV_NETVAR,
        PossibleValue = 
        {
            Block       = juggy.punishType.Block,
            ShadowMute  = juggy.punishType.ShadowMute,
            Kick        = juggy.punishType.Kick,
            Ban         = juggy.punishType.Ban,
            Quit        = juggy.punishType.Quit
        }
    }
)

local CVAR_WordFilter_AdminImmunity = CV_RegisterVar(
    {
        name = "jug_wordfilter_immunity",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_WordFilter_UseDefaultBadWordList = CV_RegisterVar(
    {
        name = "jug_wordfilter_usedefaultbadwordlist",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local CVAR_WordFilter_FilterType = CV_RegisterVar(
    {
        name = "jug_wordfilter_filtertype",
        defaultvalue = "No Leet Words, No Spaces",
        flags = CV_NETVAR,
        PossibleValue =
        {
            ["No Leet Words"]            = juggy.wordFilter.NoLeet,
            ["No Spaces"]                = juggy.wordFilter.NoSpaces,
            ["No Leet Words, No Spaces"] = juggy.wordFilter.NoLeet + juggy.wordFilter.NoSpaces,
            ["Whole Words Only"]         = juggy.wordFilter.WholeWords,
            ["No Leet Words, Whole Words Only"] = juggy.wordFilter.WholeWords + juggy.wordFilter.NoLeet,
            --[[
            ["No Spaces, Whole Words Only"] = juggy.wordFilter.WholeWords + juggy.wordFilter.NoSpaces,
            ["No Leet Words, No Spaces, Whole Words Only"] =
                juggy.wordFilter.WholeWords + juggy.wordFilter.NoLeet + juggy.wordFilter.NoSpaces
            ]]
        }
    }
)

local CVAR_WordFilter_TauntSoundOnLeave = CV_RegisterVar(
    {
        name = "jug_wordfilter_tauntsoundonleave",
        defaultvalue = "Off",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local defaultBadWords = 
{
    -- shoutouts to the dark souls 2 banword list
    "trann", -- tranny, trannies
    "fuck trans", -- fuck trans rights
    "transexual", -- transexual, transexuals
    "transsexual", -- typo
    "transvestite", -- transvestite, transvestites
    "transsvestite", -- typo
    -- oh man, so many ways to be racist
    "nig", -- no, I don't genuinely believe you're talking about Nigeria
    "spic",
    -- no, I don't genuinely believe you're "out to get a fag" in the middle of a race
    "fag",
    "rape",
    "raping",
    "rapist",
    "retard",
}

local defaultBadWords_WholeWords =
{
    -- following below exist for the sake of whole words only:
    "tranny",
    "trannies",
    "transexuals",
    "transsexuals",
    "transvestites",
    "transsvestites",
    "nigg",
    "niggs",
    "nigs",
    "nigga",
    "niggah",
    "niggahs",
    "niggas",
    "nigger",
    "niggers",
    "fags",
    "spics",
    "faggot",
    "faggots",
    "rapists",
    "retards",
}

juggy.customWordList = {}

juggy.patternsToMatch =
{
    ["nig"] = "nigh?t?",
    ["spic"] = "spice?y?",
    ["fag"] = "fagr?i?u?",
}

juggy.Chat_WordFilter_AddBadWord = function(player, ...)
    if player == nil then return end

    local extraVariables = select("#", ...)
    for i = 1, extraVariables do
        local badword = select(i, ...)

        if type(badword) == "string" then
            badword = $:lower()

        else continue
        end

        table.insert(juggy.customWordList, badword)

        local logMessage = juggy.JUG_LOGNAME.." - Added following word to the custom ban list: "..badword
        CONS_Printf(player, logMessage)

        if juggy.CVAR_Logging.value >= 1 and player ~= server then
            CONS_Printf(server, logMessage)
        end
    end
end

juggy.Chat_WordFilter_AddBadWord_Pattern = function(player, badword, pattern)
    if player == nil then return end

    table.insert(juggy.customWordList, badword)
    juggy.patternsToMatch[badword] = pattern

    local logMessage = juggy.JUG_LOGNAME.." - Added following word to the custom ban list: \""..badword..
        "\" with the following pattern \""..pattern.."\""
    
    CONS_Printf(player, logMessage)
    if juggy.CVAR_Logging.value >= 1 and player ~= server then
        CONS_Printf(server, logMessage)
    end
end

juggy.Chat_WordFilter_RemoveBadWord = function(player, ...)
    if player == nil then return end

    local extraVariables = select("#", ...)
    for i = 1, extraVariables do
        local badword = select(i, ...)

        if type(badword) == "string" then
            badword = $:lower()

        else continue
        end

        local logMessage = juggy.JUG_LOGNAME.." - Could not find bad word to remove from custom ban list: "..badword
        for key, value in pairs(juggy.customWordList) do
            if value == badword then
                table.remove(juggy.customWordList, key)

                -- check if a Lua expression also exists and remove it.
                if juggy.patternsToMatch[badword] ~= nil then
                    table.remove(juggy.customWordList, badword)
                end

                logMessage = juggy.JUG_LOGNAME.." - Removed following word from the custom ban list: "..badword
                break
            end
        end
        
        CONS_Printf(player, logMessage)

        if juggy.CVAR_Logging.value >= 1 and player ~= server then
            CONS_Printf(server, logMessage)
        end
    end
end

juggy.Chat_WordFilter_ListBadWord = function(player, ...)
    local tablesToCheck = juggy.getBadWordTables()

    local finalTableString = "\130Currently displaying the following banned words:\n\128"

    for _, table in pairs(tablesToCheck) do

        if table == juggy.customWordList then
            if #(juggy.customWordList) > 0 then
                finalTableString = $ + "\t\130The custom banned word list has the following words:\n\128"
            else
                finalTableString = $ + "\t\130The custom banned word list is currently empty.\n\128"
            end
        elseif table == defaultBadWords then
            finalTableString = $ + "\t\130The default banned word list has the following words:\n\128"
        elseif table == defaultBadWords_WholeWords then
            finalTableString = $ + "\t\130The default banned word list has the following whole words:\n\128"
        else
            finalTableString = $ + "\t\130This additional non-official table has the following words:\n\128"
        end

        for _, bannedword in pairs(table) do
            finalTableString = $ + "\t\t" + bannedword + "\n"
        end
    end
    finalTableString = $ + "End of list."

    CONS_Printf(player, finalTableString)
end

COM_AddCommand("jug_wordfilter_removewords", juggy.Chat_WordFilter_RemoveBadWord, 1)
COM_AddCommand("jug_wordfilter_addwords", juggy.Chat_WordFilter_AddBadWord, 1)
COM_AddCommand("jug_wordfilter_addword_pattern", juggy.Chat_WordFilter_AddBadWord_Pattern, 1)
COM_AddCommand("jug_wordfilter_listwords", juggy.Chat_WordFilter_ListBadWord, 1)
-- Aliases:
COM_AddCommand("jug_wordfilter_removeword", juggy.Chat_WordFilter_RemoveBadWord, 1)
COM_AddCommand("jug_wordfilter_addword", juggy.Chat_WordFilter_AddBadWord, 1)
COM_AddCommand("jug_wordfilter_listword", juggy.Chat_WordFilter_ListBadWord, 1)

-- By RetroStation in/for ChatBlaster - used with permission
-- Readapted and remade to fit my coding standards better
local function unL33TMessage(message)
    local messageLower = message:lower()

    local charactersToFindAndReplaceWith =
    {
        ["4"] = "a",
        ["@"] = "a",
        ["3"] = "e",
        ["&"] = "e",
        ["1"] = "i",
        ["!"] = "i",
        ["0"] = "o",
        ["8"] = "b",
        ["9"] = "g",
        ["#"] = "h",
        ["5"] = "s",
        ["$"] = "s",
        ["7"] = "t"
    }

    for key, value in pairs(charactersToFindAndReplaceWith) do  
        if messageLower:find(key) then
            -- specific handling for the special character $
            if key == "$" then key = "%"..key end

            messageLower = $:gsub(key, value)
            -- print(messageLower)
        end
    end

    return messageLower
end

juggy.Chat_WordFilter = function(parameters)
    -- Spam filter-related
    if CVAR_WordFilter.value > 0 then

        local message = juggy.WordFilter_MessageProcessing(parameters.message)
        local isThereMatch = juggy.WordFilter_FilterProcessing(message)

        if not (CVAR_WordFilter_AdminImmunity.value >= 1 and
            juggy.IsPlayerServerOrAdmin(parameters.player)) and
            isThereMatch ~= nil then

            if parameters.bannedword == nil then
                parameters.bannedword = isThereMatch
            end

            -- if spam filter is also enabled, this also counts.
            -- this is to prevent spamming multiple messages at once.
            if not (juggy.CVAR_SpamFilter_AdminImmunity.value >= 1 and
                juggy.IsPlayerServerOrAdmin(parameters.player)) and
                juggy.CVAR_SpamFilter.value >= 1 then
                parameters.player.jug_spamtime = juggy.CVAR_SpamFilter_SpamTime.value
            end

            local punishtype = CVAR_WordFilter_PunishType.value
            local logMessages = 
            {
                [juggy.punishType.Kick]   = "%s - Kicked %s (#%i) for saying a bad word: \"%s\".",
                [juggy.punishType.Ban]    = "%s - Banned %s (#%i) for saying a bad word: \"%s\".",
                [juggy.punishType.Quit]   = "%s - Made %s (#%i) quit for saying a bad word: \"%s\"."
            }

            parameters.returntype, parameters.shadowmutetype =
                juggy.WordFilter_DeterminePunishment(
                    punishtype,
                    parameters.player,
                    isThereMatch,
                    parameters.shadowmutetype,
                    logMessages)

        end
    end

    return parameters
end

juggy.WordFilter_MessageProcessing = function(message)
    message = $:lower()

    if (CVAR_WordFilter_FilterType.value & juggy.wordFilter.NoLeet) then
        message = unL33TMessage(message)
    end

    if (CVAR_WordFilter_FilterType.value & juggy.wordFilter.NoSpaces) then
        message = message:gsub("%s+", "")
    end

    return message
end

juggy.WordFilter_FilterProcessing = function(message)
    local tablesToCheck = juggy.getBadWordTables()

    -- cache this value once
    local processingWholeWords =
        (CVAR_WordFilter_FilterType.value & juggy.wordFilter.WholeWords)

    local messageWordTable, messageWordAmount = nil, nil;
    if processingWholeWords then

        messageWordTable, messageWordAmount =
            juggy.turnCharDelimitedStringIntoTable(message, ' ')

        if messageWordAmount == 0 then -- no message.
            return nil
        end
    end

    for _, table in pairs(tablesToCheck) do
        for _, bannedword in pairs(table) do

            if processingWholeWords then
                -- check how many words compose this banned word
                local bannedWordTable, bannedWordAmount = nil, nil;
                bannedWordTable, bannedWordAmount =
                    juggy.turnCharDelimitedStringIntoTable(bannedword, ' ')
                -- print("banned word: "..bannedword.. " - banned word count: "..bannedWordAmount)

                if bannedWordAmount == 1 then -- do it as normal
                    for _, wholeword in pairs(messageWordTable) do
                        if wholeword == bannedword or (wholeword.."s") == (bannedword.."s") then
                            
                            return bannedword
                        end
                    end
                else -- compare multiples at a time.
                    for i = 1, ((messageWordAmount+1) - bannedWordAmount) do
                        -- print(i.." - "..messageWordTable[i].." == "..bannedWordTable[1])
                        -- we found the first match, compare the rest 
                        if messageWordTable[i] == bannedWordTable[1] then
                            for j = 2, bannedWordAmount do
                                if messageWordTable[i+(j-1)] ~= bannedWordTable[j] then
                                    break
                                end
                                
                                if j == bannedWordAmount then
                                    -- print(bannedword)
                                    return bannedword -- if this does not break early, return
                                end
                            end
                        end
                    end
                end
            else
                local toMatch = bannedword
                if juggy.patternsToMatch[bannedword] ~= nil then
                    toMatch = juggy.patternsToMatch[bannedword]
                elseif (CVAR_WordFilter_FilterType.value & juggy.wordFilter.NoSpaces) then
                    toMatch = toMatch:gsub("%s+", "")
                    bannedword = toMatch
                end

                if message:match(toMatch) == bannedword then
                    -- print("found it " + bannedword)
                    return bannedword
                end
            end

            -- print(message + " = " + bannedword)
        end
    end

    return nil
end

juggy.WordFilter_DeterminePunishment = function(punishtype, player, bannedword, shadowmutetype, logMessages)
    if juggy.CVAR_Logging.value >= 1 and logMessages ~= nil then
        local logMessage = logMessages[punishtype]
        if logMessage ~= nil then
            print(punishtype)
            print(logMessage)
    
            logMessage = string.format($, juggy.JUG_LOGNAME, player.name, #player, bannedword)
            CONS_Printf(server, logMessage)
        end
    end

    if CVAR_WordFilter_TauntSoundOnLeave.value >= 1 and
        punishtype >= juggy.punishType.Kick then
        S_StartSound(nil, sfx_chshot)
    end

    if punishtype == juggy.punishType.Block then
        chatprintf(player, juggy.filterErrors.filteredWord, false)
        return true

    elseif punishtype == juggy.punishType.ShadowMute then
        shadowmutetype = $ | juggy.shadowMuteType.Filtered
        return nil, shadowmutetype

    elseif punishtype == juggy.punishType.Kick then
        COM_BufInsertText(server, "kick "..#player.." \"JJT: Bad Words Used\"")
        return true
    elseif punishtype == juggy.punishType.Ban then
        COM_BufInsertText(server, "ban "..#player.." \"JJT: Bad Words Used\"")
        return true

    elseif punishtype == juggy.punishType.Quit then
        COM_BufInsertText(player, "quit") -- lol, lmao even
        return true
    end
end

juggy.getBadWordTables = function()
    local isDefaultListEnabled = (CVAR_WordFilter_UseDefaultBadWordList.value >= 1)
    local isWholeWordsEnabled = (CVAR_WordFilter_FilterType.value & juggy.wordFilter.WholeWords)

    local tablesToCheck = { juggy.customWordList }

    if isDefaultListEnabled then
        table.insert(tablesToCheck, defaultBadWords)
        if isWholeWordsEnabled then
            table.insert(tablesToCheck, defaultBadWords_WholeWords)
        end
    end

    return tablesToCheck
end

juggy.createChatModule(juggy.Chat_WordFilter, juggy.CHATMOD_MOD)

addHook("NetVars", function(network)

    juggy.customWordList = network(juggy.customWordList)

end)