function onCreate()
	setProperty('camGame.visible', false)
	setProperty('camZooming', true)
end

function onStepHit()
	if curStep == 127 then
		setProperty('camGame.visible', true)
	end
	if curStep == 1172 then
		setProperty('camGame.visible', false)
	end
	if curStep == 1183 then
		setProperty('camGame.visible', true)
	end
end