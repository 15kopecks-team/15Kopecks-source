function onCreate()
    setProperty('camZooming', true)
doTweenAlpha("camA", "camGame", 0, 0.01, "linear")
end



function onStepHit()

if curStep == 2 then
doTweenAlpha("camA", "camGame", 1, 0.5, "circInOUt")
end
    --[[if curStep == 197 or curStep == 207 or curStep == 219 or curStep == 269 or curStep == 273 or curStep == 709 or curStep == 717 or curStep == 777 or curStep == 798 or curStep == 843 or curStep == 855 or curStep == 875 or curStep == 887 or curStep == 914 or curStep == 933 or curStep == 945 or curStep == 1141 then
        triggerEvent("Camera Follow Pos", getMidpointX('boyfriend')-600, getMidpointY('dad'))
    elseif curStep == 205 or curStep == 209 or curStep == 261 or curStep == 271 or curStep == 283 or curStep == 707 or curStep == 713 or curStep == 734 or curStep == 781 or curStep == 837 or curStep == 849 or curStep == 869 or curStep == 881 or curStep == 907 or curStep == 920 or curStep == 939 or curStep == 951 or curStep == 1152 or curStep == 1206 then
        triggerEvent("Camera Follow Pos", getMidpointX('dad')+200, getMidpointY('dad'))
    end
    if curStep == 223 or curStep == 287 or curStep == 719 or curStep == 798 or curStep == 888 or curStep == 952 or curStep == 1153 or curStep == 1215 then
        triggerEvent("Camera Follow Pos",'', '')
    end]]--
end