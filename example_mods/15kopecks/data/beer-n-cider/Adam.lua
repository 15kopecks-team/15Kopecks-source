function onCreate()
    doTweenZoom("zoom", "camGame", 0.9, 0.1, "linear")
    doTweenAlpha("booba", 'camGame', 0, 0.1, "linear")
end
function onStepHit()
    if curStep == 1 then
    doTweenZoom("zoom", "camGame", 0.5, 0.5, "cubeOut")
    doTweenAlpha("booba", 'camGame', 1, 0.5, "cubeOut")
    end
--[[РКН момент
    if curStep == 1540 or curStep == 1544 or curStep == 1549 or curStep == 1552 or curStep == 1561 or curStep == 1566 or curStep == 1570 or curStep == 1581 or curStep == 1586 or curStepp == 1590 then
        doTweenAlpha("booba1", 'camHUD', 0, 0.01, "linear")
        doTweenAlpha("booba2", 'camGame', 0, 0.01, "linear")
    elseif curStep >= 1000 then
          doTweenAlpha("booba1", 'camHUD', 1, 0.1, "linear")
          doTweenAlpha("booba2", 'camGame', 1, 0.1, "linear")
    end]]--
end