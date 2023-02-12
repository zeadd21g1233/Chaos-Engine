package script;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import haxe.ds.StringMap;
import script.ScriptHandler;
import PlayState;
import MusicBeatState;


class HxModchart extends FlxTypedGroup<FlxSprite> {
	public static var HScriptsModchart:ForeverModule;
        public function new() {
        //No Use Lol
        super();     
		
        }
        //Functions for Script
	public function ScriptCreatePost() {
		HScriptsModchart.set('add', PlayState.instance.add);
		HScriptsModchart.set('boyfriend', PlayState.boyfriend);
		HScriptsModchart.set('dad', PlayState.dad);
		HScriptsModchart.set('dadOpponent', PlayState.dad);
		if (HScriptsModchart.exists("onCreatePost"))
			HScriptsModchart.get("onCreatePost")();
	}

	public function ScriptBeat(curBeat:Int) {
		if (HScriptsModchart.exists("onBeat"))
			HScriptsModchart.get("onBeat")(curBeat);
    }

	public function ScriptUpdateStep(curStep:Int) {
		if (HScriptsModchart.exists("onStep"))
			HScriptsModchart.get("onStep")(curStep);
    }

	public function ScriptSongStart() {
		if (HScriptsModchart.exists("onStartSong"))
			HScriptsModchart.get("onStartSong")();
    }

	public function ScriptCountStart() {
		if (HScriptsModchart.exists("onStartCountdown"))
			HScriptsModchart.get("onStartCountdown")();
    }
	public function ScriptEndSong() {
		if (HScriptsModchart.exists("onSongEnd"))
			HScriptsModchart.get("onSongEnd")();
    }

	public function ScriptUpdateConstant(elapsed:Float)
	{
		if (HScriptsModchart.exists("onUpdate"))
			HScriptsModchart.get("onUpdate")(elapsed);
	}
	public function ScriptopponentNoteHit(daNote:Note)
	{
		if (HScriptsModchart.exists("opponentNoteHit"))
			HScriptsModchart.get("opponentNoteHit")(daNote);
	}
}

