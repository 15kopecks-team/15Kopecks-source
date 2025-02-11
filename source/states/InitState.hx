package states;

import backend.cppApi.CppApi;
import states.TitleState;

class InitState extends MusicBeatState
{
    override function create() {
        CppAPI.darkMode();
        MusicBeatState.switchState(new TitleState());

        super.create();
    }
    
}