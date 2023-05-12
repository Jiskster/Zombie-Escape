local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.alpha_attack = 0
ZE.alpha_attack_show = 0 -- gui show time

ZE.Start_alpha_attack = function()
	if gametype == GT_ZESCAPE
		ZE.alpha_attack = 1
		S_ChangeMusic("ZMATK", false)
		P_StartQuake(10*FRACUNIT, 6*TICRATE)
	end
end

ZE.Inc_Show_alpha_attack = function() --increments ZE.alpha_attack_show if its not done showing
	if ZE.alpha_attack_doneshow == false then
		if ZE.alpha_attack == 1 then
			ZE.alpha_attack_show = $ + 1
		end
		if ZE.alpha_attack_show > 15*TICRATE then
			S_ChangeMusic(mapmusname, true)
			ZE.alpha_attack_doneshow = true
		end
	end
end
