package objects;
import backend.ClientPrefs;

class SustainSplash extends FlxSprite {
  public static var colors = ["Purple", "Blue", "Green", "Red"];
  public static var activeCovers = [999 => null];
  public var opponent:Bool = false;

  var thisCoverId:Int = -1;
  public function new():Void {
    super();

    frames = Paths.getSparrowAtlas('noteHoldSpalsh/noteHoldCovers');

    for (color in colors)
    {
        animation.addByPrefix('start$color', 'holdCoverStart$color', 24, false);
        animation.addByPrefix('hold$color', 'holdCover$color', 24, true);
        if(!opponent)
          animation.addByPrefix('end$color', 'holdCoverEnd$color', 24, false);
    }
    animation.finishCallback = (n:String) -> 
    
    antialiasing = ClientPrefs.data.antialiasing;
  }

  public var endTimer:FlxTimer;
  public function setupSusSplash(strum:StrumNote, daNote:Note):Void {
    // if (SustainSplash.activeCovers.exists(daNote.noteData))
    //   return;

    animation.play('start${colors[daNote.noteData]}', true);
    endTimer = new FlxTimer().start(daNote.sustainLength / 1000, (_) -> animation.play('end${colors[daNote.noteData]}'));
    SustainSplash.activeCovers.set(thisCoverId = daNote.noteData, this);

    setPosition(strum.x, strum.y);
    offset.set(106.25, 100);
  }

  override function update(elapsed:Float) {
    if((animation.name?.startsWith("end") && opponent) || animation.curAnim == null)
      kill();

    if (animation.name?.startsWith('start'))
      animation.play('hold${animation.name.replace("start", "")}', true);

    if ((animation.name?.startsWith("end") && animation.finished) || animation.curAnim == null)
      kill();

    super.update(elapsed);
  }

  public override function kill()
  {
    SustainSplash.activeCovers.remove(thisCoverId);
    super.kill();
  }
}