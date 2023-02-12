package script;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.tile.FlxGraphicsShader;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import Boyfriend;
import Character;
import HealthIcon;
import Note;
import haxe.ds.StringMap;
import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import script.RealColor;
import PlayState;
import openfl.display.GraphicsShader;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import openfl.utils.Assets;
import flixel.text.FlxText;
import Section;



using StringTools;

/**
 * Handles the Backend and Script interfaces of Forever Engine, as well as exceptions and crashes.
 */
class ScriptHandler
{
	/**
	 * Shorthand for exposure, specifically public exposure. 
	 * All scripts will be able to access these variables globally.
	 */
	public static var exp:StringMap<Dynamic>;

	public static var parser:Parser = new Parser();

	/**
	 * [Initializes the basis of the Scripting system]
	 */
	public static function initialize()
	{
		exp = new StringMap<Dynamic>();

		// Classes (Haxe)
		exp.set("Sys", Sys);
		exp.set("Std", Std);
		exp.set("Math", Math);
		exp.set("StringTools", StringTools);
               

		// Classes (Flixel)
		exp.set("FlxG", FlxG);
		exp.set("FlxSprite", FlxSprite);
		exp.set("FlxMath", FlxMath);
		exp.set("FlxPoint", FlxPoint);
		exp.set("FlxRect", FlxRect);
		exp.set("FlxTween", FlxTween);
                exp.set("FlxText", FlxText);
		exp.set("FlxTimer", FlxTimer);
		exp.set("FlxEase", FlxEase);
		exp.set("Shader", Shader);
		exp.set("ShaderFilter", ShaderFilter);
		exp.set("GraphicsShader", GraphicsShader);
		exp.set("FlxGraphicsShader", FlxGraphicsShader);
		exp.set("FlxColor", RealColor); // lol
		exp.set("FlxGroup", FlxGroup);

		// Classes (Chaos Engine)
                exp.set("Section", Section);
		exp.set("ChaosEngineData", ChaosEngineData);
		exp.set("Paths", Paths);
		exp.set("Note", Note);
		exp.set("Conductor", Conductor);
		exp.set("Character", Character);
		exp.set("Boyfriend", Boyfriend);
		exp.set("HealthIcon", HealthIcon);
		exp.set("PlayState", PlayState);


		//
		parser.allowTypes = true;
	}

	public static function loadModule(path:String, ?extraParams:StringMap<Dynamic>)
	{
		// trace('Loading Module $path');
		var modulePath:String = Paths.module(path);
		return new ForeverModule(parser.parseString(Assets.getText(modulePath), modulePath), extraParams);
	}
}

/**
 * The basic module class, for handling externalized scripts individually
 */
class ForeverModule
{
	public var interp:Interp;
	public var assetGroup:String;

	public var alive:Bool = true;

	public function new(?contents:Expr, ?extraParams:StringMap<Dynamic>)
	{
		interp = new Interp();
		// Variable functionality
		for (i in ScriptHandler.exp.keys())
			interp.variables.set(i, ScriptHandler.exp.get(i));
		// Local Variable functionality
		if (extraParams != null)
		{
			for (i in extraParams.keys())
				interp.variables.set(i, extraParams.get(i));
		}
		interp.variables.set('dispose', dispose);
		interp.execute(contents);
	}

	public function dispose():Dynamic
		return this.alive = false;

	/**
		* [Returns a field from the module]
			 * @param field 
			 * @return Dynamic
		return interp.variables.get(field)
	 */
	public function get(field:String):Dynamic
		return interp.variables.get(field);

	/**
	 * [Sets a field within the module to a new value]
	 * @param field 
	 * @param value 
	 * @return interp.variables.set(field, value)
	 */
	public function set(field:String, value:Dynamic)
		interp.variables.set(field, value);

	/**
		* [Checks the existence of a value or exposure within the module]
		* @param field 
		* @return Bool
				return interp.variables.exists(field)
	 */
	public function exists(field:String):Bool
		return interp.variables.exists(field);
}