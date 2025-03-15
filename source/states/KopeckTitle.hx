package states;

import flixel.text.FlxText;
import flixel.input.keyboard.FlxKey;

import states.fr.FreeplayState;

class KopeckTitle extends MusicBeatState {

    var titleText:FlxText;
    var logo:FlxSprite;

    var flash:Int = 0;
    var canControl:Bool = true;
    var timer:Float = 0;

    override function create() {

        if(FlxG.sound.music == null) {
            FlxG.sound.playMusic(Paths.music(states.InitState.menuMusic), 0);
        }

        FlxG.sound.playMusic(Paths.music(states.InitState.menuMusic), 0);
        FlxG.sound.music.fadeIn(4, 0, 0.7);

        Conductor.bpm = InitState.bpm;
		persistentUpdate = true;

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menus/title/bg"));
        bg.scale.set(1.2, 1.2);
        bg.screenCenter(X);
        add(bg);

        logo = new FlxSprite().loadGraphic(Paths.image("menus/title/пися"));
        logo.scale.set(0.2, 0.2);
        logo.updateHitbox();
        logo.screenCenter();
        add(logo);

        titleText = new FlxText(0, 600, 0, "Nazmi na Enter", 20, true);
        titleText.setFormat(Paths.font("AkiraExpanded-SuperBold.ttf"), 40, FlxColor.TRANSPARENT, CENTER, FlxTextBorderStyle.OUTLINE, 0xFFFFFFFF);
        titleText.screenCenter(X);
        add(titleText);

        super.create();


        FlxG.camera.alpha = 0;

        FlxTween.tween(FlxG.camera, {alpha: 1}, 5,{ease:FlxEase.circInOut});
        
    }
    override function update(elapsed:Float) {
        if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;


        
        var pressedEnter = FlxG.keys.justPressed.ENTER || controls.ACCEPT;


        if(pressedEnter && canControl){
            canControl = false;

            FlxG.camera.flash(ClientPrefs.data.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

            FlxG.camera.zoom += 0.3;
            FlxTween.tween(FlxG.camera, {zoom: 1}, 0.4);
            
            new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					MusicBeatState.switchState(new KopeckMenu());
				});
        }

        if(FlxG.keys.justPressed.CONTROL)
            MusicBeatState.switchState(new FreeplayState());

        if(!canControl){
            if(flash == 0){
                titleText.setFormat(Paths.font("AkiraExpanded-SuperBold.ttf"), 40, FlxColor.RED, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
                flash = 1;
            }
            else if(flash == 1){
                titleText.setFormat(Paths.font("AkiraExpanded-SuperBold.ttf"), 40, FlxColor.TRANSPARENT, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.RED);
                flash = 0;
            }
        }

        super.update(elapsed);
    }

    var lastBeatHit:Int = -1;

    override function beatHit()
        {
            if(lastBeatHit >= curBeat) {
                //trace('BEAT HIT: ' + curBeat + ', LAST HIT: ' + lastBeatHit);
                return;
            }

            if(curBeat %2 == 0 && canControl){
                FlxG.camera.zoom += 0.15;
                FlxTween.tween(FlxG.camera, {zoom: 1}, 0.2);
            }
        }
}