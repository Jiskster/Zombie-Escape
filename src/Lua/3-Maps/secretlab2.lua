--Secret Lab 2

local ZE = RV_ZESCAPE

local map42_door1 = false
local map42_door1Timer = 9999*TICRATE
local map42_door2 = false
local map42_door2Timer = 9999*TICRATE
local map42_door3 = false
local map42_door3Timer = 9999*TICRATE
local map42_door4 = false
local map42_door4Timer = 9999*TICRATE
local map42_door5 = false
local map42_door5Timer = 9999*TICRATE

ZE.map42netvars = function(net)
	map42_door1 = net($)
	map42_door2 = net($)
	map42_door3 = net($)
	map42_door4 = net($)
	map42_door5 = net($)
	map42_door1Timer = net($)
	map42_door2Timer = net($)
	map42_door3Timer = net($)
	map42_door4Timer = net($)
	map42_door5Timer = net($)
end

addHook("MapChange", do
        map42_door1 = false
        map42_door1Timer = false
        map42_door2 = false
        map42_door2Timer = false
        map42_door3 = false
        map42_door3Timer = false
        map42_door4 = false
        map42_door4Timer = false
        map42_door5 = false
        map42_door5Timer = false
end)

local function Map42_Objection1()
      chatprint("\x85\Elevator \x80opens in\x82 20 \x80seconds")
	  map42_door1 = 1
	  map42_door1Timer = 20*TICRATE
end

local function Map42_Objection2()
      chatprint("\x85\Elevator \x80opens in\x82 30 \x80seconds")
	  map42_door2 = 1
	  map42_door2Timer = 30*TICRATE
end

local function Map42_Objection3()
      chatprint("\x85\Doors \x80will open in\x82 25 \x80seconds")
	  map42_door3 = 1
	  map42_door3Timer = 25*TICRATE
end

local function Map42_Objection4()
      chatprint("\x85\Gates \x80will open in\x83 15 \x80seconds")
	  map42_door4 = 1
	  map42_door4Timer = 15*TICRATE
end

local function Map42_Objection5()
      chatprint("\x85\The Final Gate \x80will open in\x85 60 \x80seconds")
	  map42_door5 = 1
	  map42_door5Timer = 60*TICRATE
end

local function Map42_Tele1()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -23104*FRACUNIT, 10500*FRACUNIT, 0*FRACUNIT) 
       end
	end
end

local function Map42_Tele2()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -22530*FRACUNIT, 11040*FRACUNIT, 0*FRACUNIT) 
       end
	end
end

local function Map42_Tele3()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -20034*FRACUNIT, 10114*FRACUNIT, 0*FRACUNIT) 
       end
	end
end

local function Map42_Tele4()
      for player in players.iterate
	   if (player.ctfteam == 1) then
	      P_SetOrigin(player.mo, -20032*FRACUNIT, 11009*FRACUNIT, 0*FRACUNIT) 
       end
	end
end

addHook("ThinkFrame", do
		if map42_door1 == 1
		   map42_door1Timer = $-1
	end
       if map42_door1Timer == 0 then
	      P_LinedefExecute(16)
		  chatprint("\x83\Elevator \x80opened")
	end
end)

addHook("ThinkFrame", do
		if map42_door2 == 1
		   map42_door2Timer = $-1
	end
       if map42_door2Timer == 0 then
	      P_LinedefExecute(23)
		  chatprint("\x83\Elevator \x80opened")
	end
end)

addHook("ThinkFrame", do
		if map42_door3 == 1
		   map42_door3Timer = $-1
	end
       if map42_door3Timer == 0 and gamemap == 5 then
	      P_LinedefExecute(36)
		  Map42_Tele1()
		  chatprint("\x83\Doors \x80opened")
	end
end)

addHook("ThinkFrame", do
		if map42_door4 == 1
		   map42_door4Timer = $-1
	end
       if map42_door4Timer == 0 and gamemap == 5 then
	      P_LinedefExecute(41)
		  Map42_Tele3()
		  chatprint("\x83\Gates \x80opened")
	end
end)

addHook("ThinkFrame", do
		if map42_door5 == 1
		   map42_door5Timer = $-1
	end
       if map42_door5Timer == 0 then
	      P_LinedefExecute(30)
		  chatprint("\x83\Final Gates \x80opened")
	end
end)

addHook("LinedefExecute", Map42_Objection1, "42ACT1")
addHook("LinedefExecute", Map42_Objection2, "42ACT2")
addHook("LinedefExecute", Map42_Objection3, "42ACT3")
addHook("LinedefExecute", Map42_Objection4, "42ACT4")
addHook("LinedefExecute", Map42_Objection5, "42ACT5")
addHook("LinedefExecute", Map42_Tele2, "42TELE1")
addHook("LinedefExecute", Map42_Tele3, "42TELE2")
addHook("LinedefExecute", Map42_Tele4, "42TELE3")