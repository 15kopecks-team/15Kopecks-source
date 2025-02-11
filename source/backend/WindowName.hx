package backend;

import lime.app.Application;

class WindowName {
    

    public static function setName(n:String) {
        Application.current.window.title += " - " + n;
    }

    public static function reset() {
        Application.current.window.title = FlxG.stage.application.meta.get("name");
    }
}