--Original script by wired-aunt, heavily modified for use in those battle mod servers
--but this is for zombie escape lmao and sorta modified by Jisk#4833
local sorted_players = {}

local string_linebreak = function(view, message, flags)
	--print("string_linebreak( "..message..", "..flags..")")
	local linelist = {}
	local width = 130
	local maxwidth = 170
	local maxlines = 2
	local i = 1
	local line = ""
	while i <= string.len(message) and #linelist < maxlines
		local nextletter = string.sub(message, i, i)
		--print("nextletter: "..nextletter)
		if not (line == "" and nextletter == " ")
			if view.stringWidth(line, flags, "thin") > maxwidth
				if (#linelist == maxlines - 1)
					linelist[#linelist + 1] = line
				else
					linelist[#linelist + 1] = line.."-"
				end
				line = ""
				--print("NEW LINE")
				continue
			elseif view.stringWidth(line, flags, thin) > width and nextletter == " "
				linelist[#linelist + 1] = line
				line = ""
				--print("NEW LINE")
				continue
			else
				line = $ + string.sub(message, i, i)
				--print("	added")
			end
		else
			--print("	invalid space, skipping")
		end
		i = $ + 1
		if i > string.len(message)
			linelist[#linelist + 1] = line
			line = ""
			--print("FINISH, NEW LINE")
		end
	end
	if (#linelist == maxlines)
		linelist[maxlines] = $ .. "..."
	end
	return linelist
end

CV_RegisterVar({
	name = "nametags",
	defaultvalue = 1,
	PossibleValue = CV_OnOff
})

hud.add( function(v, player, camera)
	if not CV_FindVar("nametags").value
		return
	end
	
	local width = 320
	local height = 200
	local realwidth = v.width()/v.dupx()
	local realheight = v.height()/v.dupy()

	local first_person = not camera.chase
	local cam = first_person and player.realmo or camera
	local spectator = player.spectator
	local hudwidth = 320*FRACUNIT
	local hudheight = (320*v.height()/v.width())*FRACUNIT

	local fov = (CV_FindVar("fov").value/FRACUNIT)*ANG1 --Can this be fetched live instead of assumed?
	
	--the "distance" the HUD plane is projected from the player
	local hud_distance = FixedDiv(hudwidth / 2, tan(fov/2))

	for _, target_player in pairs(sorted_players) do
		if not target_player.valid or not target_player.mo then continue end
		local tmo = target_player.mo

		if not tmo.valid then continue end
		if not player.showownname and player == target_player then continue end
		if not player.showbotnames and target_player.bot == 1 then continue end
		if tmo.espio_battleopacity != nil then continue end

		--how far away is the other player?
		local distance = R_PointToDist(tmo.x, tmo.y)

		local distlimit = 1000
		if distance > distlimit*FRACUNIT then continue end

		--Angle between camera vector and target
		local hangdiff = R_PointToAngle2(cam.x, cam.y, tmo.x, tmo.y)
		local hangle = hangdiff - cam.angle

		--check if object is outside of our field of view
		--converting to fixed just to normalise things
		--e.g. this will convert 365° to 5° for us
		local fhanlge = AngleFixed(hangle)
		local fhfov = AngleFixed(fov/2)
		local f360 = AngleFixed(ANGLE_MAX)
		if fhanlge < f360 - fhfov and fhanlge > fhfov then
			continue
		end
		
		--flipcam adjustment
		local flip = 1
		if displayplayer.mo and displayplayer.mo.valid
			flip = P_MobjFlip(displayplayer.mo)
		end

		--figure out vertical angle
		local h = FixedHypot(cam.x-tmo.x, cam.y-tmo.y)
		local tmoz = tmo.z
		if (flip == -1)
			tmoz = tmo.z + tmo.height
		end
		if spectator
			tmoz = $ - 48*tmo.scale
		end
		local vangdiff = R_PointToAngle2(0, 0, tmoz-cam.z-48*FRACUNIT*flip, h) - ANGLE_90
		local vcangle = first_person and player.aiming or cam.aiming or 0
		
		local vangle = (vcangle + vangdiff) * flip

		--again just check if we're outside the FOV
		local fvangle = AngleFixed(vangle)
		local fvfov = FixedMul(AngleFixed(fov), FRACUNIT*v.height()/v.width())
		if fvangle < f360 - fvfov and fvangle > fvfov then
			continue
		end

		local hpos = hudwidth/2 - FixedMul(hud_distance, tan(hangle) * realwidth/width)
		local vpos = hudheight/2 + FixedMul(hud_distance, tan(vangle) * realheight/height)

		local name = target_player.name
		local health = ("["+tostring(target_player.mo.health)+"/"+tostring(target_player.mo.maxHealth)+"]")

		local namefont = "thin-fixed-center"
		local ringfont = "small-fixed-center"
		local charwidth = 5
		local lineheight = 8
		if distance > 500*FRACUNIT then
			--namefont = "small-thin-fixed-center"
			--ringfont = "small-thin-fixed-center"
			--charwidth = 4
			--lineheight = 4
		end

		local flash = (leveltime/(TICRATE/6))%2 == 0
		local rflags = V_YELLOWMAP
		if flash and target_player.mo.health == 0 then
			rflags = V_REDMAP
		end

		local nameflags = skincolors[target_player.skincolor].chatcolor
		local distedit = max(0, distance - (distlimit*FRACUNIT/2)) * 2
		local trans = min(9, (((distedit * 10) / FRACUNIT) / distlimit)) * V_10TRANS
		v.drawString(hpos, vpos, name, nameflags|trans|V_ALLOWLOWERCASE, namefont)
		v.drawString(hpos, vpos+(lineheight*FRACUNIT), health, rflags|trans|V_ALLOWLOWERCASE, ringfont)

		if not target_player.lastmessagetimer then continue end

		local chat_lifespan = 2*TICRATE
		chat_lifespan = $1 + #target_player.lastmessage * TICRATE / 18

		if target_player.lastmessage
		and leveltime < target_player.lastmessagetimer+chat_lifespan then
			local flags = V_GRAYMAP
			local thelines = string_linebreak(v, target_player.lastmessage, flags)
			for i = 1, #thelines
				v.drawString(hpos, vpos+(lineheight*(i+1)*FRACUNIT), thelines[i], flags|trans|V_ALLOWLOWERCASE, namefont)
			end
		end
	end
end, "game")

addHook("PlayerMsg", function(player, typenum, target, message)
	if typenum ~= 0 then
		return false --only for normal global messages
	end
	if ignorelist != nil and #ignorelist
		for i = 1, #ignorelist
			if ignorelist[i] == player
				return false
			end
		end
	end

	player.lastmessage = message
	player.lastmessagetimer = leveltime
	return false
end)

local consoleplayer_camera = nil
hud.add(function(v, player, camera)
	consoleplayer_camera = camera
end, "game")

addHook("PostThinkFrame", function()
	sorted_players = {}
	for player in players.iterate() do
		if player and player.valid and player.mo and player.mo.valid then
			if displayplayer and displayplayer.realmo and displayplayer.realmo.valid
				local cam = displayplayer.realmo
				if consoleplayer_camera and consoleplayer_camera.chase
					cam = consoleplayer_camera
				end
				local thok = P_SpawnMobj(cam.x, cam.y, cam.z, MT_THOK)
				local sight = P_CheckSight(thok, player.mo)
				P_RemoveMobj(thok)
				if not sight
					continue
				end
			end
			table.insert(sorted_players, player)
		end
	end
	--This list will be different for every player in a network game
	--Don't use it for anything other than HUD drawing
	table.sort(sorted_players, function(a, b)
		return R_PointToDist(a.mo.x, a.mo.y) > R_PointToDist(b.mo.x, b.mo.y)
	end)
end)

addHook("MapLoad", function()
	for player in players.iterate() do
		player.lastmessage = nil
		player.lastmessagetimer = nil
	end
end)