var shader:Dynamic;
var shader2:Dynamic;

function onPostCreate() {
    game.initLuaShader("mobile");
    game.initLuaShader("contr");
    
    shader = game.createRuntimeShader("mobile");
    shader2 = game.createRuntimeShader("contr");

    FlxG.game.setFilters([new ShaderFilter(shader), new ShaderFilter(shader2)]);
}

function onDestroy() {
    FlxG.game.setFilters([]);
}