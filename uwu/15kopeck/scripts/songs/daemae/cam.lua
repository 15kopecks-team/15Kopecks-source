function onCreatePost()
    doTweenAlpha("game", "camGame", 0, 0.1, "linear")
    setProperty("camZooming", false)
end

function onStepHit()
    if curStep == 4 then
        doTweenAlpha("game", "camGame", 1, 1, "cubeOut")
        doTweenZoom("zoom", "camGame", 0.5, 2, "cubeOut")
    end
end