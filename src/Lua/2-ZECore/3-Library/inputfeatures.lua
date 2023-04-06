freeslot("MT_HLME_BUBBLE", "S_HLME_BUBBLE", "SPR_HLME")

mobjinfo[MT_HLME_BUBBLE] = {
		doomednum = -1,
		spawnstate = S_HLME_BUBBLE,
		spawnhealth = 2000,
		radius = 9 *FRACUNIT,
		height = 9*FRACUNIT,
		dispoffset = 0,
		activesound = sfx_None,
		flags = MF_NOGRAVITY|MF_NOCLIPHEIGHT|MF_NOBLOCKMAP,
		raisestate = S_NULL
}

states[S_HLME_BUBBLE] = {
		sprite = SPR_HLME,
		frame = FF_FULLBRIGHT|A,
		nextstate = S_HLME_BUBBLE
}


COM_AddCommand("ze_emote1", function(player)
	if player.mo and player.mo.valid 
	and player.mo.skin ~= "amy" and player.mo.skin ~= "dzombie" and player.playerstate ~= PST_DEAD and
	netgame and multiplayer and player.speed == 0 then
		
		if not(player.helpme) and not player.helpmelastpress then
			player.helpmelastpress = (TICRATE*3 + 25)
			player.mo.helpme = P_SpawnMobj(player.mo.x,player.mo.y,player.mo.z+player.mo.height,MT_HLME_BUBBLE)
			player.mo.helpme.target = player.mo
			P_SetScale(player.mo.helpme, player.mo.helpme.scale/4)
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
	if player.helpmelastpress then
		player.helpmelastpress = $ - 1
	end
end)
addHook("MobjThinker", function(mobj)
	mobj.hm_inc = $ or 0
	mobj.hm_inc = $ + 1
	
	if mobj.hm_inc > TICRATE*3 then
		mobj.scale = $/2
	end
	if mobj.hm_inc == (TICRATE*3 + 25) then
		mobj.target.helpme = nil
		P_KillMobj(mobj)
	end
end,MT_HLME_BUBBLE)
