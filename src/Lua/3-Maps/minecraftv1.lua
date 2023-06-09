--minecraft v1

local ZE = RV_ZESCAPE
local map47_act1 = false
local map47_act2 = false
local map47_act3 = false
local map47_act4 = false

local map47_timer1 = false
local map47_timer2 = false
local map47_timer3 = false
local map47_timer4 = false
local map47_currenttimer = 0

local map47_countup = 0
local map47_countup_toggle = false
local patches = {"MCPLANK", "MCOBS", "MCDOOR", "MCSTONE"}

/*
	Wood Plank
	Obsidian Block
	Iron Door
	Stone Block
*/

ZE.map47netvars = function(net)
	map47_act1 = net($)
	map47_act2 = net($)
	map47_act3 = net($)
	map47_act4 = net($)
	map47_timer1 = net($)
	map47_timer2 = net($)
	map47_timer3 = net($)
	map47_timer4 = net($)
	map47_currenttimer  = net($)
	map47_countup = net($)
	map47_countup_toggle = net($)
	
end

addHook("MapChange", do
        map47_act1 = false
        map47_act2 = false
        map47_act3 = false
        map47_act4 = false
        map47_timer1 = false
        map47_timer2 = false	
		map47_timer3 = false
		map47_timer4 = false
		map47_currenttimer = 0
		map47_countup = 0
		map47_countup_toggle = false
end)
addHook("ThinkFrame", do
	if map47_countup_toggle == true
		map47_countup = $+1
	end
end)

hud.add(function(v,p,c)
	local time = TICRATE*1
	/*
	if map47_countup then
		print(map47_countup)
	end
	*/
	
	local timers = {
		map47_timer1,
		map47_timer2,
		map47_timer3,
		map47_timer4,
	}
	if timers[map47_currenttimer] ~= false and map47_countup_toggle == true then
		local ese = ease.inoutquad(( (FU) / (time) )*(map47_countup), 350, 292)
		local ese2 = ease.inoutquad(( (FU) / (time) )*(map47_countup), 350, 300)
		if (timers[map47_currenttimer]>time) then
			v.draw(ese,100,v.cachePatch(patches[map47_currenttimer]), V_PERPLAYER|V_SNAPTORIGHT)
			v.drawString(ese2,115,timers[map47_currenttimer]/TICRATE, V_PERPLAYER|V_SNAPTORIGHT, "center")
		elseif (timers[map47_currenttimer]<time)
			v.draw(292,100,v.cachePatch(patches[map47_currenttimer]), V_PERPLAYER|V_SNAPTORIGHT)
			v.drawString(300,115,timers[map47_currenttimer]/TICRATE, V_PERPLAYER|V_SNAPTORIGHT, "center")
		end
	end
end,"game")

local function Map47_Part1()
      chatprint("\x8D\Wooden Platform \x80will leave in\x85 30 \x80seconds")
	  S_StartSound(player, sfx_radio)
	  map47_act1 = 1
	  map47_timer1 = 30*TICRATE
	  map47_countup_toggle = true
	  map47_currenttimer = $ + 1
end

local function Map47_Part2()
      chatprint("\x8F\Obsidian Wall \x80will break in\x85 60 \x80seconds")
	  COM_BufInsertText(player, "tunes mc2")
	  S_StartSound(player, sfx_radio)
	  map47_act2 = 1
	  map47_timer2 = 60*TICRATE
	  map47_countup_toggle = true
	  map47_currenttimer = $ + 1
end

local function Map47_Part3()
      chatprint("Iron Door will open in\x82 20 \x80seconds")
	  S_StartSound(player, sfx_radio)
	  map47_act3 = 1
	  map47_timer3 = 20*TICRATE
	  map47_countup_toggle = true
	  map47_currenttimer = $ + 1
end

local function Map47_Part4()
      chatprint("\x86\Stone Platform \x80will leave in\x85 60 \x80seconds")
	  COM_BufInsertText(player, "tunes mc3")
	  S_StartSound(player, sfx_radio)
	  map47_act4 = 1
	  map47_timer4 = 60*TICRATE
	  map47_countup_toggle = true
	  map47_currenttimer = $ + 1
end

local function Map45_Part2Tele1()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, 1280*FRACUNIT, 6272*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map45_Part3Tele1()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -19744*FRACUNIT, 7872*FRACUNIT, 0*FRACUNIT)
       end
	end
end



local function Map45_Part4Tele1()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, 3968*FRACUNIT, -9856*FRACUNIT, 0*FRACUNIT)
       end
	end
end

addHook("ThinkFrame", do
		if map47_act1 == 1
		   map47_timer1 = $-1
		end
	  if map47_timer1 == 15*TICRATE then
	     chatprint("\x8D\Wooden Platform \x80will leave in\x82 15 \x80seconds")
		 S_StartSound(player, sfx_radio)
		elseif map47_timer1 == 5*TICRATE then
		 chatprint("\x8D\Wooden Platform \x80will leave in\x83 5 \x80seconds")
		 S_StartSound(player, sfx_radio)
	    end
       if map47_timer1 == 0 and gamemap == 7 then
		  P_LinedefExecute(46)
		  P_LinedefExecute(48)
		  P_LinedefExecute(51)
		  map47_countup_toggle = false
		  map47_countup = 0
	end
end)

addHook("ThinkFrame", do
		if map47_act2 == 1
		   map47_timer2 = $-1
	end
	  if map47_timer2 == 15*TICRATE then
	     chatprint("\x8F\Obsidian Wall \x80will break in\x82 15 \x80seconds")
		 S_StartSound(player, sfx_radio)
		elseif map47_timer2 == 5*TICRATE then
		 chatprint("\x8F\Obsidian Wall \x80will break in\x83 5 \x80seconds")
		 S_StartSound(player, sfx_radio)
	    end
       if map47_timer2 == 0 and gamemap == 7 then
		  P_LinedefExecute(56)
		  map47_act2 = 0
		  map47_countup_toggle = false
		  map47_countup = 0
	end
	 if map47_timer2 == 1*TICRATE and gamemap == 7 then
	    Map45_Part2Tele1()
    end
end)

addHook("ThinkFrame", do
	if map47_act3 == 1
	   map47_timer3 = $-1
	end
	if map47_timer3 == 10*TICRATE then
		chatprint("Iron Door will open in\x82 10 \x80seconds")
		S_StartSound(player, sfx_radio)
	elseif map47_timer3 == 5*TICRATE then
		chatprint("Iron Door will open in\x83 5 \x80seconds")
		S_StartSound(player, sfx_radio)
	end
	if map47_timer3 == 0 and gamemap == 7 then
		P_LinedefExecute(61)
		map47_act3 = 0
		map47_countup_toggle = false
		map47_countup = 0
	end
	if map47_timer3 == 1*TICRATE and gamemap == 7 then
		Map45_Part3Tele1()
	end
end)

addHook("ThinkFrame", do
		if map47_act4 == 1
		   map47_timer4 = $-1
	end
	  if map47_timer4 == 15*TICRATE then
	     chatprint("\x86\Stone Platform \x80will leave in\x82 15 \x80seconds")
		 S_StartSound(player, sfx_radio)
		elseif map47_timer4 == 5*TICRATE then
		 chatprint("\x86\Stone Platform \x80will leave in\x83 5 \x80seconds")
		 S_StartSound(player, sfx_radio)
	    end
       if map47_timer4 == 0 and gamemap == 7 then
		  P_LinedefExecute(63)
		  map47_act4 = 0
		  map47_countup_toggle = false
		  map47_countup = 0
	end
end)

addHook("PlayerSpawn", function(player)
  if not (map47_act2 == 1) then return end
	if map47_act2 == 1 and player.ctfteam == 1
       P_SetOrigin(player.mo, 1280*FRACUNIT, 6272*FRACUNIT, 0*FRACUNIT)
	else
	    return
    end
end)

addHook("PlayerSpawn", function(player)
  if not (map47_act3 == 1) then return end
	if map47_act3 == 1 and player.ctfteam == 1
       P_SetOrigin(player.mo, -19744*FRACUNIT, 7872*FRACUNIT, 0*FRACUNIT)
	else
	    return
    end
end)

addHook("PlayerSpawn", function(player)
  if not (map47_act4 == 1) then return end
	if map47_act4 == 1 and player.ctfteam == 1
       P_SetOrigin(player.mo, 3968*FRACUNIT, -9856*FRACUNIT, 0*FRACUNIT)
	else
	    return
    end
end)

addHook("LinedefExecute", Map47_Part1, "47ACT1")
addHook("LinedefExecute", Map47_Part2, "47ACT2")
addHook("LinedefExecute", Map47_Part3, "47ACT3")
addHook("LinedefExecute", Map47_Part4, "47ACT4")