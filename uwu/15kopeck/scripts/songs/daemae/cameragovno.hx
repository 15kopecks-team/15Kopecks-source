function onCreatePost(){
  game.triggerEvent('Camera Follow Pos', 500, -1500);
  game.cameraSpeed = 0.2;
  game.camHUD.alpha = 0;
}

function onStepHit(){
  if(curStep == 65){
      game.cameraSpeed = 1;
      FlxTween.tween(game.camHUD, {alpha: 1}, 1);
  }
}