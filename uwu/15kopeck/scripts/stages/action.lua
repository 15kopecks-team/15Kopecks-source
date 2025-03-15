function onCreate() 
	makeLuaSprite('A4Kids', 'HahaKidsDoBrrr', -1600,-900);
	addLuaSprite('A4Kids', false);
	scaleObject('A4Kids', 1.4, 1.4);
	makeLuaSprite('red', 'caramelldansen/HahaKidsDoBrrr1', -1600,-900);
	scaleObject('red', 1.4, 1.4);
	makeLuaSprite('green', 'caramelldansen/HahaKidsDoBrrr2', -1600,-900);
	scaleObject('green', 1.4, 1.4);
	makeLuaSprite('yellow', 'caramelldansen/HahaKidsDoBrrr3', -1600,-900);
	scaleObject('yellow', 1.4, 1.4);
	makeLuaSprite('purple', 'caramelldansen/HahaKidsDoBrrr4', -1600,-900);
	scaleObject('purple', 1.4, 1.4);
	makeLuaSprite('blue', 'caramelldansen/HahaKidsDoBrrr5', -1600,-900);
	scaleObject('blue', 1.4, 1.4);

end

---
--- @param eventName string
--- @param value1 string
--- @param value2 string
--- @param strumTime float
---
function onEvent(eventName, v1)
	if eventName == 'caramelldansen' and v1 == 'red' then
		addLuaSprite('red', false);
	elseif v1 == 'red0' then
	removeLuaSprite("red",false)
	end
	if eventName == 'caramelldansen' and v1 == 'green' then
		addLuaSprite('green', false);
	elseif v1 == 'green0' then
		removeLuaSprite("green",false)
	end
	if eventName == 'caramelldansen' and v1 == 'yellow' then
		addLuaSprite('yellow', false);
	elseif v1 == 'yellow0' then
		removeLuaSprite("yellow",false)
	end
	if eventName == 'caramelldansen' and v1 == 'blue' then
		addLuaSprite('blue', false);
	elseif v1 == 'blue0' then
		removeLuaSprite("blue",false)
	end
	if eventName == 'caramelldansen' and v1 == 'purple' then
		addLuaSprite('purple', false);
	elseif v1 == 'purple0' then
		removeLuaSprite("purple",false)
	end
	if eventName == 'caramelldansen' and v1 == 'bye' then
		removeLuaSprite("blue",false)
		removeLuaSprite("purple",false)
		removeLuaSprite("red",false)
		removeLuaSprite("green",false)
		removeLuaSprite("yellow",false)
	end
end
local active = 0
function onStepHit()
	if curStep == 15 then
		doTweenX("camX", "camFollow",600, 1, "circOut")
		doTweenY("camY", "camFollow",600, 1, "circOut")
	end
	if curStep == 790 then
		active = 1
	end
	if curStep == 143 then
		active = 0
	end
end

function onBeatHit()
	if curBeat == 264 then
		active = 0
	end
end

	---
	--- @param tag string
	--- @param ?vars ?
	---
	function onTweenCompleted(tag)
		if tag == 'camX' then
			active = 1
		end
	end
	

	---
	--- @param elapsed float
	---
	function onUpdatePost(elapsed)
		if active == 1 then
			triggerEvent("Camera Follow Pos", 600, 600)
		elseif active == 0 then
			triggerEvent("Camera Follow Pos", '', '')
	end
end