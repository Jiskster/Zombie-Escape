local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

freeslot("MT_HLME_BUBBLE", "S_HLME_BUBBLE", "SPR_HLME")
ZE.Emotes = {}
ZE.AddEmote = function(emote_mt, emote_s, emote_spr, name, desc)
	local mt_template = {		
		doomednum = -1,
		spawnstate = emote_s,
		spawnhealth = 2000,
		radius = 9 *FRACUNIT,
		height = 9*FRACUNIT,
		dispoffset = 0,
		activesound = sfx_None,
		flags = MF_NOGRAVITY|MF_NOCLIPHEIGHT|MF_NOBLOCKMAP,
		raisestate = S_NULL
	}
	local s_template = {
		sprite = emote_spr,
		frame = FF_FULLBRIGHT|FF_TRANS50|A,
		nextstate = emote_s
	}
	
	mobjinfo[emote_mt] = mt_template
	mobjinfo[emote_s] = s_template
	
	table.insert(ZE.Emotes, {
		["Key"] = emote_mt,
		["Name"] = name,
		["Description"] = desc,
	})
end

ZE.AddEmote(MT_HLME_BUBBLE, S_HLME_BUBBLE, SPR_HLME)


COM_AddCommand("ze_emote1", function(player)
	if player.mo and player.mo.valid 
	and player.playerstate ~= PST_DEAD and
	netgame and multiplayer and player.speed == 0 then
		
		if not(player.emotebuble) and not player.lastemotepress then
			player.lastemotepress = (TICRATE*3 + 25)
			player.mo.emotebuble = P_SpawnMobj(player.mo.x,player.mo.y,player.mo.z+player.mo.height,MT_HLME_BUBBLE)
			player.mo.emotebuble.target = player.mo
			P_SetScale(player.mo.emotebuble, player.mo.emotebuble.scale/4)
			S_StartSound(player.mo,100)
		end
	end
end)

addHook("KeyDown", function(k)
	if k.name == "1" then
		COM_BufInsertText(nil, "ze_emote1")
	end
end)

addHook("PlayerThink", function(player)
	if player.lastemotepress then
		player.lastemotepress = $ - 1
	end
end)
addHook("MobjThinker", function(mobj)
	if mobj.isemotebubble ~= true then return end
	mobj.em_inc = $ or 0
	mobj.em_inc = $ + 1
	if mobj.target and mobj.target.valid and mobj.target.player then
		if mobj.target.player.speed > 0 then
			mobj.em_inc = $ + 3
			if not (mobj.target.player.lastemotepress - 3 < 0) then
				mobj.target.player.lastemotepress = $ - 3
			end
		end
		P_TeleportMove(mobj, mobj.target.x, mobj.target.y, mobj.target.z+mobj.target.height)
	end
	if mobj.em_inc > TICRATE*3 then
		mobj.scale = $/2
	end
	if mobj.em_inc > (TICRATE*3 + 25) then
		mobj.target.emotebuble = nil
		P_KillMobj(mobj)
	end
	

end)
