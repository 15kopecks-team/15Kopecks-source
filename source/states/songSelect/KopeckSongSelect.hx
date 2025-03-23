package states.songSelect;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.util.FlxSignal;
import flixel.group.FlxGroup.FlxTypedGroup;
#if DISCORD_ALLOWED
import backend.Discord.DiscordClient;
#end
import states.songSelect.SelectedSongSubstate;

class KopeckSongSelect extends MusicBeatState
{
	private var bg:FlxSprite;
	private var bgStairs:FlxSprite;
	private var items:FlxSprite;

    final objectPositions:Array<Array<Float>> = [
        [555, -25],
        [475, 430],
        [840, 340],
        [1170, 380],
        [950, 645],
        [155, 95],
        [710, 620]
    ];

    final objectData:Array<Array<String>> = [
        ["cigarate", "tuberculosis"], 
        ["key", "kvartira-42"], 
        ["cassete", "daemae"], 
        ["boombox", "st4r-fever"], 
        ["ramen", "bing-chillin"], 
        ["mask", "pig-ful"], 
        ["can", "beer-n-cider"]
    ];

    private var objects:FlxTypedGroup<KopeckSongObject>;

	private var cameraFollow:FlxObject;

    var busy:Bool = false;

    public var selectedSong:String;
    var cover:FlxSprite;
    var gradient:FlxSprite;

	override function create()
	{
        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

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

    override function closeSubState()
    {
        super.closeSubState();

        objects.forEach(function(item:KopeckSongObject) item.blocked = false);
        busy = false;
    }

	override function update(elapsed:Float)
	{
		super.update(elapsed);

        if (busy) return;

        cameraFollow.x = (FlxG.width / 2.5 + FlxG.mouse.gameX / (bg.width / FlxG.width * 2)) * FlxG.camera.zoom;
		cameraFollow.y = (FlxG.height / 2.5 + FlxG.mouse.gameY / (bg.height / FlxG.height * 2)) * FlxG.camera.zoom;

        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'), 0.7);
            FlxG.switchState(new KopeckMenu());
        }
    }
}

class KopeckSongObject extends FlxSprite
{
    var originX:Float;

    var originY:Float;

    var songName:String;

    public var theFakeHitbox:FlxSprite;

    public var blocked:Bool = false;

    public var selected:Bool = false;

    public var onSelect(default, null):FlxSignal = new FlxSignal();

    public var onDeselect(default, null):FlxSignal = new FlxSignal();

    public var onPress(default, null):FlxSignal = new FlxSignal();

    public function new(xPos:Float, yPos:Float, objectName:String, songName:String)
    {
        super(xPos, yPos);

        this.originX = xPos;
        this.originY = yPos;
        this.songName = songName;

        frames = Paths.getSparrowAtlas('menus/fr/objects/$objectName', "content");
        animation.addByPrefix("idle", objectName + "_idle", 24, true);
        animation.addByPrefix("loop", objectName + "_loop", 24, true);
		animation.addByPrefix("start", objectName + "_start", 24, false);
        playAnim("idle");

        theFakeHitbox = new FlxSprite(xPos, yPos).makeGraphic(200, 200, FlxColor.WHITE);
        theFakeHitbox.scrollFactor.set(0.5, 0.5);

        SetupSignals();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (selected && animation.curAnim != null && animation.curAnim.name == "start" && animation.curAnim.finished) playAnim("loop");

        if (blocked) return;
    
        if (FlxG.mouse.overlaps(theFakeHitbox))
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
        else if (selected && !FlxG.mouse.overlaps(theFakeHitbox))
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

            playAnim("loop");
        }
    }

    function DeselectButton():Void
    {
        if (selected)
        {
            selected = false;
            playAnim("idle");
        }
    }

    function PressButton():Void
    {
        FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
        playAnim("start");

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            SelectedSongSubstate.songName = songName;
            FlxG.state.openSubState(new SelectedSongSubstate());
        });
    }

    function playAnim(anim:String):Void
    {
        if (anim == "idle")
        {
            x = originX;
            y = originY;
        }
        else
        {
            var offsets:Array<Float> = [0, 0];
            switch (songName)
            {
                case "tuberculosis":
                    offsets = [-30, -40];
                case "kvartira-42":
                    offsets = [-60, -5];
                case "daemae":
                    offsets = [-50, -60];
                case "st4r-fever":
                    offsets = [-43, -40];
                case "bing-chillin":
                    offsets = [-15, -30];
                case "pig-ful":
                    offsets = [-30, -20];
                case "beer-n-cider":
                    offsets = [-30, -20];
            }
            x = originX + offsets[0];
            y = originY + offsets[1];
        }

        animation.play(anim);
    }
}