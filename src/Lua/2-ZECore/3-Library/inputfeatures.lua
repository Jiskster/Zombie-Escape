local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console
freeslot("MT_ZEMO_BUBBLE", "S_ZEMO_BUBBLE", "SPR_ZEMO")
freeslot("SPR_ZT00","SPR_ZT01", "SPR_ZT02", "SPR_ZT03", "SPR_ZT04", "SPR_ZT05")
freeslot("sfx_huhem", "sfx_vboom", "sfx_thwop", "sfx_heheha", "sfx_4ayo")


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

addHook("PlayerThink", function(player)
	if player.mo and player.mo.valid then
		player.emoteslots = $ or {
			1,
			2,
			3
		}
		player.emotetime = $ or 3*TICRATE
	end
end)
ZE.AddEmote(SPR_ZT00, "Heal Me!", "Heal me NOW!")
ZE.AddEmote(SPR_ZT01, "Huh?", "What the?..", sfx_huhem)
ZE.AddEmote(SPR_ZT02, "Skull Emoji", "hell nah bruh", sfx_vboom)
ZE.AddEmote(SPR_ZT03, "Sad Sponge", "me when when no 2.3", sfx_thwop)
ZE.AddEmote(SPR_ZT04, "heheheha", "HE HE HE HA", sfx_heheha)
ZE.AddEmote(SPR_ZT05, "AYO?", "bro said something mad sus", sfx_4ayo)





COM_AddCommand("ze_emote", function(player, emotenum)
	if player.mo and player.mo.valid 
	and player.playerstate ~= PST_DEAD and
	netgame and multiplayer then
		local emotenum_tonum = tonumber(emotenum)
		if not ZE.Emotes[emotenum_tonum] then
			CONS_Printf(player, "Invalid Emote: ("+emotenum_tonum+")")
			return
		end
		if not(player.emotebubble) and not player.lastemotepress then
			player.lastemotepress = (TICRATE*3 + 25)
			player.mo.emotebubble = P_SpawnMobj(player.mo.x,player.mo.y,player.mo.z+player.mo.height,MT_ZEMO_BUBBLE)
			local ebub = player.mo.emotebubble
			local slotchosen = player.emoteslots[emotenum_tonum]
			ebub.target = player.mo
			ebub.isemotebubble = true
			
			ebub.sprite = ZE.Emotes[slotchosen].Sprite
			P_SetScale(ebub, ebub.scale/4)
			S_StartSound(player.mo,ZE.Emotes[slotchosen].Sound)
		end
	end
end)

COM_AddCommand("ze_emotetime", function(player, emotetime)
	if player.mo and player.mo.valid 
	and player.playerstate ~= PST_DEAD and
	netgame and multiplayer then
	
		if emotetime == nil and tonumber(emotetime) == nil then
			CONS_Printf(player,"ze_emotetime <emotetime>: How long your emote stays up")
			return
		end
		if tonumber(emotetime) < 1 or tonumber(emotetime) > 5 then
			CONS_Printf(player,"\x88\Emote Time must be valid. And more than 1 and less than 5.")
			return
		end
		if (player.mo.emotebubble) then
			CONS_Printf(player,"\x88\You must not be emoting to use this command.")
			return
		end
		
		if (player.emotetime) then
			player.emotetime = tonumber(emotetime)*TICRATE
			local printemotetime = tonumber(emotetime)
			CONS_Printf(player,"\x88\Set emote time to \$printemotetime\.")
		end
	end
end)

COM_AddCommand("ze_emotelist", function(player)
	for i,v in ipairs(ZE.Emotes) do
		CONS_Printf(player,"\x82\+ (\$i\): \$v.Name\")
		CONS_Printf(player,"\x88\| Description: \$v.Description\")
	end
end)

COM_AddCommand("ze_setemote", function(player, slot, emote)
	if slot == nil and emote == nil then
		CONS_Printf(player,"ze_setemote <slot> <emotenumber>: Sets your slot to an emote.")
		return
	end
	if not(slot) or tonumber(slot) > 3 or tonumber(slot) < 1 then
		CONS_Printf(player,"Slot must be a valid number. And between 1 - 3")
		return
	end
	
	if ZE.Emotes[tonumber(emote)] then
		player.emoteslots[tonumber(slot)] = tonumber(emote)
		CONS_Printf(player,"Slot \$tonumber(slot)\ replaced \$ZE.Emotes[tonumber(emote)].Name\")
		return
	else
		CONS_Printf(player,"Invalid Emote.")
		return
	end
end)

addHook("PlayerThink", function(player)
	if player.lastemotepress then
		player.lastemotepress = $ - 1
	end
	if (player.cmd.buttons & BT_WEAPONMASK) == 1 then
		COM_BufInsertText(player, "ze_emote 1")
	end
	
	if (player.cmd.buttons & BT_WEAPONMASK) == 2 then
		COM_BufInsertText(player, "ze_emote 2")
	end
	
	if (player.cmd.buttons & BT_WEAPONMASK) == 3 then
		COM_BufInsertText(player, "ze_emote 3")
	end
end)
addHook("MobjThinker", function(mobj)
	if mobj.isemotebubble ~= true then return end
	mobj.em_inc = $ or 0
	mobj.em_inc = $ + 1
	if mobj.target and mobj.target.valid and mobj.target.player then
		/*
		if mobj.target.player.speed > 0 then
			mobj.em_inc = $ + 3
			if not (mobj.target.player.lastemotepress - 3 < 0) then
				mobj.target.player.lastemotepress = $ - 3
			end
		end
		*/
		P_TeleportMove(mobj, mobj.target.x, mobj.target.y, mobj.target.z+mobj.target.height)
	end
	if mobj.target and mobj.target.player.emotetime then
		if mobj.em_inc > (mobj.target.player.emotetime + 10) then
			mobj.target.emotebubble = nil
			P_KillMobj(mobj)
			return
		end
	else
		if mobj and mobj.valid  then
			mobj.target.emotebubble = nil
			P_KillMobj(mobj)
			return
		end
	end
	if mobj.target and mobj.target.player.emotetime
		if mobj.em_inc > mobj.target.player.emotetime then
			mobj.scale = $/2
		end
	end
end)
