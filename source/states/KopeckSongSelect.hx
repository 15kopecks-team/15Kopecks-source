package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.util.FlxSignal;
import flixel.group.FlxGroup.FlxTypedGroup;
import backend.Highscore;
import backend.Song;

class KopeckSongSelect extends MusicBeatState
{
	private var bg:FlxSprite;
	private var bgStairs:FlxSprite;
	private var items:FlxSprite;

    final objectPositions:Array<Array<Float>> = [
        [820, 100],
        [750, 580],
        [1120, 670],
        [1250, -800],
        [1220, 800],
        [450, 250],
        [1000, 780]];

    final objectData:Array<Array<String>> = [
        ["cigarate", "tuberculosis"], 
        ["key", "kvartira-42"], 
        ["cassete", "daemae"], 
        ["boombox", "st4r-fever"], 
        ["ramen", "bing-chillin"], 
        ["mask", "pig-ful"], 
        ["can", "beer-n-cider"]];

    private var objects:FlxTypedGroup<KopeckSongObject>;

	private var cameraFollow:FlxObject;

    var busy:Bool = false;

	override function create()
	{
		bg = new FlxSprite(Paths.image("menus/fr/bg"));
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.data.antialiasing;
		add(bg);

		bgStairs = new FlxSprite(Paths.image("menus/fr/bgStairs"));
		bgStairs.screenCenter();
		bgStairs.antialiasing = ClientPrefs.data.antialiasing;
		add(bgStairs);

		items = new FlxSprite(Paths.image("menus/fr/items"));
		items.setPosition(bg.x, bg.y);
		items.antialiasing = ClientPrefs.data.antialiasing;
		add(items);

        objects = new FlxTypedGroup<KopeckSongObject>();
        for (i in 0...objectData.length)
        {
            final songObject:KopeckSongObject = new KopeckSongObject(objectPositions[i][0], objectPositions[i][1], objectData[i][0], objectData[i][1]);
            songObject.onPress.add(pressedButton);
            songObject.x += items.x;
            songObject.y += items.y;
            songObject.updateHitbox();

            objects.add(songObject);
        }
        add(objects);

		cameraFollow = new FlxObject(FlxG.width / 2, FlxG.height / 2);
		FlxG.camera.follow(cameraFollow, .16);
		FlxG.camera.zoom = 0.85;

		super.create();
	}

    function pressedButton():Void
    {
        objects.forEach(function(item:KopeckSongObject) item.blocked = true);
        busy = true;
    }

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        cameraFollow.x = (FlxG.width / 2.5 + FlxG.mouse.gameX / (bg.width / FlxG.width * 2)) * FlxG.camera.zoom;
		cameraFollow.y = (FlxG.height / 2.5 + FlxG.mouse.gameY / (bg.height / FlxG.height * 2)) * FlxG.camera.zoom;

        if (busy) return;

        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'), 0.7);
            FlxG.switchState(new KopeckMenu());
        }
	}
}

class KopeckSongObject extends FlxSprite
{
    var songName:String;

    public var blocked:Bool = false;

    public var selected:Bool = false;

    public var onSelect(default, null):FlxSignal = new FlxSignal();

    public var onDeselect(default, null):FlxSignal = new FlxSignal();

    public var onPress(default, null):FlxSignal = new FlxSignal();

    public function new(xPos:Float, yPos:Float, objectName:String, songName:String)
    {
        super(xPos, yPos);

        this.songName = songName;
        //alpha = 0.00001;

        frames = Paths.getSparrowAtlas('menus/fr/objects/$objectName', "content");
		animation.addByPrefix("start", objectName + "_start", 24, false);
        animation.addByPrefix("loop", objectName + "_loop", 24, true);

        SetupSignals();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (blocked) return;
    
        if (FlxG.mouse.overlaps(this))
        {
            if (FlxG.mouse.justPressed)
            {
                onPress.dispatch();
            }
            else
            {
                onSelect.dispatch();
            }
        }
        else if (selected && !FlxG.mouse.overlaps(this))
        {
            onDeselect.dispatch();
        }
    }

    function SetupSignals():Void
    {
        onSelect.add(SelectButton);
        onDeselect.add(DeselectButton);
        onPress.add(PressButton);
    }

    function SelectButton():Void
    {
        if (!selected)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'), 0.7);
            selected = true;
            alpha = 1;

            animation.play("start");
        }
    }

    function DeselectButton():Void
    {
        if (selected)
        {
            selected = false;
            alpha = 0.5;
            //alpha = 0.00001;

            animation.play("loop");
        }
    }

    function PressButton():Void
    {
        FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
        animation.play("start");

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            startSong();
        });
    }

    function startSong():Void
    {
        var songLowercase:String = Paths.formatToSongPath(songName);
		var poop:String = songLowercase;
		trace(poop);
        try
        {
            PlayState.SONG = Song.loadFromJson(poop, songLowercase);
            PlayState.songPath = poop + "/charts/"+ songLowercase;
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

            FlxG.sound.play(Paths.sound('cancelMenu'));
            return;
        }
        LoadingState.loadAndSwitchState(new PlayState());
    }
}