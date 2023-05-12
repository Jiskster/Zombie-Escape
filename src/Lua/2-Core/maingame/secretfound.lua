local ZE = RV_ZESCAPE
local CV = RV_ZESCAPE.Console

ZE.secretsound = function()
	ZE.secretShow()
	S_StartSound(nil, sfx_secret)
end

ZE.secretShow = function()
	ZE.secretshowtime = 5*TICRATE
end

ZE.secretTick = function()
	if ZE.secretshowtime then
		ZE.secretshowtime = $ - 1
	end
end