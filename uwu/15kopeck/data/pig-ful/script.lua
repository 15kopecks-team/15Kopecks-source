local active = 0
function onCreate()
    setProperty('showComboNum', false);
end
function onUpdate()
    if active == 1 then
        triggerEvent("Set Camera Zoom", 0.4)
        triggerEvent("Camera Follow Pos", 600, 200)
    end
end

function onStepHit()
   if  curStep == 1151 or curStep == 1407 or curStep == 1664 then
        active = 1
   elseif curStep == 1278 or curStep == 1599 then
    active = 0
   end
end