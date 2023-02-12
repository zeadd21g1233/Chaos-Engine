package;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import haxe.ds.StringMap;
import ScriptHandler;
import PlayState;

class Stage extends FlxTypedGroup<FlxSprite> {
	var stageBuild:ForeverModule;
	public var foreground:FlxSpriteGroup;

	public var curStage:String;

    public function new(?stage:String = 'stage') {
        super();

		this.curStage = stage;

		foreground = new FlxSpriteGroup();

		var exposure:StringMap<Dynamic> = new StringMap<Dynamic>();
		exposure.set('add', add);
		exposure.set('foreground', foreground);
		exposure.set('stage', this);
        exposure.set('curStage', this.curStage);
		exposure.set('boyfriend', PlayState.boyfriend);
		exposure.set('dad', PlayState.dad);
		exposure.set('dadOpponent', PlayState.dad);
		stageBuild = ScriptHandler.loadModule('stages/$stage/$stage', exposure);
		Paths.setCurrentLevel('assets/stages/$stage');
		if (stageBuild.exists("onCreate"))
			stageBuild.get("onCreate")();
        Paths.revertCurrentLevel();
		trace('$stage loaded successfully');
    }

	public function stageCreatePost() {
		stageBuild.set('add', PlayState.instance.add);
		stageBuild.set('boyfriend', PlayState.boyfriend);
		stageBuild.set('dad', PlayState.dad);
		stageBuild.set('dadOpponent', PlayState.dad);
		if (stageBuild.exists("onCreatePost"))
			stageBuild.get("onCreatePost")();
	}

	public function stageUpdate(curBeat:Int) {
		if (stageBuild.exists("onBeat"))
			stageBuild.get("onBeat")(curBeat);
    }

	public function stageUpdateStep(curStep:Int) {
		if (stageBuild.exists("onStep"))
			stageBuild.get("onStep")(curStep);
    }

	public function dispatchEvent(myEvent:String)
	{
		if (stageBuild.exists("onEvent"))
			stageBuild.get("onEvent")(myEvent);
	}

	public function SongStart() {
		if (stageBuild.exists("onStartSong"))
			stageBuild.get("onStartSong")();
    }

	public function CountStart() {
		if (stageBuild.exists("onStartCountdown"))
			stageBuild.get("onStartCountdown")();
    }
	public function EndSong() {
		if (stageBuild.exists("onSongEnd"))
			stageBuild.get("onSongEnd")();
    }

	public function stageUpdateConstant(elapsed:Float)
	{
		if (stageBuild.exists("onUpdate"))
			stageBuild.get("onUpdate")(elapsed);
	}




	override function add(Object:FlxSprite):FlxSprite
	{
		if (ClientPrefs.globalAntialiasing)
			cast(Object, FlxSprite).antialiasing = false;
		return super.add(Object);
	}
}

