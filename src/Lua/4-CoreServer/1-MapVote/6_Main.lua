local MV = MapVote
local NET = MapVoteNet

addHook("MapLoad", do
	if not netgame return end
	NET.state = MV_SCORE
	NET.timer = 0
	if NET.gametypedata[gametype] and NET.gametypedata[gametype].config
		COM_BufInsertText(server, NET.gametypedata[gametype].config)
	end
end)

--No clue why this doesn't work without a damn timer
local setup = TICRATE
addHook("ThinkFrame", do
	if setup > 0
		setup = $ - 1
		if setup <= 0
			COM_BufInsertText(server, "inttime MAX")
		end
	end
end)

addHook("IntermissionThinker", do
	if not netgame return end
	NET.timer = $ + 1
	
	for player in players.iterate
		if (player.mapvote == nil)
			player.mapvote = {}
			player.mapvote.vote_slot = 2
			player.mapvote.voted = false
			player.mapvote.prevbuttons = player.cmd.buttons
		end
	end
	--Scoreboard
	if NET.state == MV_SCORE
		if not hud.enabled("intermissiontally")
			hud.enable("intermissiontally")
		end
		local timeleft = (MV.cv_scoretime.value * TICRATE) - NET.timer
		if (timeleft <= 0)
			S_StartSound(nil, sfx_s243)
			NET.state = MV_VOTE
			NET.timer = 0
			NET.choices = MV.GetRandomMaps(3)
			NET.gtchoices = {}
			for i = 1, #NET.choices
				NET.gtchoices[i] = MV.GetARandomGametype(NET.choices[i])
			end
		end
		return
	else
		if hud.enabled("intermissiontally")
			hud.disable("intermissiontally")
		end
	end
	
	--Voting
	if NET.state == MV_VOTE
		local timeleft = (MV.cv_votetime.value * TICRATE) - NET.timer
		if timeleft > 0
		
			for player in players.iterate
				local pmv = player.mapvote
				local btn = player.cmd.buttons
				local pbtn = pmv.prevbuttons
				local left = (player.cmd.sidemove <= -40)
				local right = (player.cmd.sidemove >= 40)
				local pleft = pmv.prevleft
				local pright = pmv.prevright
				local confirm =	((btn & BT_JUMP) and not (pbtn & BT_JUMP)) or ((btn & BT_ATTACK) and not (pbtn & BT_ATTACK))
				local cancel = (btn & BT_SPIN) and not (pbtn & BT_SPIN)
				local scrollleft = left and not pleft
				local scrollright = right and not pright
				
				if not pmv.voted
					--Select a map with up and down
					if (scrollleft or scrollright)
						S_StartSound(nil, sfx_s240, player)
						if scrollleft
							pmv.vote_slot = $ - 1
						elseif scrollright
							pmv.vote_slot = $ + 1
						end
						if pmv.vote_slot > #NET.choices
							pmv.vote_slot = 1
						end
						if pmv.vote_slot < 1
							pmv.vote_slot = #NET.choices
						end
					end
					
					--Confirm the selection with jump or attack button
					if confirm
						S_StartSound(nil, sfx_s3k63, player)
						pmv.voted = true
					end
				elseif cancel
					S_StartSound(nil, sfx_s3k72, player)
					pmv.voted = false
				end
				
				pmv.prevbuttons = btn
				pmv.prevleft = left
				pmv.prevright = right
			end
			
			if (timeleft <= 3 * TICRATE)
				if (timeleft % TICRATE == 0)
					S_StartSound(nil, sfx_s3k89)
				end
				if (timeleft % TICRATE == 28)
					S_StartSoundAtVolume(nil, sfx_s3k89, 70)
				end
			end
		else
			S_StartSound(nil, sfx_lvpass)
			NET.state = MV_END
			NET.timer = 0
			NET.nextmap = 1
			NET.nextgt = GT_COOP
			if consoleplayer and consoleplayer.mapvote and not consoleplayer.mapvote.voted
				S_StartSound(nil, sfx_s3k74, consoleplayer)
			end
			
			local skinlist = {"sonic", "tails", "knuckles", "amy", "fang", "metalsonic"}
			NET.runskin = skinlist[P_RandomRange(1, #skinlist)]
			
			local tally = {}
			for i = 1, #NET.choices+1
				tally[i] = 0
			end
			for player in players.iterate
				local pmv = player.mapvote
				if pmv and pmv.voted and pmv.vote_slot
					tally[pmv.vote_slot] = $ + 1
				end
				player.mapvote = nil
			end
			
			local votedslot = 1
            if MV.cv_weightedrandom.value
                local num_votes = 0
                for i = 1,3
					tally[i] = $ + MV.cv_baseweight.value
                    num_votes = $ + tally[i]
                end
				
				if num_votes == 0
					votedslot = P_RandomRange(1,3)
				else
					local weight_select = P_RandomKey(num_votes) + 1
					--print(num_votes)
					--print(weight_select)
					local vote_count = 0
					for i = 1,3
						local current_tally = tally[i]
						--print(vote_count + current_tally)
						if weight_select <= vote_count + current_tally
							votedslot = i
							break
						else
							vote_count = $ + current_tally
						end
					end
				end
            else
				if tally[1] == tally[2] and tally[1] == tally[3]
					votedslot = P_RandomRange(1,3)
					print("\130There's a three-way tie! Picking randomly...")
				elseif tally[1] == tally[2] and tally[3] < tally[1] --two way tiebreaker, slot 1 or 2
					votedslot = P_RandomRange(1,2)
					print("\130There's a two-way tie! Picking randomly...")
				elseif tally[2] == tally[3] and tally[1] < tally[2] --two way tiebreaker, slot 2 or 3
					votedslot = P_RandomRange(2,3)
					print("\130There's a two-way tie! Picking randomly...")
				elseif tally[1] == tally[3] and tally[2] < tally[1] --two way tiebreaker, slot 1 or 3
					if P_RandomRange(1,2) == 1
						votedslot = 1
					else
						votedslot = 3
					end
					print("\130There's a two-way tie! Picking randomly...")
				else
					local best = 0
					for i = 1, 3
						if tally[i] > best
							best = tally[i]
							votedslot = i
						end
					end
				end
			end
			NET.nextmap = NET.choices[votedslot]
			NET.nextgt = NET.gtchoices[votedslot]
			print("\130The winner is: "..MV.GetFullTitle(NET.nextmap, NET.nextgt))
		end
		return
	end
	
	--End
	if NET.state == MV_END
		local timeleft = (6 * TICRATE) - NET.timer
		if (timeleft <= 0)
			NET.state = MV_MAPCHANGE
			COM_BufInsertText(server, "map "..NET.nextmap.." -gt "..NET.nextgt.." -f")
		end
		return
	end
end)