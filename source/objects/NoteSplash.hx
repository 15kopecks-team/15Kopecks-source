package objects;

import backend.animation.PsychAnimationController;

import flixel.system.FlxAssets.FlxShader;
import flixel.graphics.frames.FlxFrame;

typedef NoteSplashConfig = {
	anim:String,
	minFps:Int,
	maxFps:Int,
	offsets:Array<Array<Float>>
}

class NoteSplash extends FlxSprite
{
	private var idleAnim:String;
	private var _textureLoaded:String = null;
	private var _configLoaded:String = null;

	public static var defaultNoteSplash(default, never):String = 'noteSplashes/noteSplashes';
	public static var configs:Map<String, NoteSplashConfig> = new Map<String, NoteSplashConfig>();

	public function new(x:Float = 0, y:Float = 0) {
		super(x, y);

		animation = new PsychAnimationController(this);

		var skin:String = null;
		if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) skin = PlayState.SONG.splashSkin;
		else skin = defaultNoteSplash + getSplashSkinPostfix();
		
		precacheConfig(skin);
		_configLoaded = skin;
		scrollFactor.set();
		setupNoteSplash(x, y, 0);
	}


	override function destroy()
	{
		configs.clear();
		super.destroy();
	}

	var maxAnims:Int = 2;
	public function setupNoteSplash(x:Float, y:Float, direction:Int = 0, ?note:Note = null) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		aliveTime = 0;

		var texture:String = null;
		if(note != null && note.noteSplashData.texture != null) texture = note.noteSplashData.texture;
		else if(PlayState.SONG.splashSkin != null && PlayState.SONG.splashSkin.length > 0) texture = PlayState.SONG.splashSkin;
		else texture = defaultNoteSplash + getSplashSkinPostfix();
		
		var config:NoteSplashConfig = null;
		if(_textureLoaded != texture)
			config = loadAnims(texture);
		else
			config = precacheConfig(_configLoaded);

		alpha = 0.6;

		if(note != null) antialiasing = note.noteSplashData.antialiasing;
		if(PlayState.isPixelStage || !ClientPrefs.data.antialiasing) antialiasing = false;

		_textureLoaded = texture;
		offset.set(10, 10);

		var animNum:Int = FlxG.random.int(1, maxAnims);
		animation.play('note' + direction + '-' + animNum, true);
		
		var minFps:Int = 22;
		var maxFps:Int = 26;
		if(config != null)
		{
			var animID:Int = direction + ((animNum - 1) * Note.colArray.length);
			//trace('anim: ${animation.curAnim.name}, $animID');
			var offs:Array<Float> = config.offsets[FlxMath.wrap(animID, 0, config.offsets.length-1)];
			offset.x += offs[0];
			offset.y += offs[1];
			minFps = config.minFps;
			maxFps = config.maxFps;
		}
		else
		{
			offset.x += -58;
			offset.y += -55;
		}

		if(animation.curAnim != null)
			animation.curAnim.frameRate = FlxG.random.int(minFps, maxFps);
	}

	public static function getSplashSkinPostfix()
	{
		var skin:String = '';
		if(ClientPrefs.data.splashSkin != ClientPrefs.defaultData.splashSkin)
			skin = '-' + ClientPrefs.data.splashSkin.trim().toLowerCase().replace(' ', '_');
		return skin;
	}

	function loadAnims(skin:String, ?animName:String = null):NoteSplashConfig {
		maxAnims = 0;
		frames = Paths.getSparrowAtlas(skin);
		var config:NoteSplashConfig = null;
		if(frames == null)
		{
			skin = defaultNoteSplash + getSplashSkinPostfix();
			frames = Paths.getSparrowAtlas(skin);
			if(frames == null) //if you really need this, you really fucked something up
			{
				skin = defaultNoteSplash;
				frames = Paths.getSparrowAtlas(skin);
			}
		}
		config = precacheConfig(skin);
		_configLoaded = skin;

		if(animName == null)
			animName = config != null ? config.anim : 'note splash';

		while(true) {
			var animID:Int = maxAnims + 1;
			for (i in 0...Note.colArray.length) {
				if (!addAnimAndCheck('note$i-$animID', '$animName ${Note.colArray[i]} $animID', 24, false)) {
					//trace('maxAnims: $maxAnims');
					return config;
				}
			}
			maxAnims++;
			//trace('currently: $maxAnims');
		}
	}

	public static function precacheConfig(skin:String)
	{
		if(configs.exists(skin)) return configs.get(skin);

		var path:String = Paths.getPath('images/$skin.txt', TEXT, true);
		var configFile:Array<String> = CoolUtil.coolTextFile(path);
		if(configFile.length < 1) return null;
		
		var framerates:Array<String> = configFile[1].split(' ');
		var offs:Array<Array<Float>> = [];
		for (i in 2...configFile.length)
		{
			var animOffs:Array<String> = configFile[i].split(' ');
			offs.push([Std.parseFloat(animOffs[0]), Std.parseFloat(animOffs[1])]);
		}

		var config:NoteSplashConfig = {
			anim: configFile[0],
			minFps: Std.parseInt(framerates[0]),
			maxFps: Std.parseInt(framerates[1]),
			offsets: offs
		};
		configs.set(skin, config);
		return config;
	}

	function addAnimAndCheck(name:String, anim:String, ?framerate:Int = 24, ?loop:Bool = false)
	{
		var animFrames = [];
		@:privateAccess
		animation.findByPrefix(animFrames, anim); // adds valid frames to animFrames

		if(animFrames.length < 1) return false;
	
		animation.addByPrefix(name, anim, framerate, loop);
		return true;
	}

	static var aliveTime:Float = 0;
	static var buggedKillTime:Float = 0.5; //automatically kills note splashes if they break to prevent it from flooding your HUD
	override function update(elapsed:Float) {
		aliveTime += elapsed;
		if((animation.curAnim != null && animation.curAnim.finished) ||
			(animation.curAnim == null && aliveTime >= buggedKillTime)) kill();

		super.update(elapsed);
	}
}