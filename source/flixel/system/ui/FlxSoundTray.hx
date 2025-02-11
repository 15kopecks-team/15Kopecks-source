
package flixel.system.ui;

#if FLX_SOUND_SYSTEM
import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
#if flash
import openfl.text.AntiAliasType;
import openfl.text.GridFitType;
#end

/**
 * The flixel sound tray, the little volume meter that pops down sometimes.
 * Accessed via `FlxG.game.soundTray` or `FlxG.sound.soundTray`.
 */
class FlxSoundTray extends Sprite
{
	var lerpYPos:Float = 0;
  	var alphaTarget:Float = 0;
	var _yPosScreen:Float = 0;
	/**
	 * Because reading any data from DisplayObject is insanely expensive in hxcpp, keep track of whether we need to update it or not.
	 */
	public var active:Bool;

	/**
	 * Helps us auto-hide the sound tray after a volume change.
	 */
	var _timer:Float;

	/**
	 * Helps display the volume bars on the sound tray.
	 */
	var _bars:Array<Bitmap>;

	/**
	 * How wide the sound tray background is.
	 */
	var _width:Int = 80;

	var _defaultScale:Float = 0.5;

    public var volumeUpSound:String = "beep";
	public var volumeDownSound:String = "beep";

    public var spritesPath:String = "images/ui/soundTray/";
    // "assets/shared/images/shared/images/ui/soundTray/casete.png"

	/**Whether or not changing the volume should make noise.**/
	public var silent:Bool = false;

    /**sprite speaker**/
    

	/**
	 * Sets up the "sound tray", the little volume meter that pops down sometimes.
	 */
	@:keep
	public function new()
	{
		super();

		visible = false;
		scaleX = _defaultScale;
		scaleY = _defaultScale;

        final splashSprite:Bitmap = new Bitmap(openfl.utils.Assets.getBitmapData(Paths.getPath(spritesPath + 'caseta.png', IMAGE)), null, true);
		_width = Std.int(splashSprite.width);
        addChild(splashSprite);
        screenCenter();

		_bars = new Array();

		for (i in 0...10)
			{
			  var bar:Bitmap = new Bitmap(openfl.utils.Assets.getBitmapData(Paths.getPath(spritesPath + 'tray${i + 1}.png', IMAGE)) ,null ,true);
			  addChild(bar);
			  _bars.push(bar);
			}

		y = -height;
		visible = false;

		FlxG.signals.gameResized.add(function (w, h) {
			_yPosScreen = 0;
		});
	}

	/**
	 * This function updates the soundtray object.
	 */
	public function update(MS:Float):Void
	{
		y = coolLerp(y, lerpYPos, 0.1);
		alpha = coolLerp(alpha, alphaTarget, 0.25);
		
		// Animate sound tray thing
		if (_timer > 0)
		{
			_timer -= (MS / 1000);
			alphaTarget = 1;
		}
		else if (y <= height)
		{
			lerpYPos = 0;
			alphaTarget = 0;
		}

		if (y <= -height)
		{
			visible = true;
			active = true;

			#if FLX_SAVE
			// Save sound preferences
			if (FlxG.save.isBound)
			{
				FlxG.save.data.mute = FlxG.sound.muted;
				FlxG.save.data.volume = FlxG.sound.volume;
				FlxG.save.flush();
			}
			#end
		}
	}

	/**
	 * Makes the little volume tray slide out.
	 *
	 * @param	up Whether the volume is increasing.
	 */
	public function show(up:Bool = false):Void
	{
		lerpYPos = 20;
		if (!silent)
		{
			final sound = Paths.sound(up ? volumeUpSound : volumeDownSound);
			if (sound != null)
				FlxG.sound.load(sound).play();
		}

		_timer = 1;
		y = 0;
		visible = true;
		active = true;
		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);

		if (FlxG.sound.muted || FlxG.sound.volume == 0)
			globalVolume = 0;

		for (i in 0..._bars.length)
		{
			if (i < globalVolume)
				_bars[i].visible = true;
			else
				_bars[i].visible = false;
		}
	}

	public function screenCenter():Void
	{
		scaleX = _defaultScale;
		scaleY = _defaultScale;

		x = (0.5 * (Lib.current.stage.stageWidth - _width * _defaultScale) - FlxG.game.x);
	}

	public function coolLerp(base:Float, target:Float, ratio:Float):Float
		return base + cameraLerp(ratio) * (target - base);

	public function cameraLerp(lerp:Float):Float
		return lerp * (FlxG.elapsed / (1 / 60));
}
#end
