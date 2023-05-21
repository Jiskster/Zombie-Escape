local MV = MapVote
local NET = MapVoteNet

freeslot("SKINCOLOR_PITCHBLACK")
skincolors[SKINCOLOR_PITCHBLACK] = {
    name = "Pitch Black",
    ramp = {31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31},
    invcolor = SKINCOLOR_WHITE,
    invshade = 0,
    chatcolor = V_GRAYMAP,
    accessible = false
}

hud.add(function(v)
	if not netgame return end
	local player = consoleplayer
	
	if NET.state == MV_SCORE
		local timeleft = (MV.cv_scoretime.value * TICRATE) - NET.timer - 1
		local secondsleft = (timeleft/TICRATE) + 1
		v.drawString(160, 180, "Vote begins in "..secondsleft.." seconds", V_ALLOWLOWERCASE | V_SNAPTOBOTTOM | V_YELLOWMAP, "center")
		return
	end
	
	if NET.state == MV_VOTE
		local numchoices = #NET.choices
		for	i = 1, numchoices
			local map = NET.choices[i]
			local patchname = MV.GetExtMapnumFromInt(map) + "P"
			if not v.patchExists(patchname)
				patchname = "BLANKLVL"
			end
			local image = v.cachePatch(patchname)
			local name = MV.GetNameFromMapnum(map)

			local gtname = NET.gametypedata[NET.gtchoices[i]].name

			local highlighted = player.mapvote and player.mapvote.vote_slot and player.mapvote.vote_slot == i
			local colormap 
			
			if NET.timer <= 1
				colormap = v.getColormap(TC_ALLWHITE)
			elseif NET.timer <= 2
				colormap = v.getColormap(TC_RAINBOW, SKINCOLOR_WHITE)
			elseif NET.timer <= 3
				colormap = v.getColormap(TC_RAINBOW, SKINCOLOR_GREY)
			elseif highlighted
				colormap = v.getColormap(TC_DEFAULT)
			else
				colormap = v.getColormap(TC_RAINBOW, SKINCOLOR_SILVER)
			end
			
			local xx = 80
			local yy = 46
			local pos = (i - (numchoices/2)) * 2
			if (#NET.choices % 2)
				pos = $ - 1
			end
			xx = $ + 44 * pos
			
			if mapheaderinfo[tonumber(map)].zombieswarm then -- if zombie swarm header then rename gametype to fake
				gtname = "Zombie Swarm"
			end
			if highlighted
				v.drawScaled(FRACUNIT*(xx+4), FRACUNIT*(yy+4), FRACUNIT / 2, image, V_60TRANS, v.getColormap(TC_BLINK, SKINCOLOR_PITCHBLACK))
				v.drawScaled(FRACUNIT*(xx-2), FRACUNIT*(yy-2), FRACUNIT / 2, image, 0, colormap)
				v.drawScaled(FRACUNIT*(xx-3), FRACUNIT*(yy-3), FRACUNIT / 2, v.cachePatch("VOTESLCT"), 0)
				
				MV.DrawLevelName(v, name, gtname, xx - 1, yy, V_ALLOWLOWERCASE | V_SNAPTOLEFT | V_YELLOWMAP)
			else
				v.drawScaled(FRACUNIT*(xx+2), FRACUNIT*(yy+2), FRACUNIT / 2, image, V_60TRANS, v.getColormap(TC_BLINK, SKINCOLOR_PITCHBLACK))
				v.drawScaled(FRACUNIT*xx, FRACUNIT*yy, FRACUNIT / 2, image, 0, colormap)
				MV.DrawLevelName(v, name, gtname, xx + 1, yy + 2, V_ALLOWLOWERCASE | V_SNAPTOLEFT)
			end
			
			local headxpadding = 14
			local headypadding = 9
			local headxstart = xx + 11
			local headx = headxstart
			local heady = yy + 62
			local amountheads = 0
			local waveoffset = 0
			for player in players.iterate
				local pmv = player.mapvote
				if pmv and pmv.vote_slot == i and pmv.voted
					local head = v.getSprite2Patch(player.skin, SPR2_LIFE)
					local cmap = v.getColormap(nil, player.skincolor)
					local trans = 0
					waveoffset = $ + 2
					amountheads = $ + 1
					local wave = max(0, 8 * (sin((NET.timer - waveoffset) * ANG10) - FRACUNIT*2/3))
					v.drawScaled(FRACUNIT*headx, FRACUNIT*(heady) - wave, FRACUNIT, head, trans, cmap)
					headx = $ + headxpadding
					if (amountheads) % 5 == 0
						heady = $ + headypadding
						headx = headxstart
					end
				end
			end
			for player in players.iterate
				local pmv = player.mapvote
				if pmv and pmv.vote_slot == i and not pmv.voted
					local head = v.getSprite2Patch(player.skin, SPR2_LIFE)
					local cmap = v.getColormap(TC_ALLWHITE)
					local trans = V_70TRANS
					waveoffset = $ + 2
					amountheads = $ + 1
					local wave = max(0, 8 * (sin((NET.timer - waveoffset) * ANG10) - FRACUNIT*2/3))
					v.drawScaled(FRACUNIT*headx, FRACUNIT*(heady) - wave, FRACUNIT, head, trans, cmap)
					headx = $ + headxpadding
					if (amountheads) % 5 == 0
						heady = $ + headypadding
						headx = headxstart
					end
				end
			end
		end
		
		local timeleft = (MV.cv_votetime.value * TICRATE) - NET.timer - 1
		local secondsleft = (timeleft/TICRATE) + 1
		v.drawString(160, 30, "*VOTING*", 0, "center")
		v.drawString(160, 175, "Select: JUMP     Cancel: SPIN", V_ALLOWLOWERCASE | V_SNAPTOBOTTOM, "small-center")
		
		local timercolor = "\130"
		if timeleft <= 3 * TICRATE
			if timeleft % TICRATE == 0
				timercolor = "\133"
			elseif timeleft % TICRATE == 34
				timercolor = "\135"
			end
		end
		
		v.drawString(160, 180, "\130Vote ends in "..timercolor..secondsleft.." seconds", V_ALLOWLOWERCASE | V_SNAPTOBOTTOM, "center")
		return
	end
	
	if NET.state == MV_END
		local timeleft = (6 * TICRATE) - NET.timer - 1
		local secondsleft = (timeleft/TICRATE) + 1
		
		local patchname = MV.GetExtMapnumFromInt(NET.nextmap) + "P"
		if not v.patchExists(patchname)
			patchname = "BLANKLVL"
		end
		local mapimage = v.cachePatch(patchname)
		local fullname = MV.GetFullTitle(NET.nextmap, nil)
		
		v.drawString(160, 30, "*DECISION*", 0, "center")
		v.draw(86, 52, mapimage, V_60TRANS, v.getColormap(TC_BLINK, SKINCOLOR_PITCHBLACK))
		v.draw(80, 46, mapimage, 0)
		v.draw(80-2, 46-2, v.cachePatch("VOTESLCT"), 0)
		
		v.drawString(160, 147, "Speeding off to", V_ALLOWLOWERCASE | V_SNAPTOBOTTOM | V_SKYMAP, "thin-center")
		v.drawString(160, 157, fullname, V_ALLOWLOWERCASE | V_SNAPTOBOTTOM | V_YELLOWMAP, "center")
		v.drawString(160, 166, "("..NET.gametypedata[NET.nextgt].name..")", V_ALLOWLOWERCASE | V_SNAPTOBOTTOM | V_YELLOWMAP, "small-center")
		v.drawString(160, 174, "In " + secondsleft + " seconds", V_ALLOWLOWERCASE | V_SNAPTOBOTTOM | V_SKYMAP, "thin-center")
		
		local xx = 500 - 10 * NET.timer
		local runframeamt = 4
		local tailframeamt = 4
		local tailframe = 0
		local tailsprite = nil
		local tailoffsetx = 10
		local tailoffsety = 0
		if NET.runskin == "tails"
			runframeamt = 2
			tailframe = (NET.timer / 2) % tailframeamt
			tailsprite = v.getSprite2Patch("tails", SPR2_TAL6, false, tailframe, 3)
		elseif NET.runskin == "amy"
			runframeamt = 8
		elseif NET.runskin == "fang"
			runframeamt = 6
		elseif NET.runskin == "metalsonic"
			runframeamt = 1
			tailframeamt = 3
			tailframe = (NET.timer / 2) % tailframeamt
			tailsprite = v.getSpritePatch("JETF", tailframe)
			tailoffsetx = 18
			tailoffsety = -11
		end
		local runframe = (NET.timer / 2) % runframeamt
		local charcmap = v.getColormap(TC_ALLWHITE)
		local charsprite = v.getSprite2Patch(NET.runskin, SPR2_RUN, false, runframe, 3)
		
		for i = 2, 0, -1
			local trans = 0
			if i == 2
				trans = V_80TRANS
			elseif i == 1
				trans = V_60TRANS
			end
			if tailsprite
				v.draw(xx + tailoffsetx + (i*32), 48 + tailoffsety, tailsprite, V_SNAPTORIGHT | V_SNAPTOTOP | trans, charcmap)
			end
			v.draw(xx + (i*32), 48, charsprite, V_SNAPTORIGHT | V_SNAPTOTOP | trans, charcmap)
		end
		return
	end
end, "intermission")