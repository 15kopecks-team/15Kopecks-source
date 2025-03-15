package states.fr;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxSprite;
import backend.MouseController;

class FreeplayState extends MusicBeatState
{
	private var _bg:FlxSprite;
	private var _items:FlxSprite;

	private var _targets:Map<FlxObject, String>;
	private var _mouseController:MouseController;

	private var _cameraFollow:FlxObject;

	override function create()
	{
		_bg = new FlxSprite(Paths.image("menus/fr/15"));
		_bg.screenCenter();
		_bg.antialiasing = ClientPrefs.data.antialiasing;
		add(_bg);

		_items = new FlxSprite(Paths.image("menus/fr/97db44eba27d9395"));
		_items.setPosition(_bg.x, _bg.y);
		_items.antialiasing = ClientPrefs.data.antialiasing;
		add(_items);

		_targets = [
			new FlxObject(880, 154, 241, 46) => 'tuberculosis',
			new FlxObject(803, 634, 94, 185) => 'kvartira-42',
			new FlxObject(1169, 525, 174, 127) => 'daemae',
			new FlxObject(1499, 559, 347, 305) => 'st4r-fever',
			new FlxObject(1276, 834, 172, 173) => 'bing-chillin',
			new FlxObject(481, 275, 132, 162) => 'pig-ful',
			new FlxObject(1035, 807, 99, 134) => 'beer-n-cider',
		];

		for (target in _targets.keys())
		{
			target.x += _items.x;
			target.y += _items.y;
		}

		_mouseController = new MouseController([for (target in _targets.keys()) target]);
		add(_mouseController);

		_mouseController.targetClicked.add(onTargetClicked);

		_cameraFollow = new FlxObject(FlxG.width / 2, FlxG.height / 2);
		FlxG.camera.follow(_cameraFollow, .16);
		FlxG.camera.zoom = 0.85;

		super.create();
	}

	private function onTargetClicked(target:FlxObject)
	{
		final song = _targets.get(target);
		if (song == null)
		{
			return;
		}

		trace('selected song $song');
	}

	override function update(elapsed:Float)
	{
		_cameraFollow.x = (FlxG.width / 2.5 + FlxG.mouse.gameX / (_bg.width / FlxG.width * 2)) * FlxG.camera.zoom;
		_cameraFollow.y = (FlxG.height / 2.5 + FlxG.mouse.gameY / (_bg.height / FlxG.height * 2)) * FlxG.camera.zoom;

		super.update(elapsed);
	}
}
