local ZE = RV_ZESCAPE
local CV = ZE.Console

ZE.RemoveZtypesOnLeave = function(player)
	/*
		Loop through the players submitted ztypes.
		Check their author (maybe not)
		Properly delete it on the name list and the global (name list: ordered, global unordered)
		do above only if its equal to the leaving player
	*/
	
	for i,v in ipairs(ZE.Ztypes.names)
		if ZE.Ztypes[v] and not ZE.Ztypes[v].protected then -- check protected cause why not
			if ZE.Ztypes[v].info.author == player then
				ZE.Ztypes[v] = nil
				table.remove(ZE.Ztypes.names, i)
			end
		end
	end

	player.submittedztypes = {} -- lower memory a bit before its gone for good
end