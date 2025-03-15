package states;

class KopeckMenu extends MusicBeatState{

    // var list:Array<String> = ['Play', 'Settings', 'Credits'];
    var playBtn:FlxSprite;
    var setBtn:FlxSprite;
    var credBtn:FlxSprite;

    override function create() {
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menus/main/bg"));
        bg.setGraphicSize(1310, 750);
        bg.updateHitbox();
        add(bg);

        playBtn = new FlxSprite(0, 300);
        playBtn.frames = Paths.getSparrowAtlas('menus/main/buttons/Play_Button');
        playBtn.animation.addByPrefix('choosed', 'idle_choosed', 24, true);
        playBtn.animation.play('choosed');
        add(playBtn);

        super.create();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        // FlxG.camera.x = FlxMath.lerp(FlxG.camera.x, (FlxG.mouse.screenX - (FlxG.width / 2)) * 0.020, (1 / 30) * 130 * elapsed);
        // FlxG.camera.y = FlxMath.lerp(FlxG.camera.y, (FlxG.mouse.screenY - 4 - (FlxG.height / 2)) * 0.020, (1 / 30) * 130 * elapsed);
    }
}