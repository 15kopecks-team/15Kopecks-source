function onCreatePost()
	makeLuaSprite('bus', 'bus', -1900, -1220)
	scaleObject('bus', 1.2, 1.2)
addLuaSprite('bus',false)
end

function onUpdate(elapsed)
	setProperty("newHealthBar.y", 600)
end