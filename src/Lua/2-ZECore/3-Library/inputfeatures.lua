local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console
freeslot("MT_ZEMO_BUBBLE", "S_ZEMO_BUBBLE", "SPR_ZEMO")
freeslot("SPR_ZT00","SPR_ZT01", "SPR_ZT02")
freeslot("sfx_huhem", "sfx_vboom")


mobjinfo[MT_ZEMO_BUBBLE] = {		
	doomednum = -1,
	spawnstate = S_ZEMO_BUBBLE,
	spawnhealth = 2000,
	radius = 9 *FRACUNIT,
	height = 9*FRACUNIT,
	dispoffset = 0,
	activesound = sfx_none,
	flags = MF_NOGRAVITY|MF_NOCLIPHEIGHT|MF_NOBLOCKMAP,
	raisestate = S_NULL
}

states[S_ZEMO_BUBBLE] = {
	sprite = SPR_ZEMO,
	frame = FF_FULLBRIGHT|FF_TRANS50|A,
	nextstate = S_ZEMO_BUBBLE
}

ZE.Emotes = {}
ZE.AddEmote = function(emote_spr, name, desc, sound)
	local id = #ZE.Emotes + 1
	ZE.Emotes[id] = {
		["Sprite"] = emote_spr,
		["Name"] = name,
		["Description"] = desc,
		["Sound"] = sound or 100,
	}
	
	print("Added ZE Emote: " + ZE.Emotes[#ZE.Emotes].Name +" ("+#ZE.Emotes+")" )
end


ZE.AddEmote(SPR_ZT00, "Heal Me!", "Heal me NOW!")
ZE.AddEmote(SPR_ZT01, "Huh?", "What the?..", sfx_huhem)
ZE.AddEmote(SPR_ZT02, "Skull Emoji", "hell nah bruh", sfx_vboom)




COM_AddCommand("ze_emote", function(player, emotenum)
	if player.mo and player.mo.valid 
	and player.playerstate ~= PST_DEAD and
	netgame and multiplayer and player.speed == 0 then
		local emotenum_tonum = tonumber(emotenum)
		if not ZE.Emotes[emotenum_tonum] then
			CONS_Printf(player, "Invalid Emote: ("+emotenum_tonum+")")
		end
		if not(player.emotebubble) and not player.lastemotepress then
			player.lastemotepress = (TICRATE*3 + 25)
			player.mo.emotebubble = P_SpawnMobj(player.mo.x,player.mo.y,player.mo.z+player.mo.height,MT_ZEMO_BUBBLE)
			local ebub = player.mo.emotebubble
			ebub.target = player.mo
			ebub.isemotebubble = true
			ebub.sprite = ZE.Emotes[emotenum_tonum].Sprite
			P_SetScale(ebub, ebub.scale/4)
			S_StartSound(player.mo,ZE.Emotes[emotenum_tonum].Sound)
		end
	end
end)

addHook("KeyDown", function(k)
	if k.name == "1" then
		COM_BufInsertText(nil, "ze_emote 1")
	end
	
	if k.name == "2" then
		COM_BufInsertText(nil, "ze_emote 2")
	end
	
	if k.name == "3" then
		COM_BufInsertText(nil, "ze_emote 3")
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
		mobj.target.emotebubble = nil
		P_KillMobj(mobj)
	end
	

end)
