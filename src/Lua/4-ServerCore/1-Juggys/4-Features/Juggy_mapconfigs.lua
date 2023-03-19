local CVAR_UsingMapConfigs = CV_RegisterVar(
    {
        name = "jug_mapconfigs_enabled",
        defaultvalue = "Off",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

local lastmap = -1;

local function AdminTools_MapConfigLoader(mapnum)
    if CVAR_UsingMapConfigs.value == 0 then return end
    
    local mapName;
    if lastmap > -1 then -- loading _end config
        mapName = G_BuildMapName(lastmap)

        local mapEndConfigFile = mapName.."_end.cfg"
        COM_BufInsertText(server, "exec "..mapEndConfigFile.." -noerror")
    end

    mapName = G_BuildMapName() -- will return current map
    local mapStartConfigFile = mapName..".cfg"
    COM_BufInsertText(server, "exec "..mapStartConfigFile.." -noerror")

    lastmap = mapnum
end

addHook("MapLoad", AdminTools_MapConfigLoader)