package funkin.menus;

import funkin.savedata.FunkinSave;
import haxe.io.Path;
import funkin.backend.scripting.ScriptPack;
import funkin.backend.scripting.events.*;
import funkin.backend.scripting.Script;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import funkin.backend.FunkinText;
import haxe.xml.Access;
import flixel.text.FlxText;

class StoryMenuState extends MusicBeatState {
	public var characters:Map<String, MenuCharacter> = [];
	public var weeks:Array<WeekData> = [];

	public static var script:String = "data/scripts/StoryMenuScreen";
	public var scoreText:FlxText;
	public var tracklist:FlxText;
	public var weekTitle:FlxText;

	public var curDifficulty:Int = 0;
	public var curWeek:Int = 0;

	public var difficultySprites:Map<String, FlxSprite> = [];
	public var weekBG:FlxSprite;
	public var qqqenScript:Script;
	public var leftArrow:FlxSprite;
	public var rightArrow:FlxSprite;
	public var blackBar:FlxSprite;

	public var lerpScore:Float = 0;
	public var intendedScore:Int = 0;

	public var canSelect:Bool = true;

	public var weekSprites:FlxTypedGroup<MenuItem>;
	public var characterSprites:FlxTypedGroup<MenuCharacterSprite>;

	//public var charFrames:Map<String, FlxFramesCollection> = [];

	public override function create() {
		super.create();
		qqqenScript = Script.create(Paths.script(script));
		qqqenScript.setParent(this);
		qqqenScript.load();
		add(qqqenScript);

		DiscordUtil.changePresence("In the Menus", null);
		CoolUtil.playMenuSong();
	    qqqenScript.call("create");
	}

	var __lastDifficultyTween:FlxTween;
	public override function update(elapsed:Float) {
		super.update(elapsed);

	    qqqenScript.call("update", [elapsed]);
	}

	public override function destroy() {
		super.destroy();
	    qqqenScript.call("destroy");
		qqqenScript.destroy();
	}
}

typedef WeekData = {
	var name:String;
	var id:String;
	var sprite:String;
	var chars:Array<String>;
	var songs:Array<WeekSong>;
	var difficulties:Array<String>;
}

typedef WeekSong = {
	var name:String;
	var hide:Bool;
}

typedef MenuCharacter = {
	var spritePath:String;
	var xml:Access;
	var scale:Float;
	var offset:FlxPoint;
	// var frames:FlxFramesCollection;
}

class MenuCharacterSprite extends FlxSprite
{
	public var character:String;

	var pos:Int;

	public function new(pos:Int) {
		super(0, 70);
		this.pos = pos;
		visible = false;
		antialiasing = true;
	}

	public var oldChar:MenuCharacter = null;

	public function changeCharacter(data:MenuCharacter) {
		visible = (data != null);
		if (!visible)
			return;

		if (oldChar != (oldChar = data)) {
			CoolUtil.loadAnimatedGraphic(this, data.spritePath);
			for(e in data.xml.nodes.anim) {
				if (e.getAtt("name") == "idle")
					animation.remove("idle");

				XMLUtil.addXMLAnimation(this, e);
			}
			animation.play("idle");
			scale.set(data.scale, data.scale);
			updateHitbox();
			offset.x += data.offset.x;
			offset.y += data.offset.y;

			x = (FlxG.width * 0.25) * (1 + pos) - 150;
		}
	}
}
class MenuItem extends FlxSprite
{
	public var targetY:Float = 0;

	public function new(x:Float, y:Float, path:String)
	{
		super(x, y);
		CoolUtil.loadAnimatedGraphic(this, Paths.image(path, null, true));
		screenCenter(X);
		antialiasing = true;
	}

	private var isFlashing:Bool = false;

	public function startFlashing():Void
	{
		isFlashing = true;
	}

	// if it runs at 60fps, fake framerate will be 6
	// if it runs at 144 fps, fake framerate will be like 14, and will update the graphic every 0.016666 * 3 seconds still???
	// so it runs basically every so many seconds, not dependant on framerate??
	// I'm still learning how math works thanks whoever is reading this lol
	// var fakeFramerate:Int = Math.round((1 / FlxG.elapsed) / 10);

	// hi ninja muffin
	// i have found a more efficient way
	// dw, judging by how week 7 looked you prob know how to do maths
	// goodbye
	var time:Float = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		time += elapsed;
		y = CoolUtil.fpsLerp(y, (targetY * 120) + 480, 0.17);

		if (isFlashing)
			color = (time % 0.1 > 0.05) ? FlxColor.WHITE : 0xFF33ffff;
	}
}
