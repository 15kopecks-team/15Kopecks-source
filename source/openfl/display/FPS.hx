package openfl.display;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;
import openfl.display.Sprite;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
class FPS extends Sprite
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	/**
		The current memory usage (WARNING: this is NOT your total program memory usage, rather it shows the garbage collector memory)
	**/
	public var memoryMegas(get, never):Float;

	@:noCompletion private var times:Array<Float>;

	@:noCompletion var fpsText:TextField;
	@:noCompletion var backFpsText:TextField;
	@:noCompletion var outlines:Array<TextField> = [];

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x00FF00)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;

		backFpsText = new TextField();
		backFpsText.defaultTextFormat = new TextFormat(openfl.utils.Assets.getFont("assets/fonts/MOSCOW2024.otf").fontName, 12);
		backFpsText.width = FlxG.width;
		backFpsText.selectable = backFpsText.mouseEnabled = false;
		backFpsText.textColor = 0xFF000000;
		backFpsText.x += 1;
		backFpsText.y += 1;

		fpsText = new TextField();
		fpsText.defaultTextFormat = new TextFormat(openfl.utils.Assets.getFont("assets/fonts/MOSCOW2024.otf").fontName, 12);
		fpsText.width = FlxG.width;
		fpsText.selectable = fpsText.mouseEnabled = false;

		// var iterations = 4;
		// final deezNuts = (1/iterations)*Math.PI*2;
		// while (iterations > -1){
		// 	var otext:TextField = new TextField();
		// 	otext.x = Math.sin(deezNuts * iterations) * 2;
		// 	otext.y = Math.cos(deezNuts * iterations) * 2;
		// 	otext.defaultTextFormat = fpsText.defaultTextFormat;
		// 	otext.textColor = 0x000000;
		// 	otext.width = fpsText.width;
		// 	otext.selectable = otext.mouseEnabled = false;
		// 	outlines.push(otext);
		// 	addChild(otext);
		// 	iterations--;
		// }
		for(i in [backFpsText, fpsText])
			addChild(i);

		times = [];
	}

	var deltaTimeout:Float = 0.0;

	// Event Handlers
	private override function __enterFrame(deltaTime:Float):Void
	{
		// prevents the overlay from updating every frame, why would you need to anyways
		if (deltaTimeout > 1000) {
			deltaTimeout = 0.0;
			return;
		}

		final now:Float = haxe.Timer.stamp() * 1000;
		times.push(now);
		while (times[0] < now - 1000) times.shift();

		currentFPS = times.length < FlxG.updateFramerate ? times.length : FlxG.updateFramerate;		
		updateText();
		deltaTimeout += deltaTime;
	}

	public dynamic function updateText():Void { // so people can override it in hscript
		fpsText.text = '${currentFPS}:FPS'
		+ '\n MEM:${flixel.util.FlxStringUtil.formatBytes(memoryMegas)}';

		backFpsText.text = fpsText.text;

		fpsText.textColor = 0xFF00FF00;
		if (currentFPS < FlxG.drawFramerate * 0.5)
			fpsText.textColor = 0xFFFF0000;

		// for (outline in outlines)
		// 	outline.text = fpsText.text;
	}

	inline function get_memoryMegas():Float
		return cast(System.totalMemory, UInt);
}
