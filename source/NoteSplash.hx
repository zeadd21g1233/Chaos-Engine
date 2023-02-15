package;

import flixel.FlxG;
import flixel.FlxSprite;
import haxe.io.Path;
import haxe.ds.StringMap;
import openfl.utils.Assets as OpenFlAssets;
import script.ScriptHandler.ForeverModule;
import script.ScriptHandler;

class NoteSplash extends FlxSprite
{
        public static var IsPixelSplash:Bool = false;



	public function new(x:Float, y:Float, noteData:Int = 0):Void
	{
		super(x, y);

                if (!IsPixelSplash){
		frames = Paths.getSparrowAtlas('NoteSprites/Note/Default/noteSplashes');
		animation.addByPrefix('note1-0', 'note impact 1  blue', 24, false);
		animation.addByPrefix('note2-0', 'note impact 1 green', 24, false);
		animation.addByPrefix('note0-0', 'note impact 1 purple', 24, false);
		animation.addByPrefix('note3-0', 'note impact 1 red', 24, false);
		animation.addByPrefix('note1-1', 'note impact 2 blue', 24, false);
		animation.addByPrefix('note2-1', 'note impact 2 green', 24, false);
		animation.addByPrefix('note0-1', 'note impact 2 purple', 24, false);
		animation.addByPrefix('note3-1', 'note impact 2 red', 24, false);     
                }      

                if (IsPixelSplash){
                frames = Paths.getSparrowAtlas('NoteSprites/Note/pixel/pxSplash');		
                animation.addByPrefix('note1-0', 'note impact 1 blue', 24, false);
                animation.addByPrefix('note2-0', 'note impact 1 green', 24, false);
                animation.addByPrefix('note0-0', 'note impact 1 purple m', 24, false);
                animation.addByPrefix('note3-0', 'note impact 1 red', 24, false);
                animation.addByPrefix('note1-1', 'note impact 2 blue', 24, false);
	        animation.addByPrefix('note2-1', 'note impact 2 green', 24, false);
	        animation.addByPrefix('note0-1', 'note impact 2 purple', 24, false);
	        animation.addByPrefix('note3-1', 'note impact 2 red', 24, false);
                scale.set(3, 3);
                antialiasing = false;
                }


                setupNoteSplash(x, y, noteData);
	}

	public function setupNoteSplash(x:Float, y:Float, noteData:Int = 0)
	{
		setPosition(x, y);
		alpha = 0.6;

		animation.play('note' + noteData + '-' + FlxG.random.int(0, 1), true);
		animation.curAnim.frameRate += FlxG.random.int(-2, 2);
		updateHitbox();

                if (IsPixelSplash)
                    offset.set(width * 0, height * 0);

                if (!IsPixelSplash)
                offset.set(width * 0.3, height * 0.3);
		
	}

	override function update(elapsed:Float)
	{
		if (animation.curAnim.finished)
			kill();

		super.update(elapsed);
	}
}