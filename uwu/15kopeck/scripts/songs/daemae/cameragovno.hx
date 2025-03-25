var shader:Dynamic;
var shader2:Dynamic;

function onCreatePost(){
  game.initLuaShader("mobile");
  game.initLuaShader("contr");
    
  shader = game.createRuntimeShader("mobile");
  shader2 = game.createRuntimeShader("contr");

  FlxG.game.setFilters([new ShaderFilter(shader2), new ShaderFilter(shader)]);

  game.triggerEvent('Camera Follow Pos', 500, -1500);
  game.cameraSpeed = 0.2;
  game.camHUD.alpha = 0;
  game.camZooming = false;
}

function onStepHit(){
  if(curStep == 65){
      game.cameraSpeed = 1;
      FlxTween.tween(game.camHUD, {alpha: 1}, 1);
  }
}

function onDestroy() {
    FlxG.game.setFilters([new ShaderFilter(shader)]);
}