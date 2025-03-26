package substates;

import backend.WeekData;

import objects.Character;
import flixel.FlxObject;
import flixel.FlxSubState;

import states.songSelect.KopeckSongSelect;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Character;
	var camFollow:FlxObject;
	var moveCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	var gunCockSound:FlxSound;
	var pigfulConfirmMusic:FlxSound;

	public static var instance:GameOverSubstate;

	public static function resetVariables() {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';

		var _song = PlayState.SONG;
		if(_song != null)
		{
			if(_song.gameOverChar != null && _song.gameOverChar.trim().length > 0) characterName = _song.gameOverChar;
			if(_song.gameOverSound != null && _song.gameOverSound.trim().length > 0) deathSoundName = _song.gameOverSound;
			if(_song.gameOverLoop != null && _song.gameOverLoop.trim().length > 0) loopSoundName = _song.gameOverLoop;
			if(_song.gameOverEnd != null && _song.gameOverEnd.trim().length > 0) endSoundName = _song.gameOverEnd;
		}
	}

	var charX:Float = 0;
	var charY:Float = 0;
	override function create()
	{
		instance = this;

		Conductor.songPosition = 0;

		boyfriend = new Character(PlayState.instance.boyfriend.getScreenPosition().x, PlayState.instance.boyfriend.getScreenPosition().y, characterName, true);
		boyfriend.x += boyfriend.positionArray[0] - PlayState.instance.boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1] - PlayState.instance.boyfriend.positionArray[1];
		add(boyfriend);

		switch (characterName)
		{
			case "vitya-gameover":
				new FlxTimer().start(1.5, function(tmr:FlxTimer) FlxG.sound.play(Paths.sound(deathSoundName)));
			case "pico-gayOver":
				new FlxTimer().start(0.5, function(tmr:FlxTimer) FlxG.sound.play(Paths.sound(deathSoundName)));
			default:
				FlxG.sound.play(Paths.sound(deathSoundName));
		}

		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		boyfriend.playAnim('firstDeath');

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollow.setPosition(boyfriend.getGraphicMidpoint().x + boyfriend.cameraPosition[0], boyfriend.getGraphicMidpoint().y + boyfriend.cameraPosition[1]);
		FlxG.camera.focusOn(new FlxPoint(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2)));
		add(camFollow);
		
		PlayState.instance.setOnScripts('inGameOver', true);
		PlayState.instance.callOnScripts('onGameOverStart', []);

		super.create();
	}

	public var startedDeath:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnScripts('onUpdate', [elapsed]);

		if (controls.ACCEPT #if mobile || (TouchUtil.overlaps(boyfriend) && TouchUtil.justPressed) #end)
		{
			endBullshit();
		}

		if (controls.BACK #if android || FlxG.android.justReleased.BACK #end)
		{
			#if DISCORD_ALLOWED DiscordClient.resetClientID(); #end
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			MusicBeatState.switchState(new KopeckSongSelect());

			FlxG.sound.playMusic(Paths.music(states.InitState.menuMusic));
			PlayState.instance.callOnScripts('onGameOverConfirm', [false]);
		}
		
		if (boyfriend.animation.curAnim != null)
		{
			if (boyfriend.animation.curAnim.name == 'firstDeath' && boyfriend.animation.curAnim.finished && startedDeath)
				boyfriend.playAnim('deathLoop');

			if(boyfriend.animation.curAnim.name == 'firstDeath')
			{
				if(boyfriend.animation.curAnim.curFrame >= 12 && !moveCamera)
				{
					FlxG.camera.follow(camFollow, LOCKON, 0.6);
					moveCamera = true;
				}

				if (boyfriend.animation.curAnim.finished && !playingDeathSound)
				{
					startedDeath = true;
					coolStartDeath();
				}
			}
		}
		
		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnScripts('onUpdatePost', [elapsed]);
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
		if (characterName == "pico-gayOver") 
		{
			gunCockSound = new FlxSound();
			gunCockSound.loadEmbedded(Paths.music("deathPICO/gunloop"), true);
			gunCockSound.play();
		}
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;

			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			if (characterName == "pico-gayOver") gunCockSound.stop();

			switch (characterName)
			{
				case "HUNTER_GameOver":
					new FlxTimer().start(0.7, function(tmr:FlxTimer) bullshit());

					pigfulConfirmMusic = new FlxSound();
					pigfulConfirmMusic.loadEmbedded(Paths.music("deathHunter/confirmmusic"), false);
					pigfulConfirmMusic.play();
				default:
					bullshit();
			}
		}
	}

	function bullshit():Void
	{
		boyfriend.playAnim('deathConfirm', true);
		new FlxTimer().start(0.7, function(tmr:FlxTimer)
		{
			FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
			{
				MusicBeatState.resetState();
			});
		});
		PlayState.instance.callOnScripts('onGameOverConfirm', [true]);
	}

	override function destroy()
	{
		instance = null;
		super.destroy();
	}
}
