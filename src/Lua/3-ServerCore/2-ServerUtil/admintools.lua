local ZE = RV_ZESCAPE

local function GetPlayerHelper(pname)
	-- Find a player using their node or part of their name.
	local N = tonumber(pname)
	if N ~= nil and N >= 0 and N < 32 then
		for player in players.iterate do
			if #player == N then
	return player
			end
		end
	end
	for player in players.iterate do
		if string.find(string.lower(player.name), string.lower(pname)) then
			return player
		end
	end
	return nil
end
local function GetPlayer(player, pname)
	local player2 = GetPlayerHelper(pname)
	if not player2 then
		CONS_Printf(player, "No one here has that name.")
	end
	return player2
end

local function ForceKillPlayer(player)
	-- Kill a player. Pierces invulnerability, Super form, and god mode.
	if player.mo and player.mo.valid then
		P_DamageMobj(player.mo, nil, nil, 1, DMG_INSTAKILL)
	end
end

local function MakeHumanPlayer(player)
	if player and player.valid
	  if player.mo and player.mo.valid
		   player.ctfteam = 2
		   player.alphazm = 0
		   R_SetPlayerSkin(player,ZE.survskinsplay[P_RandomRange(1,#ZE.survskinsplay)])
	   end
	end
end

local function MakeZombiePlayer(player)
	if player and player.valid
	  if player.mo and player.mo.valid
		   player.ctfteam = 1
		   R_SetPlayerSkin(player, "dzombie")
	   end
	end
end

local function MakeAlphaZombiePlayer(player)
	if player and player.valid
	  if player.mo and player.mo.valid
		   player.ctfteam = 1
		   player.alphazm = 1
		   R_SetPlayerSkin(player, "dzombie")
	   end
	end
end

local function GiveRevengerPlayer(player)
	if player and player.valid
	  if player.mo and player.mo.valid
		   player.rvgrpass = 1
		   R_SetPlayerSkin(player, "revenger")
	   end
	end
end

local function TakeRevengerPlayer(player)
	if player and player.valid
	  if player.mo and player.mo.valid
		   player.rvgrpass = 0
		   R_SetPlayerSkin(player,ZE.survskinsplay[P_RandomRange(1,#ZE.survskinsplay)])
	   end
	end
end

local function ExpandPlayerScale(player)
	if player.mo and player.mo.valid
	  if player.mo.scale > 4*FRACUNIT then return end
	   player.mo.scale = $+50*FRACUNIT/100
	end
end

local function ReducePlayerScale(player)
	if player.mo and player.mo.valid
	 if player.mo.scale <= 50*FRACUNIT/100 then return end
	   player.mo.scale = $-50*FRACUNIT/100
	end   
end

local function CanCheat(player)
	-- Can the player use co-op cheats? (Admins can use them outside of co-op.)
	if (player == server or player == admin or gametype == GT_ZESCAPE or gametype == GT_ZSWARM) then
		return true
	else
		CONS_Printf(player, "You can only use this in ZE.")
		return false
	end
end

rawset(_G, "bit", {})

bit.floatnumber = function(src)
	if src == nil then return nil end
	if not src:find("^-?%d+%.%d+$") then
		if tonumber(src) then
			return tonumber(src)*FRACUNIT
		else
			return nil
		end
	end
	local decPlace = src:find("%.")
	local whole = tonumber(src:sub(1, decPlace-1))*FRACUNIT
	--print(whole)
	local dec = src:sub(decPlace+1)
	--print(dec)
	local decNumber = tonumber(dec)*FRACUNIT
	for i=1,dec:len() do
		decNumber = $1/10
	end
	if src:find("^-") then
		return whole-decNumber
	else
		return whole+decNumber
	end
end

COM_AddCommand("makehuman", function(player, pname)
	if not pname then
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		MakeHumanPlayer(player2)
		ZE.setStatDefaults(player2)
	end
end, 1)

COM_AddCommand("makezombie", function(player, pname)
	if not pname then
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		MakeZombiePlayer(player2)
	end
end, 1)

COM_AddCommand("makealpha", function(player, pname)
	if not pname then
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		MakeAlphaZombiePlayer(player2)
	end
end, 1)

COM_AddCommand("giverevenger", function(player, pname)
	if not pname then
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		GiveRevengerPlayer(player2)
	end
end, 1)

COM_AddCommand("takerevenger", function(player, pname)
	if not pname then
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		TakeRevengerPlayer(player2)
	end
end, 1)

COM_AddCommand("expandscale", function(player, pname)
	if not pname then
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		ExpandPlayerScale(player2)
	end
end, 1)

COM_AddCommand("reducescale", function(player, pname)
	if not pname then
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		ReducePlayerScale(player2)
	end
end, 1)

COM_AddCommand("goto", function(player, pname)

	if not pname then
		CONS_Printf(player, "goto <name>: teleport to another player's location")
		return
	elseif CanCheat(player) then
		if not player.mo then
			CONS_Printf(player, "You don't exist, so you can't teleport now.")
			return
		end
		
		local player2 = GetPlayer(player, pname)
		if player2 then
			if not player2.mo then
				CONS_Printf(player, "That player is spectating, so you can't teleport to them.")
				return
			elseif player2 == player then
				CONS_Printf(player, "You have teleported to yourself. Good for you.")
			else
				if player.ve then -- compatibility with Vehicles
					P_TeleportMove(player.ve, player2.mo.x, player2.mo.y, player2.mo.z)
				end
				P_TeleportMove(player.mo, player2.mo.x, player2.mo.y, player2.mo.z)
				player.mo.angle = player2.mo.angle
			end
			P_ResetPlayer(player)
		end
	end
end, 1)

/*COM_AddCommand("dofor", function(player, pname, command)
	-- Force someone else's console to execute an arbitrary command.
	-- You can't read their console output, so make sure you don't make a mistake.
	if not pname then
		CONS_Printf(player, "dofor <name> <command>: execute a command for someone else (server/admin only)")
		return
	end
	local player2 = GetPlayer(player, pname)
	if player2 then
		if player2 == server and player == admin then
			CONS_Printf(player, "You cannot run commands on the server's console.")
			return
		end
		COM_BufInsertText(player2, command)
	end
end, 1)

COM_AddCommand("noclip", function(player, pname)
	if player.devplayer == false
		CONS_Printf(player, "You cannot use this command!")
		return
	end
	local player2 = GetPlayer(player, pname)
	if not (player.pflags & PF_NOCLIP)
		player2.pflags = $1|PF_NOCLIP
		CONS_Printf(player, "\x83 Noclip On")
	else
		player2.pflags = $1 & ~PF_NOCLIP
		CONS_Printf(player, "\x85 Noclip Off")
	end
end, 1)

COM_AddCommand("godmode", function(player, pname)
	if player.devplayer == false
		CONS_Printf(player, "You cannot use this command!")
		return
	end
	local player2 = GetPlayer(player, pname)
	if not (player2.pflags & PF_GODMODE)
		player2.pflags = $1|PF_GODMODE
		CONS_Printf(player, "\x83 Godmode On")
	else
		player2.pflags = $1 & ~PF_GODMODE
		CONS_Printf(player, "\x85 Godmode Off")
	end
end, 1)

COM_AddCommand("scale", function(p, target, scale)
	local nScale = bit.floatnumber(scale)

    if target == nil
        CONS_Printf(p, "scale <number> <target>: Make someone bigger or smaller")
        return
    end

	if not nScale then
		CONS_Printf(p, "scale <number> <target>: Make someone bigger or smaller")
		return
	end
	
	if target == "all"
	    for all in players.iterate do
           if all.mo and all.mo.valid
		      all.mo.destscale = nScale
			end
		end
    return end

    target = tonumber(target)

    if target > 32 or target < 0 then return end

    target = players[target]
	target.mo.destscale = nScale
end, 1)*/

COM_AddCommand('kill', function(player, arg)
    if arg == nil
        CONS_Printf(player, 'kill <node>: Kills the player.')
        return
    end
	
	if arg == "all"
	   for all in players.iterate
        if all.mo and all.mo.valid then
           P_DamageMobj(all.mo, nil, nil, 101, DMG_INSTAKILL)
        end
	end
    return end

    arg = tonumber(arg)

    if arg == nil or arg > 32 or arg < 0 then return end

    arg = players[arg]

    if arg.pflags & PF_GODMODE
        arg.pflags = $1 & ~PF_GODMODE
    end

    if arg.mo and arg.mo.valid
        P_DamageMobj(arg.mo, nil, nil, 101, DMG_INSTAKILL)
    end
end, 1)

COM_AddCommand('here', function(player, target)
    if target == nil
        CONS_Printf(player, "here <node>: brings the given node")
        return
    end

    target = tonumber(target)

    if target > 32 or target < 0 then return end

    target = players[target]

    if target.mo and player.mo
        P_TeleportMove(target.mo, player.mo.x, player.mo.y, player.mo.z)
        P_FlashPal(target, PAL_MIXUP, 1*TICRATE)
        S_StartSound(target.mo, sfx_mixup, target)
        S_StartSound(player.mo, sfx_mixup, player)
    end
end, 1)