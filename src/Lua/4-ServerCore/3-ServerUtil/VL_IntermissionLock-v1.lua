local allow = true
addHook("IntermissionThinker", do
	if allow
		COM_BufInsertText(server, "allowjoin off")
		allow = false
	end
end)
addHook("MapLoad", do
	if not allow
		COM_BufInsertText(server, "allowjoin on")
		allow = true
	end
end)