function onCreatePost()
makeAnimatedLuaSprite('poezdba', 'metro/poezdba', -800, 50)
makeAnimatedLuaSprite('poezdma', 'metro/poezdma', -1000, 500)

addAnimationByPrefix('poezdba', 'poezdba', 'poezdba', 24, false)
addAnimationByPrefix('poezdma', 'poezdma', 'poezdma', 24, false)

setObjectOrder('poezdba', getObjectOrder('arcap') + 1)
setObjectOrder('poezdma', getObjectOrder('arcaz') - 1)

addLuaSprite('poezdba', false)
addLuaSprite('poezdma', false)

setProperty('poezdba.alpha', 0)
setProperty('poezdma.alpha', 0)

scaleObject('poezdba', 2.1, 2.1)
scaleObject('poezdma', 1.8, 1.8)

end

function onStepHit()

if curStep == 73 then
setProperty('poezdba.alpha', 1)
objectPlayAnimation('poezdba','poezdba', true)
end

if curStep == 208 then
setProperty('poezdma.alpha', 1)
objectPlayAnimation('poezdma','poezdma', true)
end

if curStep == 538 then
objectPlayAnimation('poezdma','poezdma', true)
end

if curStep == 624 then
objectPlayAnimation('poezdba','poezdba', true)
end

if curStep == 816 then
objectPlayAnimation('poezdba','poezdba', true)
end

if curStep == 892 then
objectPlayAnimation('poezdma','poezdma', true)
end

if curStep == 1124 then
objectPlayAnimation('poezdma','poezdma', true)
end

if curStep == 1206 then
objectPlayAnimation('poezdba','poezdba', true)
end

if curStep == 1278 then
objectPlayAnimation('poezdma','poezdma', true)
end

if curStep == 1379 then
objectPlayAnimation('poezdba','poezdba', true)
end

if curStep == 1382 then
setProperty('boyfriend.alpha', 0)
setProperty('dad.alpha', 0)
end

end

