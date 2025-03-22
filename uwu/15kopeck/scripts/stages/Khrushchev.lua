local active = 1
function onCreatePost()
	makeLuaSprite('Old', 'Khrushchev', -1300, -900)
	scaleObject('Old', 1, 1)
addLuaSprite('Old',false)
doTweenAlpha("bgBye", "Old", 0, 5, "circOut")
end

--ЛЭЭЭЭЭЭЭЭ КУДА ПРЁШЬ


---
--- @param elapsed float
---
function onUpdatePost(elapsed)
if active == 1 then
	triggerEvent("Camera Follow Pos", 600, 200)
	end
	if active == 0 then
		triggerEvent("Camera Follow Pos", '', '')
		end
end
function onStepHit()
	if curStep == 100 then
		doTweenAlpha("bgBye", "Old", 1, 3, "circIn")
elseif curStep == 2176 then
	cameraFlash("other", "FFFFFF", 3, false)
	for i = 0,7 do
		setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
	end
end
if curStep == 2176 and hideHud == true then
	active = 1
	setProperty('timeBar.visible', false) 
	setProperty('timeBarBG.visible', false) 
	setProperty('timeTxt.visible', false) 
	setProperty('scoreTxt.visible', false) 
elseif curStep == 2176 and hideHud == false then
	active = 1
	setProperty('timeBar.visible', false) 
	setProperty('timeBarBG.visible', false) 
	setProperty('timeTxt.visible', false) 
	setProperty('scoreTxt.visible', false) 
	setProperty('iconP1.visible', false) 
	setProperty('iconP2.visible', false) 
	setProperty('healthBar.visible', false) 
	-- setProperty('showRating', false);
--    setProperty('showComboNum', false);
   setProperty('healthBarBG.visible', false) 
end
if curStep == 2416 then
	cameraFade("other", "000000", 5, false)
end
	if curStep == 127 then
		active = 0
	end
end