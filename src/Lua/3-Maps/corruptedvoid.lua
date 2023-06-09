--corrupted void

local ZE = RV_ZESCAPE

local map43_act1 = 0
local map43_act2 = 0
local map43_act3 = 0
local map43_tele1 = 0
local map43_tele2 = 0
local map43_triggerDelay = 0
local map43_act1door = false
local map43_act1doorTimer = false
local map43_act2door = false
local map43_act2doorTimer = false

ZE.map43netvars = function(net)
	map43_act1 = net($)
	map43_act2 = net($)
	map43_act3 = net($)
	map43_tele1 = net($)
	map43_triggerDelay = net($)
	map43_act1door = net($)
	map43_act1doorTimer = net($)
	map43_act2door = net($)
	map43_act2doorTimer = net($)
end

local function Map43_Door1()
      chatprint("\x85\ 120 \x80seconds before gates open")
	  S_StartSound(player, sfx_radio)
	  map43_act1door = 1
	  map43_act1doorTimer = 120*TICRATE
end

local function Map43_Door2()
      chatprint("\x85\ 60 \x80seconds before gates open")
	  S_StartSound(player, sfx_radio)
	  map43_act2door = 1
	  map43_act2doorTimer = 60*TICRATE
end

addHook("ThinkFrame", do
		if map43_act1door == 1
		   map43_act1doorTimer = $-1
	end
	  if map43_act1doorTimer == 30*TICRATE then
	     chatprint("\x82\ 30 \x80seconds before gates open")
		 S_StartSound(player, sfx_radio)
		elseif map43_act1doorTimer == 5*TICRATE then
		 chatprint("\x83\ 5 \x80seconds before gates open")
		 S_StartSound(player, sfx_radio)
	    end
       if map43_act1doorTimer == 0 and gamemap == 4 then
		  P_LinedefExecute(27)
	end
end)

addHook("ThinkFrame", do
		if map43_act2door == 1
		   map43_act2doorTimer = $-1
	end
	  if map43_act2doorTimer == 15*TICRATE then
	     chatprint("\x82\ 15 \x80seconds before gates open")
		 S_StartSound(player, sfx_radio)
		elseif map43_act2doorTimer == 5*TICRATE then
		 chatprint("\x83\ 5 \x80seconds before gates open")
		 S_StartSound(player, sfx_radio)
	    end
       if map43_act2doorTimer == 0 and gamemap == 4 then
		  P_LinedefExecute(28)
	end
end)

local function Map43_ObjectionHud1()
       map43_act1 = 1
	if map43_act2 == 1 then
	   map43_act1 = 0
	end
end

local function Map43_ObjectionHud2()
       map43_act2 = 1
	if map43_act3 == 1 then
	   map43_act1 = 0
   end
end

local function Map43_ObjectionHud3()
   if not map43_triggerDelay
       map43_act3 = 1
	   COM_BufInsertText(server, "ze_survtime 90")
	   map43_triggerDelay = 1
	end
end

local function Map43_Teleport1()
       map43_tele1 = 1
      for player in players.iterate
	    if map43_tele1 == 1 and player.ctfteam == 2 then
		   P_SetOrigin(player.mo, -27392*FRACUNIT, 14368*FRACUNIT, 0*FRACUNIT)
       end
	end
end

local function Map43_Teleport2()
       map43_tele2 = 1
      for player in players.iterate
	    if map43_tele2 == 1 and player.ctfteam == 2 then
		   P_SetOrigin(player.mo, -10752*FRACUNIT, 20416*FRACUNIT, 0*FRACUNIT) 
       end
	end
end

hud.add(function(v, player)
	if (gametype ~= GT_ZESCAPE) return end
	if (player.mo and player.mo.valid)
		if (map43_act2 == 1 and player.ctfteam == 2 and gamemap == 4) and not (map43_act2 == 0) and not (map43_act3 == 1)
			v.drawString(16,137,"Press the\x85\ button \x80near the gate and survive against the \x8Bzombies\x80!",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTOLEFT|V_PERPLAYER|V_ALLOWLOWERCASE, "thin")
		end
		if (map43_act1 == 1 and player.ctfteam == 2 and gamemap == 4) and not (map43_act1 == 0) and not (map43_act2 == 1) and not (map43_act3 == 1)
		    v.drawString(16,137,"Press the\x85\ button \x80near the gate and survive against the \x8Bzombies\x80!",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTOLEFT|V_PERPLAYER|V_ALLOWLOWERCASE, "thin")
		end
		if (map43_act3 == 1 and player.ctfteam == 2 and gamemap == 4) and not (map43_act3 == 0)
		    v.drawString(16,137,"Survive\x83\ 90 \x80seconds",V_HUDTRANS|V_SNAPTOTOP|V_SNAPTOLEFT|V_PERPLAYER|V_ALLOWLOWERCASE, "thin")
		end
	end
end)

addHook("LinedefExecute", Map43_ObjectionHud1, "43HUD1")
addHook("LinedefExecute", Map43_ObjectionHud2, "43HUD2")
addHook("LinedefExecute", Map43_ObjectionHud3, "43HUD3")

addHook("LinedefExecute", Map43_Teleport1, "43TELE1")
addHook("LinedefExecute", Map43_Teleport2, "43TELE2")

addHook("LinedefExecute", Map43_Door1, "43DOOR1")
addHook("LinedefExecute", Map43_Door2, "43DOOR2")

addHook("MapChange", do
            map43_act1 = 0
            map43_act2 = 0
			map43_act3 = 0
			map43_tele1 = 0
			map43_tele2 = 0
			map43_triggerDelay = 0
			map43_act1door = false
			map43_act1doorTimer = false
			map43_act2door = false
			map43_act2doorTimer = false
end)