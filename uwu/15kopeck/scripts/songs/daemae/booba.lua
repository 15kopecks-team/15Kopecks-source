local active = 0
function onCreatePost()
    active = 1
end
function onStepHit()
    if curStep == 127 or curStep == 895 then
        active = 0
    elseif curStep == 639 or curStep == 1151 then
        active = 1
    end
end

---
--- @param elapsed float
---
function onUpdatePost(elapsed)
    if active == 1 then
        -- triggerEvent("Camera Follow Pos", 600, 600)
    elseif active == 0 then
        -- triggerEvent("Camera Follow Pos", '','')
    end
end
