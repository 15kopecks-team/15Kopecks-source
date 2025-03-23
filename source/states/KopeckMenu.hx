package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSignal;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import options.OptionsState;
#if DISCORD_ALLOWED
import backend.Discord.DiscordClient;
#end
import states.songSelect.KopeckSongSelect;

import sys.io.Process;
import sys.FileSystem;

class KopeckMenu extends MusicBeatState
{
    var justStarted:Bool = true;

    final buttonNames:Array<String> = ["Credits", "Play", "Settings"];
    final buttonPositions:Array<Array<Float>> = [[FlxG.width * 0.6, FlxG.height * 0.5], [FlxG.width * 0.325, FlxG.height * 0.075], [FlxG.width * 0.1, FlxG.height * 0.4]];
    final buttonTargetStates:Array<FlxState> = [null, new KopeckSongSelect(), new OptionsState()];

    private var buttons:FlxTypedGroup<KopeckMenuItem>;

    var busy:Bool = false;

    override function create() {
        if(FlxG.sound.music == null) {
            FlxG.sound.playMusic(Paths.music(states.InitState.menuMusic), 0);
        }

        if (justStarted)
        {
            FlxG.sound.music.fadeIn(4, 0, 0.7);
            justStarted = false;
        }

        #if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menus/main/bg"));
        bg.setGraphicSize(bg.width * 0.69, bg.height * 0.69);
        bg.updateHitbox();
        add(bg);

        buttons = new FlxTypedGroup<KopeckMenuItem>();
        for (i in 0...buttonNames.length)
        {
            final menuItem:KopeckMenuItem = new KopeckMenuItem(buttonPositions[i][0], buttonPositions[i][1], buttonNames[i], buttonTargetStates[i]);
            menuItem.onPress.add(pressedButton);
            menuItem.updateHitbox();

            buttons.add(menuItem);
        }
        add(buttons);

        super.create();
    }

    function pressedButton():Void
    {
        buttons.forEach(function(item:KopeckMenuItem) item.name == 'Credits' ? item.blocked = false : item.blocked = true);
        busy = false; 
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (busy) return;
    }
}

class KopeckMenuItem extends FlxSprite
{
    var originX:Float;

    var originY:Float;

    public var name:String;

    var targetState:FlxState;

    public var theFakeHitbox:FlxSprite;

    public var blocked:Bool = false;

    public var selected:Bool = false;

    public var onSelect(default, null):FlxSignal = new FlxSignal();

    public var onDeselect(default, null):FlxSignal = new FlxSignal();

    public var onPress(default, null):FlxSignal = new FlxSignal();

    public function new(xPos:Float, yPos:Float, name:String, targetState:FlxState)
    {
        super(xPos, yPos);

        originX = xPos;
        originY = yPos;
        this.name = name;
        this.targetState = targetState;

        final menuItemPath:String = (name == "Credits") ? name.toLowerCase() : "logo" + name.toLowerCase();
        frames = Paths.getSparrowAtlas("menus/main/buttons/" + menuItemPath, "content");
        animation.addByPrefix("idle", "idle_choosed", 24, true);
        animation.addByPrefix("pressed", name + "_pressed", 24, false);
        animation.addByPrefix("choosed", name + "_choosed", 24, false);

        final outAnim:String = (name == "Credits") ? "Credits_full" : "logo" + name.toLowerCase() + "_exit";
        animation.addByPrefix("out", outAnim, 24, false);
        playAnim("out");

        scale.set(0.6, 0.6);

        theFakeHitbox = new FlxSprite(xPos + 100, yPos + 100).makeGraphic(250, 250, FlxColor.WHITE);
        if (name == "Credits")
        {
            theFakeHitbox.x -= 25;
            theFakeHitbox.y -= 25;
        }

        SetupSignals();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (selected && animation.curAnim != null && animation.curAnim.name == "choosed" && animation.curAnim.finished) playAnim("idle");

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
            if (name == "Credits") 
                playAnim("idle");
            else
                playAnim("choosed");
        }
    }

    function DeselectButton():Void
    {
        if (selected)
        {
            selected = false;
            playAnim("out");
        }
    }

    function PressButton():Void
    {
        FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
        playAnim("pressed");

        new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            if(name != "Credits")
                FlxG.switchState(targetState);
            else{
                openHTML();
            }
                
        });
    }

    function openHTML():Void {
        var htmlPath:String = "content/15Koppek/index.html"; // Adjust the path as needed
        if (FileSystem.exists(htmlPath)) {
            lime.system.System.openFile(htmlPath);
        } else {
            trace("Error: File not found - " + htmlPath);
        }
    }

    function playAnim(anim:String):Void
    {
        if (anim == "out")
        {
            playOutAnim();
            return;
        }

        x = originX;
        y = originY;

        switch (name)
        {
            case "Credits":
                if (anim == "idle")
                {
                    x = originX - 5;
                    y = originY - 7.5;
                }

            case "Settings":
                if (anim == "choosed") y = originY - 27;
        }

        animation.play(anim);
    }

    function playOutAnim():Void
    {
        // Im sorry that i didn't use normal animation offsets, for me this way is more comfortable.
        var offsets:Array<Float> = [0, 0];
        switch (name)
        {
            case "Credits":
                offsets = [26, 38];
            case "Play":
                offsets = [45, 30];
            case "Settings":
                offsets = [35, -5];
        }

        x = originX + offsets[0];
        y = originY + offsets[1];
        animation.play("out");
    }
}