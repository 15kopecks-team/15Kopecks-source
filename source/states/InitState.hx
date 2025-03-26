package states;

import backend.cppApi.CppApi;
import backend.Highscore;

import flixel.input.keyboard.FlxKey;

import openfl.filters.ShaderFilter;

class InitState extends MusicBeatState
{
    public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

    public static var menuMusic:String = 'menu';
    public static var pauseMusic:String = 'pause';
    public static var bpm:Int = 100;

    var shader:Dynamic;

    override function create() {
        #if android
        FlxG.android.preventDefaultKeys = [BACK];
        #end

        #if !mobile
        CppAPI.darkMode();
        #end

        #if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

        FlxG.save.bind('funkin', CoolUtil.getSavePath());

		ClientPrefs.loadPrefs();

        Highscore.load();

        super.create();

        initLuaShader("mobile");
        shader = createRuntimeShader("mobile");
        FlxG.game.setFilters([new ShaderFilter(shader)]);
        
        MusicBeatState.switchState(new KopeckMenu());
    }
}