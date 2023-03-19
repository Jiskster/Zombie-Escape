rawset(_G, "juggy", {})

juggy.JUG_ADDONNAME = "Juggy's Jug of Tools"
juggy.JUG_LOGNAME   = "JJT"
juggy.JUG_VERSION   = "v0.7.0"
juggy.JUG_FULLNAME  = juggy.JUG_ADDONNAME + " " + juggy.JUG_VERSION
juggy.JUG_LOGNAME   = juggy.JUG_LOGNAME + " " + juggy.JUG_VERSION

juggy.SRB2KART      = 17
juggy.SRB2          = 18

if _G["sfx_s3kd2s"] == nil then freeslot("sfx_s3kd2s") end
if _G["sfx_chshot"] == nil then freeslot("sfx_chshot") end

juggy.targettingErrors =
{
    invalidNumber   = "\x85No player occupies the node you have provided.\n(If they joined during intermission/map vote, wait until they load into a level.)",
    fuzzyMatch      = "\x85Multiple players match the name you have given.",
    noMatch         = "\x85Input provided does not match any nodes or names.\n(If they joined during intermission/map vote, wait until they load into a level.)",
    dontHaveLists   = "\x85Please load into a level first before you use these commands. (You can't use them right now due to a bug in the game.)",
    noAdmin         = "\x85You are not an administrator or the host, thus you may not use this command.",
    unknown         = "\x85If you ever reach this message, and you can reproduce it, reach JugadorXEI#1815 on Discord. Thank you!"
}

juggy.filterErrors =
{
    sameMessage     = "\x85You just wrote the same thing. Maybe try writing something else?",
    tooQuickly      = "\x85You are sending messages too quickly! Slow down!",
    filteredWord    = "\x85You just said an filtered word! Try again with cleaner language."
}

juggy.chatType =
{
    Say             = 0,
    SayTeam         = 1,
    SayTo           = 2,
    CSay            = 3,
    -- technically non-official
    Me              = 4,
    To              = 5,
}

juggy.chatNotices =
{
    noValidTarget   = "\x85We couldn't discern a valid target from your input!",
    noPMMessage     = "\x85There's no message to send!",
    noOneToReplyTo  = "\x85You have no one to reply to!",
    noQuoteClosing  = "\x85" + "Close your quotations if you're PMing to a name with spaces!",
    mustDefineMSG   = "\x85You must define a message to PM!",
    keepReplying    = "\x82(Keep writing messages to this player using \"!r text\" in the chat!)",
    replyBack       = "\x82(You can use \"!r text\" in the chat to reply back to this player!)"
}

juggy.shadowMuteType =
{
    R9K             = 1 << 0,
    SpamFilter      = 1 << 1,
    Filtered        = 1 << 2
}

juggy.punishType =
{
    Block           = 1,
    ShadowMute      = 2,
    Kick            = 3,
    Ban             = 4,
    Quit            = 5
}

juggy.commandExplanations =
{
    shadowmute  = "\x87Usage: \x80shadowmute [name] \x87or \x80[#node] \x87(write \"nodes\" to know who occupies which node) - toggleable\n"..
    "\x87Shadow Mute a player to disallow messages to be sent to anyone else but themselves.\n"..
    "\x80It may keep the player salty, but they will not flood the chat.",

    muteplayer  = "\x87Usage: \x80muteplayer [name] \x87or \x80[#node] \x87(write \"nodes\" to know who occupies which node) - toggleable\n"..
    "\x87Mute a player to prevent their messages to reach you.",

    forcerespawn = "\x87Usage: \128forcerespawn [name] \x87or \x80[#node] \x87(write \"nodes\" to know who occupies which node)\n"..
    "\135Forces a player to respawn. \128Can be used in occasions where players cannot respawn themselves as a "..
    "result of a softlock.",

    rainbow     = "\x87Usage: \128rainbow [text]\n"..
    "Sends your message with rainbow colors.",

    giverainbow = "\x87Usage: \128giverainbow [name] \x87or \x80[#node] \x87(write \"nodes\" to know who occupies which node) - toggleable\n"..
    "\135Allows an specific player to use rainbow, \128 in case you want to make them stand off.",

    mutelist    = "\x87Usage: \128mutelist"..
    "\135Shows all currently muted players by you\128.",
}

-- cvars
juggy.CVAR_Logging = CV_RegisterVar(
    {
        name = "jug_logging",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)

juggy.CVAR_LooseSearch = CV_RegisterVar(
    {
        name = "jug_targetting_loose",
        defaultvalue = "On",
        flags = CV_NETVAR,
        PossibleValue = CV_YesNo
    }
)