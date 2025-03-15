function onCreatePost()
makeLuaSprite('wall', 'metro/wall', -1000, -300)
makeLuaSprite('floor', 'metro/floor', -1000, 1000)
makeLuaSprite('arcap', 'metro/arcap', -1000, -295)
makeLuaSprite('arcaz', 'metro/arcaz', -1000, -300)
makeLuaSprite('tablo', 'metro/tablo', -300, -180)

scaleObject('bgnez', 1, 1)

addLuaSprite('wall', false)
addLuaSprite('floor', false)
addLuaSprite('arcaz', false)
addLuaSprite('tablo', false)
addLuaSprite('arcap', true)

setScrollFactor('wall', 0.8, 1)
setScrollFactor('tablo', 0.9, 1)
setScrollFactor('arcaz', 0.85, 1)
end