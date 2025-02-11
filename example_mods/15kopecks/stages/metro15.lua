function onCreate() 
	makeLuaSprite('metro15', 'metro15', -700,-900);
	addLuaSprite('metro15', false);
	scaleObject('metro15', 0.9, 0.9);

end

function onCreatePost()
	setProperty("camZooming", true);
end