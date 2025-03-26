package mobile.objects;

import openfl.display.BitmapData;
import openfl.display.Shape;
import flixel.graphics.FlxGraphic;
import openfl.geom.Matrix;
import flixel.util.FlxDestroyUtil;

/**
 * A zone with 4 hint's (A hitbox).
 * It's really easy to customize the layout.
 *
 * @author: Mihai Alexandru and Karim Akra
 */
class Hitbox extends MobileInputManager implements IMobileControls
{
	final offsetFir:Int = 0;
	final offsetSec:Int = Std.int(FlxG.height / 4);

	public var buttonLeft:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_LEFT, MobileInputID.NOTE_LEFT]);
	public var buttonDown:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_DOWN, MobileInputID.NOTE_DOWN]);
	public var buttonUp:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_UP, MobileInputID.NOTE_UP]);
	public var buttonRight:TouchButton = new TouchButton(0, 0, [MobileInputID.HITBOX_RIGHT, MobileInputID.NOTE_RIGHT]);

	public var instance:MobileInputManager;

	var storedButtonsIDs:Map<String, Array<MobileInputID>> = new Map<String, Array<MobileInputID>>();

	/**
	 * Create the zone.
	 */
	public function new()
	{
		super();

		for (button in Reflect.fields(this))
		{
			var field = Reflect.field(this, button);
			if (Std.isOfType(field, TouchButton))
				storedButtonsIDs.set(button, Reflect.getProperty(field, 'IDs'));
		}

		add(buttonLeft = createHint(0, 0, Std.int(FlxG.width / 4), FlxG.height, 0xFFC24B99));
		add(buttonDown = createHint(FlxG.width / 4, 0, Std.int(FlxG.width / 4), FlxG.height, 0xFF00FFFF));
		add(buttonUp = createHint(FlxG.width / 2, 0, Std.int(FlxG.width / 4), FlxG.height, 0xFF12FA05));
		add(buttonRight = createHint((FlxG.width / 2) + (FlxG.width / 4), 0, Std.int(FlxG.width / 4), FlxG.height, 0xFFF9393F));

		for (button in Reflect.fields(this))
		{
			if (Std.isOfType(Reflect.field(this, button), TouchButton))
				Reflect.setProperty(Reflect.getProperty(this, button), 'IDs', storedButtonsIDs.get(button));
		}

		storedButtonsIDs.clear();
		scrollFactor.set();
		updateTrackedButtons();

		instance = this;
	}

	/**
	 * Clean up memory.
	 */
	override function destroy()
	{
		super.destroy();

		for (fieldName in Reflect.fields(this))
		{
			var field = Reflect.field(this, fieldName);
			if (Std.isOfType(field, TouchButton))
				Reflect.setField(this, fieldName, FlxDestroyUtil.destroy(field));
		}
	}

	private function createHint(X:Float, Y:Float, Width:Int, Height:Int, Color:Int = 0xFFFFFF):TouchButton
	{
		var hint = new TouchButton(X, Y);
		hint.statusAlphas = [];
		hint.statusIndicatorType = NONE;
		hint.loadGraphic(createHintGraphic(Width, Height));

		var hintTween:FlxTween = null;

		hint.onDown.callback = function()
		{
			if (hintTween != null)
				hintTween.cancel();

			hintTween = FlxTween.tween(hint, {alpha: ClientPrefs.data.hitboxAlpha}, 1 / 100, {
				ease: FlxEase.circInOut,
				onComplete: (twn:FlxTween) -> hintTween = null
			});
		}

		hint.onOut.callback = hint.onUp.callback = function()
		{
			if (hintTween != null)
				hintTween.cancel();

			hintTween = FlxTween.tween(hint, {alpha: 0.00001}, 1 / 10, {
				ease: FlxEase.circInOut,
				onComplete: (twn:FlxTween) -> hintTween = null
			});
		}

		hint.immovable = hint.multiTouch = true;
		hint.solid = hint.moves = false;
		hint.alpha = 0.00001;
		hint.antialiasing = ClientPrefs.data.antialiasing;
		hint.color = Color;
		#if FLX_DEBUG
		hint.ignoreDrawDebug = true;
		#end
		return hint;
	}

	function createHintGraphic(Width:Int, Height:Int, ?isLane:Bool = false):FlxGraphic
	{
		var shape:Shape = new Shape();
		shape.graphics.beginFill(0xFFFFFF);
		shape.graphics.lineStyle(3, 0xFFFFFF, 1);
		shape.graphics.drawRect(0, 0, Width, Height);
		shape.graphics.lineStyle(0, 0, 0);
		shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
		shape.graphics.endFill();
		if (isLane)
			shape.graphics.beginFill(0xFFFFFF);
		else
			shape.graphics.beginGradientFill(RADIAL, [0xFFFFFF, FlxColor.TRANSPARENT], [1, 0], [0, 255], null, null, null, 0.5);
		shape.graphics.drawRect(3, 3, Width - 6, Height - 6);
		shape.graphics.endFill();

		var bitmap:BitmapData = new BitmapData(Width, Height, true, 0);
		bitmap.draw(shape);

		return FlxG.bitmap.add(bitmap);
	}
}