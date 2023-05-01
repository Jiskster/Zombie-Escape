local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.PropCosts = {
	["Wood"] = 50,
	["HealStation"] = 50,
	["LandMine"] = 6,
}
freeslot("MT_AMYSTATION","S_AMYSTATION")
freeslot("MT_LANDMINE","S_LANDMINE","S_LANDMINE2", "SPR_MMVC")

mobjinfo[MT_AMYSTATION] = {
    sprite = SPR_NULL,
	spawnstate = S_AMYSTATION,
	painstate = S_AMYSTATION,
	painsound = sfx_None,
	deathstate = S_AMYSTATION,
	deathsound = sfx_None,
	spawnhealth = 50,
	speed = 0,
	radius = 96*FRACUNIT,
	height = 138*FRACUNIT,
	flags = MF_SHOOTABLE|MF_NOCLIPHEIGHT|MF_NOGRAVITY,
}

states[S_AMYSTATION] = {
	nextstate = S_AMYSTATION,
	sprite = SPR_NULL,
	frame = FF_FULLBRIGHT,
	tics = 2,
}


mobjinfo[MT_LANDMINE] = {
    sprite = SPR_MMVC,
	spawnstate = S_LANDMINE,
	painstate = S_LANDMINE,
	painsound = sfx_None,
	deathstate = S_LANDMINE,
	deathsound = sfx_None,
	spawnhealth = 50,
	speed = 0,
	radius = 140*FRACUNIT,
	height = 138*FRACUNIT,
	flags = MF_SHOOTABLE|MF_NOCLIPHEIGHT|MF_NOGRAVITY,
}

states[S_LANDMINE] = {
	nextstate = S_LANDMINE2,
	sprite = SPR_MMVC,
	frame = FF_FULLBRIGHT|A,
	tics = 70,
}

states[S_LANDMINE2] = {
	nextstate = S_LANDMINE,
	sprite = SPR_MMVC,
	frame = FF_FULLBRIGHT|B,
	tics = 70,
}

ZE.BuildPropWood = function(player)
	if player.mo and player.mo.valid
        local wood = P_SpawnMobj(player.mo.x+FixedMul(128*FRACUNIT, cos(player.mo.angle)),
					player.mo.y+FixedMul(128*FRACUNIT, sin(player.mo.angle)), player.mo.z, MT_PROPWOOD)
		wood.angle = player.mo.angle+ANGLE_90
		S_StartSound(player.mo, sfx_jshard)
		wood.renderflags = $|RF_PAPERSPRITE
		wood.fuse = CV.propdespawn.value*TICRATE
		wood.target = player.mo
		P_GivePlayerRings(player,-ZE.PropCosts["Wood"])
	end
end

ZE.BuildHealStation = function(player)
	if player.mo and player.mo.valid
        local healstation = P_SpawnMobj(player.mo.x+FixedMul(0*FRACUNIT, cos(player.mo.angle)),
					player.mo.y+FixedMul(0*FRACUNIT, sin(player.mo.angle)), player.mo.z, MT_AMYSTATION)
		S_StartSound(player.mo, sfx_jshard)
		healstation.target = player.mo
		P_GivePlayerRings(player,-ZE.PropCosts["HealStation"])
	end
end

/*
ZE.SpawnZombieNPC = function(player) -- debug thing
	if player.mo and player.mo.valid
        local zombie = P_SpawnMobj(player.mo.x+FixedMul(32*FRACUNIT, cos(player.mo.angle)),
					player.mo.y+FixedMul(32*FRACUNIT, sin(player.mo.angle)), player.mo.z, MT_PLAYER)
		ZE.registerNpc(zombie,100,100)
		S_StartSound(player.mo, sfx_inf2)
		zombie.name = "Zombie"
		zombie.skin = "dzombie"
		zombie.color = SKINCOLOR_MOSS
	end
end
*/

ZE.BuildLandMine = function(player)
	if player.mo and player.mo.valid
        local landmine = P_SpawnMobj(player.mo.x+FixedMul(0*FRACUNIT, cos(player.mo.angle)),
					player.mo.y+FixedMul(0*FRACUNIT, sin(player.mo.angle)), player.mo.z, MT_LANDMINE)
		S_StartSound(player.mo, sfx_jshard)
		landmine.target = player.mo
		P_GivePlayerRings(player,-ZE.PropCosts["LandMine"])
	end
end


ZE.SpawnProps = function(player)
	if (leveltime < CV.waittime) then return end
	if player.powers[pw_flashing] > 0 then return end
	if player.mo and player.mo.skin == "tails"
		if player.rings == 0 then return end
		if player.rings < ZE.PropCosts["Wood"] then return end
		player.builddelay = $ or 0
		if (player.cmd.buttons & BT_TOSSFLAG) and not (player.builddelay ~= 0)
			player.builddelay = 5*TICRATE/2
			ZE.BuildPropWood(player)
		end
		if player.builddelay ~= 0 then
			player.builddelay = $-1
		end
	end
	if player.mo and player.mo.skin == "amy"
		if player.rings == 0 then return end
		if player.rings < ZE.PropCosts["HealStation"] then return end
		player.builddelay = $ or 0
		if (player.cmd.buttons & BT_TOSSFLAG) and not (player.builddelay ~= 0)
			player.builddelay = 10
			ZE.BuildHealStation(player)
		end
		if player.builddelay ~= 0 then
			player.builddelay = $-1
		end
	end
	
	if player.mo and player.mo.skin == "metalsonic"
		if player.rings == 0 then return end
		if player.rings < ZE.PropCosts["LandMine"] then return end
		player.builddelay = $ or 0
		if (player.cmd.buttons & BT_TOSSFLAG) and not (player.builddelay ~= 0)
			player.builddelay = TICRATE/4
			ZE.BuildLandMine(player)
		end
		if player.builddelay ~= 0 then
			player.builddelay = $-1
		end
	end
end

addHook("MobjSpawn", function (mobj)
    mobj.heartlist = {}
    mobj.middlelist = {}
    mobj.healtries = 0 
    for i=1,10
        table.insert(mobj.heartlist, P_SpawnMobjFromMobj(mobj,0,0,0,MT_UNKNOWN))
        mobj.heartlist[i].sprite = SPR_LHRT
    end

    for i=1,10
        table.insert(mobj.middlelist, P_SpawnMobjFromMobj(mobj,0,0,0,MT_UNKNOWN))
        mobj.middlelist[i].sprite = SPR_THOK
        mobj.middlelist[i].scale = $/2
    end
end, MT_AMYSTATION)

addHook("MobjSpawn", function (mobj)
	mobj.scale = $*(2+(1/2))
end,MT_LANDMINE)

addHook("MobjThinker", function (mobj)
    if mobj and mobj.valid and mobj.heartlist ~= nil and mobj.middlelist ~= nil then
		local swarm = mapheaderinfo[gamemap].zombieswarm 
        local numhearts = #mobj.heartlist
        local nummiddle = #mobj.middlelist
        for i=1,numhearts
            local currentheart = mobj.heartlist[i]
            local x = mobj.x + FixedMul(64*FU,cos((ANG1)* (360/numhearts) * i ) )
            local y = mobj.y + FixedMul(64*FU,sin((ANG1)* (360/numhearts) * i ) )
            P_TeleportMove(currentheart,x,y,mobj.z+(48*FU*3))

            if i % 2 == 0 then
                currentheart.colorized = true
                currentheart.color = SKINCOLOR_PEACHY
            else
                currentheart.colorized = true
                currentheart.color = SKINCOLOR_ROSY
            end

            if mobj.healtries > 5 then
                currentheart.color = SKINCOLOR_GREY
            end
        end

        for i=1,nummiddle
            local currentmiddle = mobj.middlelist[i]
            local x = mobj.x
            local y = mobj.y
            P_TeleportMove(currentmiddle,x,y,mobj.z+(24*FU*i) )
            currentmiddle.colorized = true
            currentmiddle.color = SKINCOLOR_ROSY

            if mobj.healtries > 5 then
                currentmiddle.color = SKINCOLOR_GREY
            end
        end
		if leveltime % 25 == 0 then
			mobj.healtries = $ + 1
			if mobj.healtries <= 5 then
				S_StartSound(mobj, 192)
			end
			if mobj.healtries > 20 then              
				mobj.healtries = 0
			end
		end
        for player in players.iterate do
            if player.mo and player.mo.valid 
            and player.playerstate ~= PST_DEAD 
            and player.mo.skin ~= "dzombie" then

                local dist = R_PointToDist2(player.mo.x, player.mo.y, mobj.x, mobj.y)/FU
                local zdiff = abs(player.mo.z - mobj.z)/FU
                if dist < 255*2 and zdiff < 150 and P_CheckSight(mobj, player.mo) then
                    if mobj.healtries <= 5
                        local amyglow = P_SpawnGhostMobj(player.mo)
                        amyglow.color = SKINCOLOR_ROSY
                        amyglow.colorized = true
                        amyglow.fuse = 5
                        if amyglow.tracer
                            amyglow.tracer.fuse = amyglow.fuse
                        end
						if leveltime % 27 == 0 then
						
							if not swarm then
								ZE.addHP(player.mo, 6)
							end
							if swarm then
								ZE.addHP(player.mo, 12 / ZE.Wave)
							end
						end
                    end
                end
            end
        end
    end
end, MT_AMYSTATION)

addHook("MobjThinker", function (mobj)
	if mobj and mobj.valid then
		for player in players.iterate do
			if player.mo and player.mo.valid 
			and player.playerstate ~= PST_DEAD 
			and player.mo.skin == "dzombie" then

				local dist = R_PointToDist2(player.mo.x, player.mo.y, mobj.x, mobj.y)/FU
				local zdiff = abs(player.mo.z - mobj.z)/FU
				if dist < 20 and zdiff < 10 then
					P_GivePlayerRings(mobj.target.player, ZE.PropCosts["LandMine"])
					S_StartSound(player.mo,sfx_s244)
					P_SetObjectMomZ(player.mo, 8*FU)
					local angles = {ANGLE_90,ANGLE_180,ANGLE_270,ANGLE_135}
					local newangle = P_RandomRange(1, #angles)
					player.mo.angle = angles[newangle]
					P_InstaThrust(player.mo, player.mo.angle, 50*FU)
					P_RemoveMobj(mobj)
				end
			end
			
		end
	end
end, MT_LANDMINE)