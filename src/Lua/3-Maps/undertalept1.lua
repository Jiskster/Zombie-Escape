--undertale pt 1

freeslot(
"sfx_utdgr",
"sfx_utbtl",
"sfx_fwtlk",
"sfx_trtlk",
"sfx_utesc",
"sfx_utdi"
)

sfxinfo[sfx_utdi] = {
        flags = SF_X8AWAYSOUND|SF_X4AWAYSOUND|SF_X2AWAYSOUND
}

local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.UTWin = function()
	for player in players.iterate do
	  if player.mo and player.mo.valid
	     if not ZE.winTriggerDelay
	        if (gametype == GT_ZESCAPE) and not (ZE.teamWin == 1)
			ZE.winTriggerDelay = 1
			ZE.survKill(player)
			ZE.SurvInv(player)
			ZE.Win(team)
			COM_BufInsertText(player, "tunes utsrv")
			   end
			end
		end
	end
end

ZE.DeathSoundUT = function(player)
   if player.mo and player.mo.valid
      player.utdie = $ or 0
       if (player.mo.state == S_PLAY_DEAD)
	    and not (leveltime < CV.waittime) 
		  and not (player.utdie == 1)
           S_StartSound(player.mo, sfx_utdi)
		   player.utdie = 1
      end
	  if (player.mo.state != S_PLAY_DEAD)
	      player.utdie = 0
	  end
   end
end

addHook("ThinkFrame", function()
   if not (gamemap == 8) then return end
	for player in players.iterate
      ZE.DeathSoundUT(player)
   end
end)

addHook("ThinkFrame", do
    for player in players.iterate
	  if ZE.survcount < 1 and gamemap == 8 and not (leveltime < CV.waittime) then
	   COM_BufInsertText(player, "tunes utzm")
	   end
	end
end)

addHook("LinedefExecute", ZE.UTWin, "UTWIN")

local map48_door1 = false
local map48_timer1 = false

local map48_Prebattle1 = false
local map48_timer2 = false

local map48_battle1 = false
local map48_timer3 = false

local map48_Prebattle2 = false
local map48_timer4 = false

local map48_battle2 = false
local map48_timer5 = false

ZE.map48netvars = function(net)
	map48_door1 = net($)
	map48_timer1 = net($)
	map48_timer2 = net($)
	map48_timer3 = net($)
	map48_timer4 = net($)
	map48_timer5 = net($)
	map48_Prebattle1 = net($)
	map48_Prebattle2 = net($)
	map48_battle1 = net($)
	map48_battle2 = net($)
end

addHook("MapChange", do
        map48_door1 = false
		map48_Prebattle1 = false
		map48_battle1 = false
		map48_Prebattle2 = false
		map48_battle2 = false
        map48_timer1 = false
		map48_timer2 = false
		map48_timer3 = false
		map48_timer4 = false
		map48_timer5 = false
end)

addHook("MapLoad", do
        map48_door1 = false
		map48_Prebattle1 = false
		map48_battle1 = false
		map48_Prebattle2 = false
		map48_battle2 = false
        map48_timer1 = false
		map48_timer2 = false
		map48_timer3 = false
		map48_timer4 = false
		map48_timer5 = false
end)

local function map48_floweytalk()
      chatprint("\x82\<Flowey>\x80 Hey, why are you in a hurry- Wait!")
	  S_StartSound(player, sfx_fwtlk)
end

local function map48_floweytalk2()
      chatprint("\x82\<Flowey>\x80 Hmm you didn't die. This is for now. Hehehe")
	  S_StartSound(player, sfx_fwtlk)
end

local function map48_door1()
      chatprint("\x89\Door \x80will open in\x85 60 \x80seconds")
	  S_StartSound(player, sfx_utdgr)
	  map48_door1 = 1
	  map48_timer1 = 60*TICRATE
end

local function map48_Prebattle1()
      chatprint("\x8B\Zombies \x80will appear in\x82 20 \x80seconds")
	  S_StartSound(player, sfx_utdgr)
	  map48_Prebattle1 = 1
	  map48_timer2 = 20*TICRATE
end

local function map48_Startbattle1()
      chatprint("Survive for\x85 60 \x80seconds")
	  S_StartSound(player, sfx_utdgr)
	  map48_battle1 = 1
	  map48_timer3 = 60*TICRATE
end

local function map48_Startbattle2()
	  map48_battle2 = 1
	  map48_timer5 = 120*TICRATE
end

local function Map48_BattleTele1Surv()
      for player in players.iterate
	   if (player.ctfteam == 2) then
	      P_SetOrigin(player.mo, -7168*FRACUNIT, -6272*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map48_BattleTele1Zm()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -7168*FRACUNIT, -6272*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map48_BattleTele2Surv()
      for player in players.iterate
	   if (player.ctfteam == 2) then
	      P_SetOrigin(player.mo, 6976*FRACUNIT, 3008*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map48_BattleTele2Zm()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, 5056*FRACUNIT, -2880*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map48_BattleTele3Surv()
      for player in players.iterate
	   if (player.ctfteam == 2) then
	      P_SetOrigin(player.mo, -2368*FRACUNIT, -5504*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map48_BattleTele3Zm()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -1088*FRACUNIT, -4736*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map48_BattleTele4Surv()
      for player in players.iterate
	   if (player.ctfteam == 2) then
	      P_SetOrigin(player.mo, 17280*FRACUNIT, 7104*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map48_BattleTele4Zm()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, 5056*FRACUNIT, -2880*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function map48_Prebattle2()
	  map48_Prebattle2 = 1
	  map48_timer4 = 20*TICRATE
end

addHook("ThinkFrame", do
		if map48_door1 == 1
		   map48_timer1 = $-1
	end
	  if map48_timer1 == 30*TICRATE then
	     chatprint("\x89\Door \x80will open in\x82 30 \x80seconds")
		 S_StartSound(player, sfx_radio)
		elseif map48_timer1 == 15*TICRATE then
		 chatprint("\x89\Door \x80will open in\x85 15 \x80seconds")
		 S_StartSound(player, sfx_radio)
		elseif map48_timer1 == 5*TICRATE then
		 chatprint("\x89\Door \x80will open in\x83 5 \x80seconds")
		 S_StartSound(player, sfx_radio) 
	    end
       if map48_timer1 == 0 and gamemap == 8 then
		  P_LinedefExecute(31)
		  S_ChangeMusic("UTRNS",true,player)
	end
end)


addHook("ThinkFrame", do
		if map48_Prebattle1 == 1
		   map48_timer2 = $-1
	end
       if map48_timer2 == 6*TICRATE and gamemap == 8 then
		  S_StartSound(player, sfx_utbtl)
	end
       if map48_timer2 == 5*TICRATE and gamemap == 8 then
		  Map48_BattleTele1Surv()
	end
       if map48_timer2 == 0*TICRATE and gamemap == 8 then
		  Map48_BattleTele1Zm()
	end	
end)

addHook("ThinkFrame", do
		if map48_battle1 == 1
		   map48_timer3 = $-1
	end
	  if map48_timer3 == 30*TICRATE then
	     chatprint("\x82\ 30 \x80seconds remaining")
		 S_StartSound(player, sfx_radio)
		elseif map48_timer3 == 15*TICRATE then
		 chatprint("\x82\ 15 \x80seconds remaining")
		 S_StartSound(player, sfx_radio)
		elseif map48_timer3 == 5*TICRATE then
		 chatprint("\x83\ 5 \x80seconds remaining")
		 S_StartSound(player, sfx_radio) 
	    end
       if map48_timer3 == 1*TICRATE and gamemap == 8 then
		   S_StartSound(player, sfx_utesc)
	end
       if map48_timer3 == 1*TICRATE and gamemap == 8 then
		  S_ChangeMusic("UTRNS",true,player)
		  Map48_BattleTele2Surv()
		  map48_battle1 = false
		  map48_timer3 = false
	end
       if map48_timer3 == 1*TICRATE and gamemap == 8 then
		  Map48_BattleTele2Zm()
		  map48_battle1 = false
		  map48_timer3 = false
	end
  if gamemap != 8 then return end
 if map48_battle1 == 1 then
    S_ChangeMusic("UTBTL2",true,player)
	end
end)

addHook("ThinkFrame", do
		if map48_Prebattle2 == 1
		   map48_timer4 = $-1
	end
	  if map48_timer4 == 19*TICRATE then
	     chatprint("\x89\<Toriel>\x80 You want to leave so badly? Hmph...")
		 S_StartSound(player, sfx_trtlk)
		elseif map48_timer4 == 15*TICRATE then
		 chatprint("\x89\<Toriel>\x80 You are just like the others. There is only one solution to this")
		 S_StartSound(player, sfx_trtlk)
		elseif map48_timer4 == 5*TICRATE then
		 chatprint("\x89\<Toriel>\x80 Prove yourself... Prove to me you are strong enough to survive.")
		 S_StartSound(player, sfx_trtlk)
		elseif map48_timer4 == 1*TICRATE then
		 S_StartSound(player, sfx_utbtl)
	    end
       if map48_timer4 == 0 and gamemap == 8 then
		  Map48_BattleTele3Surv()
		  Map48_BattleTele3Zm()
		  COM_BufInsertText(server, "rh_enable 0")
	end
end)

addHook("ThinkFrame", do
		if map48_battle2 == 1
		   map48_timer5 = $-1
	end
	for player in players.iterate
	  if player.mo and player.mo.valid
	  if map48_timer5 == 119*TICRATE
	  player.rings = 1
	  player.mo.health = 1
	  player.mo.maxHealth = 1
	     end
	  end
   end
end)

addHook("PlayerSpawn", function(player)
  if not (map48_battle2 == 1) then return end
	if map48_battle2 == 1 and player.ctfteam == 1
       P_SetOrigin(player.mo, -1088*FRACUNIT, -4736*FRACUNIT, 0*FRACUNIT)
	else
	    return
    end
end)

addHook("LinedefExecute", map48_floweytalk, "FWTLK1")
addHook("LinedefExecute", map48_floweytalk2, "FWTLK2")

addHook("LinedefExecute", map48_door1, "48DR1")
addHook("LinedefExecute", map48_Prebattle1, "48BTL1")
addHook("LinedefExecute", map48_Startbattle1, "48BTL2")
addHook("LinedefExecute", map48_Prebattle2, "48PRE2")
addHook("LinedefExecute", map48_Startbattle2, "48BTLT")