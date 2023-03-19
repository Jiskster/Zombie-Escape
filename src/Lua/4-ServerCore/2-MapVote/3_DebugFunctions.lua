local MV = MapVote
local NET = MapVoteNet

MV.DebugPrint = function(str)
	if MV.cv_debug.value
		print(str)
	end
end

MV.PrintArr = function(a)
	for i = 1, #a
		MV.DebugPrint(a[i])
	end
end