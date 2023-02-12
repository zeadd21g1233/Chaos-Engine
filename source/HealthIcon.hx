package;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import lime.utils.Assets;

using StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

         public var char:String = 'bf';
	public var isPlayer:Bool = false;
	public var isOldIcon:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		this.char = char;
		this.isPlayer = isPlayer;
		isPlayer = isOldIcon = false;

		changeIcon(char);
		scrollFactor.set();
	}

	public function swapOldIcon()
	{
		(isOldIcon = !isOldIcon) ? changeIcon("bf-old") : changeIcon(char);
	}


	public final function changeIcon(char:String)
	{
		char = char.split("-")[0];

                switch(char)
                {

                case 'bf-pixel': // For Some Reason The Sprite Cant Load

		loadGraphic(Paths.image('icons/face'), true, 150, 150);
		animation.add(char, [0, 1], 0, false, isPlayer);
		animation.play(char);
                antialiasing = false;

                default:
 

		loadGraphic(Paths.image('icons/face'), true, 150, 150);

		if (Paths.exists(Paths.image('icons/' + char)))
			loadGraphic(Paths.image('icons/' + char), true, 150, 150);
		else if (Paths.image('icons/' + char) != null && Paths.image('icons/' + char) is FlxGraphic)
			loadGraphic(Paths.image('icons/' + char), true, 150, 150);

		animation.add(char, [0, 1], 0, false, isPlayer);
		animation.play(char);

                }



		if (char.endsWith('-pixel') || char.startsWith('senpai') || char.startsWith('spirit'))
			antialiasing = false;
		else
			antialiasing = true;


	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y + (sprTracker.height / 2) - (height / 2));
	}
}
