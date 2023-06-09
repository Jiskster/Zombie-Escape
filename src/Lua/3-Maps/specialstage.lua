--special stage

local ZE = RV_ZESCAPE

local map45_time1 = false
local map45_timer1 = 9999*TICRATE
local map45_time2 = false
local map45_timer2 = 9999*TICRATE
local map45_time3 = false
local map45_timer3 = 9999*TICRATE

ZE.map45netvars = function(net)
	map45_time1 = net($)
	map45_time2 = net($)
	map45_time3 = net($)
	map45_timer1 = net($)
	map45_timer2 = net($)
	map45_timer3 = net($)
end

addHook("MapChange", do
        map45_time1 = false
        map45_timer1 = false
        map45_time2 = false
        map45_timer2 = false
        map45_time3 = false
        map45_timer3 = false		
end)

local function Map45_Objection1()
      chatprint("\x83\Multiplayer Special Stage 1")
	  chatprint("Survive for\x83 60 \x80seconds")
	  map45_time1 = 1
	  map45_timer1 = 60*TICRATE
end

local function Map45_Objection2()
      chatprint("\x81\Multiplayer Special Stage 2")
	  chatprint("Survive for\x83 60 \x80seconds")
	  map45_time2 = 1
	  map45_timer2 = 60*TICRATE
end

local function Map45_Objection3()
      chatprint("\x84\Multiplayer Special Stage 3")
	  chatprint("Survive for\x85 120 \x80seconds")
	  map45_time3 = 1
	  map45_timer3 = 120*TICRATE
end

local function Map45_Objection4()
      chatprint("\x82\Multiplayer Special Stage 4")
	  chatprint("Survive for\x85 120 \x80seconds")
	  COM_BufInsertText(server, "ze_survtime 120")
end

local function Map45_Tele1()
      for player in players.iterate
	   if (player.ctfteam == 2) then
	      P_SetOrigin(player.mo, -29024*FRACUNIT, 31648*FRACUNIT, 0*FRACUNIT) 
       end
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -30304*FRACUNIT, 27040*FRACUNIT, 0*FRACUNIT) 
	   end
	end
end

local function Map45_Tele2()
      for player in players.iterate
	   if (player.ctfteam == 2) then
	      P_SetOrigin(player.mo, -28576*FRACUNIT, 31648*FRACUNIT, 0*FRACUNIT) 
       end
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -30304*FRACUNIT, 27040*FRACUNIT, 0*FRACUNIT) 
	   end
	end
end

local function Map45_Tele3()
      for player in players.iterate
	   if (player.ctfteam == 2) then
	      P_SetOrigin(player.mo, -28128*FRACUNIT, 31648*FRACUNIT, 0*FRACUNIT) 
       end
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -30304*FRACUNIT, 27040*FRACUNIT, 0*FRACUNIT) 
	   end
	end
end

addHook("ThinkFrame", do
		if map45_time1 == 1
		   map45_timer1 = $-1
	end
       if map45_timer1 == 0 and gamemap == 6 then
          Map45_Tele1()
		  P_LinedefExecute(43)
		  P_LinedefExecute(49)
	end
end)

addHook("ThinkFrame", do
		if map45_time2 == 1
		   map45_timer2 = $-1
	end
       if map45_timer2 == 0 and gamemap == 6 then
          Map45_Tele2()
		  P_LinedefExecute(52)
		  P_LinedefExecute(44)
	end
end)

addHook("ThinkFrame", do
		if map45_time3 == 1
		   map45_timer3 = $-1
	end
       if map45_timer3 == 0 and gamemap == 6 then
          Map45_Tele3()
		  P_LinedefExecute(53)
		  P_LinedefExecute(46)
	end
end)

addHook("LinedefExecute", Map45_Objection1, "45ACT1")
addHook("LinedefExecute", Map45_Objection2, "45ACT2")
addHook("LinedefExecute", Map45_Objection3, "45ACT3")
addHook("LinedefExecute", Map45_Objection4, "45ACT4")