package states.songSelect;

import flixel.FlxG;
import flixel.FlxSprite;
import openfl.display.BlendMode;
import backend.Highscore;
import backend.Song;

class SelectedSongSubstate extends MusicBeatSubstate
{
    public static var songName:String;

    var gradient:FlxSprite;
    var cover:FlxSprite;
    var coverStartingX:Float = -FlxG.width;
    var coverPos:Array<Float> = [FlxG.width * -0.14, FlxG.height * -0.06];

    final songDisplayNames:Map<String, String> = [
        "tuberculosis" => "lostel - Tuberculosis", 
        "kvartira-42" => "simnsnd - Kvartira 42", 
        "daemae" => "simnsnd - Daemae", 
        "st4r-fever" => "lostel - St4r Fever", 
        "bing-chillin" => "lostel - Bing Chilling", 
        "pig-ful" => "XhonZ - Pigful", 
        "beer-n-cider" => "lostel - Beer n' Cider"
    ];

    var startButton:FlxText;
    var songNameDisplay:FlxText;

    var busy:Bool = true;

    override function create()
    {
        super.create();

        gradient = new FlxSprite(Paths.image('menus/fr/gradient/$songName'));
        gradient.alpha = 0.00001;
        gradient.screenCenter();
        gradient.scrollFactor.set(0, 0);
        gradient.blend = BlendMode.MULTIPLY;
        add(gradient);

        cover = new FlxSprite(coverStartingX, coverPos[1], Paths.image('menus/fr/covers/$songName'));
        cover.scale.set(0.6, 0.6);
        cover.scrollFactor.set(0, 0);
        add(cover);

        startButton = new FlxText(FlxG.width * 0.6, FlxG.height * 2, "Start", 64);
        startButton.setFormat(Paths.font("AkiraExpanded-SuperBold.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        startButton.scrollFactor.set(0, 0);
        startButton.updateHitbox();
        add(startButton);

        var textSize:Int;
        switch (songName)
        {
            case "pig-ful":
                textSize = 64;
            case "daemae":
                textSize = 52; //52!!!!!!!
            case "st4r-fever":
                textSize = 40;
            default:
                textSize = songDisplayNames[songName].length * 2;
        }

        songNameDisplay = new FlxText((songName == "pig-ful" || songName == "daemae") ? FlxG.width * 0.425 : FlxG.width * 0.45, -FlxG.height, songDisplayNames[songName], textSize);
        songNameDisplay.setFormat(Paths.font("AkiraExpanded-SuperBold.ttf"), textSize, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        songNameDisplay.scrollFactor.set(0, 0);
        songNameDisplay.updateHitbox();
        add(songNameDisplay);

        FlxTween.tween(startButton, {y: FlxG.height * 0.6}, 0.2, {ease: FlxEase.sineOut});
        FlxTween.tween(songNameDisplay, {y: FlxG.height * 0.28}, 0.2, {ease: FlxEase.sineOut});
        FlxTween.tween(gradient, {alpha: 1}, 0.2, {ease: FlxEase.sineOut});
        FlxTween.tween(cover, {x: coverPos[0]}, 0.25, {
            ease: FlxEase.sineOut,
            onComplete: function(tween:FlxTween) busy = false
        });
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (busy) return;

        startButton.alpha = FlxMath.lerp(startButton.alpha, FlxG.mouse.overlaps(startButton) ? 0.2 : 1, elapsed * 10);

        if (FlxG.mouse.overlaps(startButton) && FlxG.mouse.justPressed) 
        {
            busy = true;

            FlxG.camera.fade(FlxColor.BLACK, 0.2);
            FlxTween.tween(startButton, {y: FlxG.height * 2}, 0.2, {ease: FlxEase.sineOut});
            FlxTween.tween(songNameDisplay, {y: -FlxG.height}, 0.2, {ease: FlxEase.sineOut});
            FlxTween.tween(gradient, {alpha: 0.00001}, 0.2, {ease: FlxEase.sineOut});
            FlxTween.tween(cover, {x: coverStartingX}, 0.25, {
                ease: FlxEase.sineOut,
                onComplete: function(tween:FlxTween) startSong()
            });
        }

        if (controls.BACK) 
        {
            busy = true;

            FlxTween.tween(startButton, {y: FlxG.height * 2}, 0.2, {ease: FlxEase.sineOut});
            FlxTween.tween(songNameDisplay, {y: -FlxG.height}, 0.2, {ease: FlxEase.sineOut});
            FlxTween.tween(gradient, {alpha: 0.00001}, 0.2, {ease: FlxEase.sineOut});
            FlxTween.tween(cover, {x: coverStartingX}, 0.25, {
                ease: FlxEase.sineOut,
                onComplete: function(tween:FlxTween) close()
            });
        }
    }

    function startSong():Void
    {
        var songLowercase:String = Paths.formatToSongPath(songName);
        trace(songLowercase);
        try
        {
            PlayState.SONG = Song.loadFromJson(songLowercase, songLowercase);
            PlayState.songPath = songLowercase + "/charts/"+ songLowercase;
            trace(PlayState.songPath);
            PlayState.isStoryMode = false;  
            PlayState.storyDifficulty = 1;
        }
        catch(e:Dynamic)
        {
            trace('ERROR! $e');

            var errorStr:String = e.toString();
            if(errorStr.startsWith('[file_contents,assets/data/')) errorStr = 'Missing file: ' + errorStr.substring(34, errorStr.length-1); //Missing chart

            trace('ERROR WHILE LOADING CHART: $errorStr');

            FlxG.sound.music.stop();
            FlxG.sound.play(Paths.sound('cancelMenu'));
            return;
        }
        LoadingState.loadAndSwitchState(new PlayState());
    }
}