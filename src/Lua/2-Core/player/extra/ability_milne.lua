local ZE = RV_ZESCAPE

ZE.MilnePlayerThink = function(player)
	if player.mo and player.mo.valid and player.mo.skin == "milne"
		player.milnespringtime = 0
		player.milnedeadtimer = 0
		player.milneairtime = 0
		player.milnehugpain = 0
		player.milne1tapready = false
		player.crystallance = 0
		player.weapondelay = 1
	end
end

ZE.MilneAbilitySpecial = function(player)
	if not (player.mo and player.mo.skin == "milne") return end
	
	//Don't do it if you're holding the button, used a shield
	//are carrying something, or didn't even jump
	if player.pflags&PF_JUMPDOWN or player.pflags&PF_SHIELDABILITY
	or (player.milnecarry and player.milnecarry.valid)
	or not (player.pflags&PF_JUMPED) return true end
	
	//The downwards jump
	if player.pflags&PF_THOKKED then 
		player.milnelastthok = 0 
		if player.powers[pw_super]
			player.pflags = $&~PF_THOKKED
		else
			player.pflags = $&~PF_JUMPED
		end
		
		if player.mo.eflags&MFE_UNDERWATER
			P_SetObjectMomZ(player.mo, -12*FRACUNIT, true)
		else
			P_SetObjectMomZ(player.mo, -3*FRACUNIT, true)
		end
		
		if mariomode
			S_StartSound(player.mo, sfx_thok)
		else
			S_StartSound(player.mo, sfx_mldown)
		end
	//The upwards jump
	else
		player.pflags = $&~PF_JUMPED
		P_DoJump(player, false)
		player.pflags = $|PF_JUMPED|PF_THOKKED
		player.jumping = true
		S_StartSound(player.mo, sfx_thok)
	end
	
	//The Thok part (only executes if you're holding far enough in a direction)
	if not (P_GetPlayerControlDirection(player) == 0
	or (abs(player.cmd.forwardmove) < 35 and abs(player.cmd.sidemove) < 35))
		local actionspd = max(player.actionspd, player.normalspeed)*2/3
		if player.mo.eflags&MFE_UNDERWATER
			actionspd = $*2/3
		end
		
		if player.speed <= FixedMul(actionspd, player.mo.scale)
			P_InstaThrust(player.mo, player.mo.angle, FixedMul(actionspd, player.mo.scale))
		else
			P_InstaThrust(player.mo, player.mo.angle, FixedHypot(player.rmomx,player.rmomy))
		end
		player.drawangle = player.mo.angle
	end
	
	
	//Other stuff
	player.mo.state = S_PLAY_SPINDASH
	//P_SpawnThokMobj(player)
	player.pflags = $&~PF_SPINNING&~PF_STARTDASH
	player.milnespringtime = TICRATE/2
	return true
end
