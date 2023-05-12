freeslot("mt_hitbox","spr_htbx","s_hitbox")
mobjinfo[MT_HITBOX] = {
        spawnstate = S_HITBOX,
        flags = MF_SCENERY|MF_NOTHINK|MF_NOBLOCKMAP
}

states[S_HITBOX] = {
        sprite = SPR_HTBX,
        frame = A,
		tics = 1,
        nextstate = S_HITBOX
}

local CV_Rings = CV_RegisterVar{
	name = "hitbox_rings",
	defaultvalue = 0,
	PossibleValue = {MIN = 0, MAX = 1}
}

local CV_Player = CV_RegisterVar{
	name = "hitbox_player",
	defaultvalue = 0,
	PossibleValue = {MIN = 0, MAX = 1}
}

local CV_Color = CV_RegisterVar{
	name = "hitbox_color",
	defaultvalue = 1,
	PossibleValue = {MIN = 0, MAX = 1}
}

local CV_Distance = CV_RegisterVar{
	name = "hitbox_distance",
	defaultvalue = 2560,
	PossibleValue = {MIN = 0, MAX = 2560}
}

local CV_Faces = CV_RegisterVar{
	name = "hitbox_faces",
	defaultvalue = 0,
	PossibleValue = CV_OnOff
}

local Hitboxes = {}
local Faces = {}


local CanSeeHitbox = function(mo)
	if R_PointToDist(mo.x,mo.y) > CV_Distance.value*FRACUNIT
		return false
	end
	if mo.type == MT_PLAYER and R_PointToDist(mo.x,mo.y) < FRACUNIT*72  return false end
	return true
end

local flaghazard = MF_PAIN|MF_MISSILE
local flagenemy = MF_ENEMY|MF_BOSS
local flagspecial = MF_SPECIAL|MF_SPRING

local DoFace = function(mo)
	-- Conditions for deletion
	if not(mo and mo.valid) return end -- Object is no longer valid
	local target = mo.target
	if not(target and target.valid) -- Target does not exist anymore
	or CV_Faces.value == 0 -- Debug hitboxes are turned off
	or target.type == MT_RING and not(CV_Rings.value)  -- Ring hitboxes are turned off
	or target.type == MT_PLAYER and not(CV_Player.value)  -- Player hitboxes are turned off
	or not(CanSeeHitbox(target))  -- Hitbox is too far away
		P_RemoveMobj(mo)
		return
	end
	-- All checks passed. Update face

	-- Do color coding
	mo.color = not(CV_Color.value) 		and SKINCOLOR_JET
		or target.player 				and SKINCOLOR_BLUE
		or target.flags&(flaghazard) 	and SKINCOLOR_RED
		or target.flags&MF_SOLID 		and SKINCOLOR_GREY
		or target.flags&MF_PUSHABLE 	and SKINCOLOR_PURPLE
		or target.flags&(flagenemy) 	and SKINCOLOR_ORANGE
		or target.flags&(flagspecial)	and SKINCOLOR_YELLOW
										or SKINCOLOR_GREEN
	-- Update size
	mo.spritexscale = mo.target.radius -- Width
	mo.spriteyscale = mo.renderflags & RF_PAPERSPRITE	and mo.target.height>>1 -- Papersprite height
														or mo.target.radius -- Splat "height"
	-- Update side position
	mo.xo = $ > 0 and mo.target.radius
		or $ < 0 and -mo.target.radius
		or 0
	mo.yo = $ > 0 and mo.target.radius
		or $ < 0 and -mo.target.radius
		or 0
	
	-- Update top position
	mo.zo = $ and mo.target.height -- If 0, stays at 0
	
	-- Do reposition
	P_TeleportMove(mo,target.x+mo.xo,target.y+mo.yo,target.z+mo.zo)
	target.faces_exist = true -- Confirming to our target object that faces still exist
		

	return mo
end

local trans = FF_TRANS70
local MakeBox = function(mo)
	if not(mo and mo.valid) return end
	local face
	for n = 1, 4 do
		local angle = FixedAngle((90*n)<<FRACBITS)
		local x = FixedMul(cos(angle),mo.radius)
		local y = FixedMul(sin(angle),mo.radius)
		face = P_SpawnMobjFromMobj(mo, x, y, 0, MT_HITBOX)
		face.scale = FRACUNIT
		face.xo = x
		face.yo = y
		face.zo = 0
		face.angle = angle+ANGLE_90
		face.renderflags = $|RF_PAPERSPRITE
		face.frame = 1|trans
		face.target = mo
		table.insert(Faces,face)
		DoFace(face)
	end
	for n = 1, 2 do
		local z = mo.height * (n&1)
		face = P_SpawnMobjFromMobj(mo, 0, 0, z, MT_HITBOX)
		face.scale = FRACUNIT
		face.renderflags = $|(RF_FLOORSPRITE|RF_NOSPLATBILLBOARD)
		face.xo = 0
		face.yo = 0
		face.zo = z
		face.frame = 2|trans
		face.target = mo
		table.insert(Faces,face)
		DoFace(face)
	end
end

local UpdateHitbox = function(mo)
	if not(mo and mo.valid)  return nil end
	if mo.type == MT_RING and not(CV_Rings.value)  return true end
	if mo.faces_exist 
		mo.faces_exist = false -- Reset the check for next frame
	return true end
	if not(CanSeeHitbox(mo))  return true end
	if CV_Faces.value
		MakeBox(mo)
	end	
	return true
end

local flags = MF_SPECIAL|MF_MISSILE|MF_PAIN|MF_ENEMY|MF_BOSS|MF_SOLID|MF_PUSHABLE|MF_SPRING

addHook("MobjSpawn",function(mo)
	if not(mo.flags&flags or mo.type == MT_PLAYER)
	 return end
	Hitboxes[#Hitboxes+1] = mo
	mo.faces_exist = false
end,MT_NULL)

addHook("PostThinkFrame",function()
 	-- Update faces
	local queue = Faces
	Faces = {}
	local size = #queue
	for n = 1, size do
		local face = queue[n]
		if DoFace(face) 
			Faces[#Faces+1] = face
		end
	end
		
	-- Update hitboxes
	queue = Hitboxes
	Hitboxes = {}
	local size = #queue
	for n = 1, size do
		local hitbox = queue[n]
		if UpdateHitbox(hitbox) 
			Hitboxes[#Hitboxes+1] = hitbox
		end
	end
end)

addHook("MapChange",function()
	Hitboxes = {}
	Faces = {}
end)

