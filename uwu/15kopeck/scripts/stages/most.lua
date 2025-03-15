function onCreate() 
	makeLuaSprite('mostik', 'most', -2300,-1900);
	addLuaSprite('mostik', false);
	scaleObject('mostik', 1.8, 1.8);
	
end
function onCreatePost()
	triggerEvent('Camera Follow Pos', '500', '-3000')
	setProperty('cameraSpeed', '5')
	scaleObject('boyfriend', 1.5, 1.5)
	scaleObject('dad', 1.2, 1.2)
	
	end