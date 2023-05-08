local ZE = RV_ZESCAPE
local DC = DeltaChars
assert(ZE, "Zombie Escape not loaded! This file should be loaded AFTER Zombie Escape is loaded.")

ZE.CharacterStats["scarf"] = { --may need older version
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT / 19,
    charability = CA_NONE,
    charability2 = CA2_NONE,
    startHealth = 125,
    maxHealth = 125,
    staminacost = 12,
    staminarun = 16*FRACUNIT,
    staminanormal = 27*FRACUNIT,
}
ZE.CharacterStats["serpentine"] = { --non messageboard
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_NONE,
    charability2 = CA2_NONE,
    startHealth = 120,
    maxHealth = 120,
    staminacost = 12,
    staminarun = 16*FRACUNIT,
    staminanormal = 24*FRACUNIT,
}
ZE.CharacterStats["steve"] = {
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT / 19,
    charability = CA_NONE,
    charability2 = CA2_NONE,
    startHealth = 200,
    maxHealth = 325,
    staminacost = 5,
    staminarun = 16*FRACUNIT,
    staminanormal = 24*FRACUNIT,
}
ZE.CharacterStats["oof"] = {
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_NONE,
    charability2 = CA2_NONE,
    startHealth = 120,
    maxHealth = 120,
    staminacost = 12,
    staminarun = 16*FRACUNIT,
    staminanormal = 23*FRACUNIT,
}
ZE.CharacterStats["peppino"] = { --non messageboard
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_SWIM,
    charability2 = CA2_GUNSLINGER,
    startHealth = 110,
    maxHealth = 145,
    staminacost = 10,
    staminarun = 16*FRACUNIT,
    staminanormal = 25*FRACUNIT,
}
ZE.CharacterStats["noise"] = { --non messageboard
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_BOUNCE,
    charability2 = CA2_NONE,
    startHealth = 135,
    maxHealth = 135,
    staminacost = 9,
    staminarun = 16*FRACUNIT,
    staminanormal = 26*FRACUNIT,
    actionspd = 7 * FRACUNIT,
}
ZE.CharacterStats["snick"] = { --non messageboard
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_JUMPTHOK,
    charability2 = CA2_NONE,
    actionspd = 1 * FRACUNIT,
    startHealth = 70,
    maxHealth = 125,
    staminacost = 7,
    staminarun = 16*FRACUNIT,
    staminanormal = 25*FRACUNIT,
}
ZE.CharacterStats["fakepep"] = { --non messageboard
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_DOUBLEJUMP,
    charability2 = CA2_NONE,
    startHealth = 130,
    maxHealth = 150,
    staminacost = 12,
    staminarun = 16*FRACUNIT,
    staminanormal = 24*FRACUNIT,
}
ZE.CharacterStats["motobugze"] = { --non messageboard
    normalspeed = 11 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_DOUBLEJUMP,
    charability2 = CA2_NONE,
    startHealth = 1,
    maxHealth = 1,
    staminacost = 7,
    staminarun = 22*FRACUNIT,
    staminanormal = 24*FRACUNIT,
}
ZE.CharacterStats["chaoze"] = { --non messageboard
    normalspeed = 10 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 17 * FRACUNIT/19,
    charability = CA_DOUBLEJUMP,
    charability2 = CA2_NONE,
    startHealth = 15,
    maxHealth = 50,
    staminacost = 12,
    staminarun = 16*FRACUNIT,
    staminanormal = 23*FRACUNIT,
}
ZE.CharacterStats["xtreme"] = {
    normalspeed = 25 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 16 * FRACUNIT/19,
    charability = CA_NONE,
    charability2 = CA2_NONE,
    startHealth = 105,
    maxHealth = 145,
    staminacost = 13,
    staminarun = 16*FRACUNIT,
    staminanormal = 27*FRACUNIT,
}
ZE.CharacterStats["milne"] = {
    normalspeed = 22 * FRACUNIT,
    runspeed = 100 * FRACUNIT,
    jumpfactor = 12 * FRACUNIT/10,
    charability = CA_NONE,
    charability2 = CA2_NONE,
    charflags = SF_NOJUMPSPIN|SF_NOSKID,
    startHealth = 75,
    maxHealth = 100,
    staminacost = 10,
    staminarun = 16*FRACUNIT,
    staminanormal = 25*FRACUNIT,
}
if DC then --delta chars support
    ZE.CharacterStats["kris"] = {
        normalspeed = 23 * FRACUNIT,
        runspeed = 100 * FRACUNIT,
        jumpfactor = 17 * FRACUNIT / 19,
        charability = CA_NONE,
        charability2 = CA2_NONE,
        startHealth = 60,
        maxHealth = 100,
        staminacost = 13,
        staminarun = 16*FRACUNIT,
        staminanormal = 22*FRACUNIT,
        actionspd = 7 * FRACUNIT,
    }
    ZE.CharacterStats["susie"] = {
        normalspeed = 21 * FRACUNIT,
        runspeed = 100 * FRACUNIT,
        jumpfactor = 17 * FRACUNIT / 19,
        charability = CA_NONE,
        charability2 = CA2_NONE,
        startHealth = 125,
        maxHealth = 125,
        staminacost = 14,
        staminarun = 16*FRACUNIT,
        staminanormal = 22*FRACUNIT,
        actionspd = 7 * FRACUNIT,
    }
    ZE.CharacterStats["ralsei"] = {
        normalspeed = 25 * FRACUNIT,
        runspeed = 100 * FRACUNIT,
        jumpfactor = 17 * FRACUNIT / 19,
        charability = CA_NONE,
        charability2 = CA2_NONE,
        startHealth = 110,
        maxHealth = 110,
        staminacost = 11,
        staminarun = 16*FRACUNIT,
        staminanormal = 28*FRACUNIT,
        actionspd = 7 * FRACUNIT,
    }

    --dont be afraid to check the deltachars source code, just dont reuse hardcoded stuff.
    DC.Ralsei.PACIFY_MIN = 15
    DC.Ralsei.PACIFY_MAX = 15
    DC.Kris.SLIDE_BOOST = 6*FRACUNIT
    DC.Susie.AX_CRASH_HOP = 2*FRACUNIT

    COM_BufAddText(server, "dc_fun off") -- wish there was a way to have this on specific gamemodes
end