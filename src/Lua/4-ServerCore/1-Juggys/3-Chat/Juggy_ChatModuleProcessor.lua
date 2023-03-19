assert(juggy, "Juggy_Definitions.lua must be defined first.") 

juggy.CHATMOD_INTEROP   = 1
juggy.CHATMOD_FUN       = 2
juggy.CHATMOD_MOD       = 3
juggy.CHATMOD_MODIFYING = 4

juggy.chatModules_Interop   = {}
juggy.chatModules_Mod       = {}
juggy.chatModules_Fun       = {}
juggy.chatModules_Modifying = {}

juggy.createChatModule = function(func, modtype)
    if func == nil then return end

    local tableToAddTo = juggy.chatModules_Fun
    if modtype ~= nil then
        if modtype == juggy.CHATMOD_MOD then
            tableToAddTo = juggy.chatModules_Mod
        elseif modtype == juggy.CHATMOD_INTEROP then
            tableToAddTo = juggy.chatModules_Interop
        elseif modtype == juggy.CHATMOD_MODIFYING then
            tableToAddTo = juggy.chatModules_Modifying
        end
    end

    table.insert(tableToAddTo, func)
end

juggy.processChatModules = function(parameters)

    local chatModuleTables =
    {
        juggy.chatModules_Interop,
        juggy.chatModules_Modifying,
        juggy.chatModules_Mod,
        juggy.chatModules_Fun
    }

    for _, chatModules in ipairs(chatModuleTables) do
        for _, thisModule in ipairs(chatModules) do
            parameters = thisModule(parameters)

            if parameters.returntype ~= nil then
                return parameters
            end
        end
    end

    return parameters
end