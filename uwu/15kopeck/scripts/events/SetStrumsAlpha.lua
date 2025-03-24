function onEvent(name,val1)
	if name == "SetStrumsAlpha" then
		for i = 0,3 do
            setPropertyFromGroup('strumLineNotes', i, 'alpha', val1)
            end
	end
end