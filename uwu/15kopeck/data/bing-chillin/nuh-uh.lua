--Пошло говно
function onCreate()
setProperty("skipCountdown", true)
--Съёмка видео запрещена. Камеру вырубай нахуй
setProperty("camHUD.alpha", 0)

--Бадабумчики для Middle+Up scroll
    if middlescroll == true and downscroll == false then
    makeAnimatedLuaSprite("boom", "boom",975,-50)
    scaleObject("boom",3.5, 3.5)
    setObjectCamera("boom", 'hud')

    makeAnimatedLuaSprite("boom2", "boom",65,-50)
    scaleObject("boom2",3.5, 3.5)
    setObjectCamera("boom2", 'hud')
    setProperty("boom2.flipX", true)
    end
-- для Middle+Down scroll
    if middlescroll == true and downscroll == true then
    makeAnimatedLuaSprite("boom", "boom",975,470)
    scaleObject("boom",3.5, 3.5)
    setObjectCamera("boom", 'hud')
    
    makeAnimatedLuaSprite("boom2", "boom",65,470)
    scaleObject("boom2",3.5, 3.5)
    setObjectCamera("boom2", 'hud')
    setProperty("boom2.flipX", true)
    end
--для Upscroll
    if middlescroll == false and downscroll == false then
    makeAnimatedLuaSprite("boom", "boom",120,-180)
    scaleObject("boom",6, 6)
    doTweenAngle("boomy", "boom", -30, 0.1, "linear")
    setObjectCamera("boom", 'hud')
    end
--для Downscroll
    if middlescroll == false and downscroll == true then
    makeAnimatedLuaSprite("boom", "boom",120,300)
    scaleObject("boom",6, 6)
    doTweenAngle("boomy", "boom", -20, 0.1, "linear")
    setObjectCamera("boom", 'hud')
    end
end

function onStepHit()
-- Катаем стрелочки на середину
    if curStep == 832 and middlescroll == false then
    noteTweenX("notex", 5, getPropertyFromGroup("strumLineNotes", 5, 'x')-315, 1, "quadInOut")
    noteTweenX("notex2", 4, getPropertyFromGroup("strumLineNotes", 4, 'x')-315, 1, "quadInOut")
    noteTweenX("notex3", 6, getPropertyFromGroup("strumLineNotes", 6, 'x')-315, 1, "quadInOut")
    noteTweenX("notex4", 7, getPropertyFromGroup("strumLineNotes", 7, 'x')-315, 1, "quadInOut")
-- А теперь обратно
    elseif curStep == 1150 and middlescroll == false then
        noteTweenX("notex", 5, getPropertyFromGroup("strumLineNotes", 5, 'x')+315, 1, "quadInOut")
        noteTweenX("notex2", 4, getPropertyFromGroup("strumLineNotes", 4, 'x')+315, 1, "quadInOut")
        noteTweenX("notex3", 6, getPropertyFromGroup("strumLineNotes", 6, 'x')+315, 1, "quadInOut")
        noteTweenX("notex4", 7, getPropertyFromGroup("strumLineNotes", 7, 'x')+315, 1, "quadInOut")
    end

--Верни камеру
    if curStep == 163 then
        doTweenAlpha("hi", "camHUD", 1, 7, "cubeOut")
    end
    if curStep == 768 then
--Добавляем бадабумчиков(без ёбанной Ениной)
        addLuaSprite("boom")
        setObjectOrder('boom', getObjectOrder('noteGroup')+1)
        addAnimationByPrefix('boom', 'boom idle', 'boom idle', 24, false)
        addLuaSprite("boom2")
        setObjectOrder('boom2', getObjectOrder('noteGroup')+1)
        addAnimationByPrefix('boom2', 'boom idle', 'boom idle', 24, false)
        runTimer('a', 1)
    end
-- Фу.... элемент HUD'a
        if hideHud == false and curStep == 768 then
        setProperty('timeBar.visible', false) 
        setProperty('timeBarBG.visible', false) 
        setProperty('timeTxt.visible', false) 
        setProperty('scoreTxt.visible', false) 
        setProperty('iconP1.visible', false) 
        setProperty('iconP2.visible', false) 
        setProperty('healthBar.visible', false) 
       setProperty('healthBarBG.visible', false) 
        end
    if curStep == 769 or curStep == 884 or curStep == 888 or curStep == 880 or curStep == 892 or curStep == 899 then
        fuck = false
    end
    if curStep == 1152 then
    fuck = true
    end
--Верни хуб
    if curStep == 1152 and hideHud == false then
    setProperty('timeBar.visible', true) 
    setProperty('timeBarBG.visible', true) 
    setProperty('timeTxt.visible', true) 
    setProperty('scoreTxt.visible', true) 
    setProperty('iconP1.visible', true) 
    setProperty('iconP2.visible', true) 
    setProperty('healthBar.visible', true)
   setProperty('healthBarBG.visible', true) 
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
--Прощаемся с бадабумчиком :(
    if tag == 'a' then
removeLuaSprite("boom", true)
removeLuaSprite("boom2", true)
    end
end

--[[function onTweenCompleted(tag, ?vars)
    if name == "blackR" then
            doTweenAngle("blackR", "black", -30,0.5, "quadInOut")
     elseif name =="blackR2" then
            doTweenAngle("blackR2", "black1", -30,0.5, "quadInOut")
    end
end ]]--
