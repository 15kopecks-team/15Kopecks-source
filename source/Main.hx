package;

#if android
import android.content.Context;
#end

import openfl.display.FPS;

import flixel.graphics.FlxGraphic;
import flixel.FlxGame;
import flixel.FlxState;
import haxe.io.Path;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.StageScaleMode;
import lime.app.Application;
import states.InitState;

#if linux
import lime.graphics.Image;
#end

import haxe.Json;
import haxe.format.JsonParser;

//crash handler stuff
#if CRASH_HANDLER
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import haxe.io.Path;
#end

#if mobile
import mobile.backend.StorageUtil;
import mobile.states.CopyState;
#end

#if linux
@:cppInclude('./external/gamemode_client.h')
@:cppFileCode('
	#define GAMEMODE_AUTO
')
#end

typedef SetupFile = {
	// var nameApp:String;
	var gpuCache:Bool;
	var showDevBuild:Bool;
	var showBorderInFPS:Bool;
	var discordKey:String;
	var discordImg:String;
}

class Main extends Sprite
{
	var game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: #if mobile CopyState #else InitState #end, // initial game state
		zoom: #if mobile 1.0 #else -1.0 #end, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	public static var fpsVar:FPS;

	public static var appConfig:SetupFile;

	public static var discordKey:String = "1353829861663182958";
	public static var discordImg:String = "logo";
	public static var gpuCache:Bool = false;
	// You can pretty much ignore everything from here on - your code should go in your states.

	public function getSetupFile()
	{
		appConfig = Json.parse(Assets.getText('content/setup.json'));
			if(appConfig == null) {
				appConfig = {
					// nameApp: "friday night funkin'";
					gpuCache: true,
					showDevBuild: true,
					showBorderInFPS: false,
					discordKey: "1353829861663182958",
					discordImg: "logo"
					} 
			}
		discordImg = appConfig.discordImg;
		discordKey = appConfig.discordKey;
		gpuCache = appConfig.gpuCache;
	}

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		#if mobile
		Sys.setCwd(StorageUtil.getStorageDirectory());
		#end

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		getSetupFile();

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}
	
		#if LUA_ALLOWED Lua.set_callbacks_function(cpp.Callable.fromStaticFunction(psychlua.CallbackHandler.call)); #end
		Controls.instance = new Controls();
		ClientPrefs.loadDefaultKeys();
		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

		fpsVar = new FPS(10, 8, 0xFFFFFF);
		addChild(fpsVar);
		Lib.current.stage.align = "tl";
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		if(fpsVar != null) {
			fpsVar.visible = ClientPrefs.data.showFPS;
		}

		#if linux
		var icon = Image.fromFile("icon.png");
		Lib.current.stage.window.setIcon(icon);
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#elseif mobile
        FlxG.mouse.visible = false;
        #end
		
		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if DISCORD_ALLOWED
		DiscordClient.prepare();
		#end

		// shader coords fix
		FlxG.signals.gameResized.add(function (w, h) {
		     if (FlxG.cameras != null) {
			   for (cam in FlxG.cameras.list) {
				if (cam != null && cam.filters != null)
					resetSpriteCache(cam.flashSprite);
			   }
			}

			if (FlxG.game != null)
			resetSpriteCache(FlxG.game);
		});
	}

	static function resetSpriteCache(sprite:Sprite):Void {
		@:privateAccess {
		        sprite.__cacheBitmap = null;
			sprite.__cacheBitmapData = null;
		}
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	// very cool person for real they don't get enough credit for their work
	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "PsychEngine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the GitHub page: https://github.com/ShadowMario/FNF-PsychEngine\n\n> Crash Handler written by: sqirra-rng";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		#if DISCORD_ALLOWED
		DiscordClient.shutdown();
		#end
		Sys.exit(1);
	}
	#end
}
