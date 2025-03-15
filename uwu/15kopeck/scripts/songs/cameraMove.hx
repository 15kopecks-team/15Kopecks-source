var dad:Bool = false;
var moveCam:Bool = true;

function onCreatePost(){
    if(game.songName == "blaster")
        moveCam = false;
}

function onMoveCamera(focus:String)
{
	if (focus == 'boyfriend')
	{
		dad = false;
	}
	else if (focus == 'dad')
	{
		dad = true;
	}
}

function onUpdate(){
    game.camGame.targetOffset.x = FlxMath.lerp(camGame.targetOffset.x, 0, 0.03);
	game.camGame.targetOffset.y = FlxMath.lerp(camGame.targetOffset.y, 0, 0.03);
}

function opponentNoteHit(note:Note)
{
    if(dad && moveCam)
        stufShit(Std.int(Math.abs(note.noteData)));
}

function goodNoteHit(note:Note){
    if(!dad && moveCam)
        stufShit(Std.int(Math.abs(note.noteData)));
}
function stufShit(noteType:Int) {
    switch(noteType){
        case 3:
            game.camGame.targetOffset.x = powerMove_camera;
            game.camGame.targetOffset.y = 0;
        case 2:
            game.camGame.targetOffset.y = -powerMove_camera;
            game.camGame.targetOffset.x = 0;
        case 1:
            game.camGame.targetOffset.y = powerMove_camera;
            game.camGame.targetOffset.x = 0;
        case 0:
           game.camGame.targetOffset.x = -powerMove_camera;
           game.camGame.targetOffset.y = 0;
    }
}