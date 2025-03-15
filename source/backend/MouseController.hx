package backend;

import flixel.util.FlxSignal.FlxTypedSignal;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxBasic;

class MouseController extends FlxBasic
{
	public var targets:Array<FlxObject>;

	public var targetClicked:FlxTypedSignal<(FlxObject) -> Void>;

	private var _waitingTarget:FlxObject;

	public function new(targets:Array<FlxObject>)
	{
		super();
		this.targets = targets;

		targetClicked = new FlxTypedSignal<(FlxObject) -> Void>();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed)
		{
			for (target in targets)
			{
				if (FlxG.mouse.overlaps(target))
				{
					_waitingTarget = target;
				}
			}
		}

		if (FlxG.mouse.justReleased && _waitingTarget != null)
		{
			if (FlxG.mouse.overlaps(_waitingTarget))
			{
				targetClicked.dispatch(_waitingTarget);
			}
			_waitingTarget = null;
		}

		super.update(elapsed);
	}

	override function destroy()
	{
		targets = null;

		targetClicked.destroy();
		targetClicked = null;

		_waitingTarget = null;

		super.destroy();
	}
}
