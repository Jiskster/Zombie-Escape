--TODO
addHook("HurtMsg", function(player, inflictor, source)
	if not player.mo.health
		if inflictor and inflictor.player
			print(player.name + " was killed by " + inflictor.player.name + ".")
		elseif source and source.player
			if inflictor.info.name
				print(player.name + " was killed by " + source.player.name + "'s " + inflictor.info.name + ".")
			else
				print(player.name + " was killed by " + source.player.name + ".")
			end
		else
			print(player.name + " died.")
		end
	end
	return true
end)