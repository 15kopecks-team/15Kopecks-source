function onCreatePost()
    makeLuaSprite("test2", 'piggy2', -70,-120)
    scaleObject("test2", 0.4,0.4)
    setObjectCamera("test2", 'other')
    addLuaSprite("test2", false)
    makeLuaSprite("test", 'piggy', -70,-120)
    scaleObject("test", 0.4,0.4)
    setObjectCamera("test", 'other')
    addLuaSprite("test", false)
--  doTweenAlpha('hudalpha', 'camHUD', 0, 1, 'expoIn');

end
function onStepHit()
    if curStep == 1 then
        doTweenAlpha("ok", "test", 0.0, 0.5, "expoOut")
        scaleObject("test2", 0.4,0.4)
    end
if curStep == 15 then
 --   doTweenZoom("ok2", "camHUD", 3, 1, "circIn")
 doTweenX("booga", "test2.scale", 3, 2, "circIn")
 doTweenY("booga2", "test2.scale", 3, 2, "circIn")

elseif curStep == 28 then
--  doTweenZoom("ok3", "camHUD", 0, 0, "linear")
    removeLuaSprite("test",false)
    removeLuaSprite("test2",false)
end
if curStep == 25 then
 doTweenAlpha('hudalpha', 'camHUD', 1, 1, 'expoIn');
end
if curStep == 783 then
    doTweenAlpha('hudalpha', 'camGame', 0, 0.3, 'expoOut');
    doTweenAlpha('hudalpha2', 'camHUD', 0, 0.3, 'expoOut');
elseif curStep == 800 then
    doTweenAlpha('hudalpha2', 'camHUD', 1, 0.3, 'linear');
    doTweenAlpha('hudalpha', 'camGame', 1, 0.3, 'linear');
end
end

---
--- @param tag string
--- @param ?vars ?
---
