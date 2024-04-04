import flixel.FlxObject;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormat;
import flixel.text.FlxTextFormatMarkerPair;
import funkin.backend.utils.DiscordUtil;
import funkin.backend.system.framerate.Framerate;
import std.Xml;

var curSelected:Int = 0;
var iconGroup:FlxTypedGroup<FlxSprite>;

var descText:FlxText;
var descText2:FlxText;
var descTextName:FlxText;

var credits:Array<{name:String,role:String,description:String,social_link:String}> = [];

var camFollow:FlxObject;
var camFollowPos:FlxObject;
var camFollowXOffset:Float;

var iconYArray:Array<Float> = []; //intro stuff

function create() 
{
	Framerate.instance.visible = false;
	DiscordUtil.changePresence('Scrolling Through Menus...', "Credits");


	var data:Xml = Xml.parse(Assets.getText(Paths.file("data/config/credits.xml"))).firstElement();
    for (member_data in data.elementsNamed("member")) {
        credits.push({
            name: member_data.get("name"),
            role: member_data.get("rol_" + (FlxG.save.data.spanish ? "es" : "en")),
            description: member_data.get("desc_" + (FlxG.save.data.spanish ? "es" : "en")),
            social_link: member_data.get("social_link"),
        });
    }


	var background:FlxSprite = new FlxSprite();
	background.loadGraphic(Paths.image("menus/credits/BG_0"));
	background.setGraphicSize(FlxG.width, FlxG.height);
	background.updateHitbox();
	background.scrollFactor.set();
	add(background);

	camFollow = new FlxObject(640, 342, 1, 1);
	camFollowPos = new FlxObject(640, 342, 1, 1);
	add(camFollow);
	add(camFollowPos);

	iconGroup = new FlxTypedGroup();
	add(iconGroup);

	for (i in 0...credits.length)
	{
		var icon:FlxSprite = new FlxSprite(i % 3 * 370 + 100, Std.int(i / 3) * 420);
		icon.loadGraphic(Paths.image((moustacheMode ? 'menus/credits/moustache/' : 'menus/credits/') + credits[i].name));
		icon.setGraphicSize(332);
		icon.ID = i; icon.antialiasing = true;
		icon.alpha = 0.5;
		icon.updateHitbox();
		iconGroup.add(icon);
		iconYArray.push(icon.y);

		icon.y += 300;
	}

	FlxG.camera.follow(camFollowPos, null, 2);

	descText = new FlxText(32, 10, FlxG.width, "", 19, true);
	descText.setFormat("fonts/Harbinger_Caps.otf", 30, FlxColor.WHITE, "center");
	descText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 6, 100);
	descText.scrollFactor.set();
	add(descText);

	descTextName = new FlxText(32, 620, FlxG.width, "", 19, true);
	descTextName.setFormat("fonts/Harbinger_Caps.otf", 50, FlxColor.WHITE, "center");
	descTextName.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 5, 50);
	descTextName.scrollFactor.set();
	add(descTextName);

	descText2 = new FlxText(32, descTextName.y + 50, FlxG.width, "", 19, true);
	descText2.scrollFactor.set();
	add(descText2);

	var vigentte:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menus/black_vignette"));
	vigentte.alpha = 0.4; vigentte.scrollFactor.set(0,0);
	add(vigentte);

	for (i in 0...iconGroup.length){
		FlxTween.tween(iconGroup.members[i], {y: iconYArray[i]}, 0.7,{ease: FlxEase.cubeOut, startDelay: 0.04 * i, onComplete: (tmr:FlxTween) -> {
			intro = false;
		}});
	}
	changeSelection(0);
}

var quitting:Bool = false;
var intro:Bool = true;

function update(elapsed:Float) {
	var lerpVal:Float = Math.max(0, Math.min(1, elapsed * 7.5));
	camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x+camFollowXOffset, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

	if (!quitting) {
		if (controls.LEFT_P)
			changeSelection(-1);
		if (controls.RIGHT_P)
			changeSelection(1);
		if (controls.UP_P)
			changeSelection(-3);
		if (controls.DOWN_P)
			changeSelection(3);

		if (controls.ACCEPT)
			CoolUtil.openURL(credits[curSelected].social_link);

		if (controls.BACK) {
			var sound:FlxSound = new FlxSound().loadEmbedded(Paths.sound("menu/cancelMenu")); sound.volume = 1; sound.play();
			FlxG.switchState(new MainMenuState());
		}
	}
}

function changeSelection(change:Int)
{
	FlxG.sound.play(Paths.sound("menu/scrollMenu"));

	iconGroup.members[curSelected].alpha = 0.5;

	curSelected = FlxMath.wrap(curSelected + change, 0, credits.length-1);

	iconGroup.members[curSelected].alpha = 1;
	camFollow.setPosition(640, Std.int(curSelected / 3) * 420 + 230);
	if(!intro)
	{
		iconGroup.members[curSelected].y = iconYArray[curSelected] + 20;
		FlxTween.tween(iconGroup.members[curSelected],{y: iconYArray[curSelected]},0.3, {ease: FlxEase.backOut});
	}

	var member = credits[curSelected];

	camFollowXOffset = member.name == "Ne_Eo" ? 35 : 0;

	descText.text = member.role;
	descText2.text = member.description;
	if(descText2.text.length > 55){
		descText2.setFormat("fonts/Harbinger_Caps.otf", 20, 0xF2C0AC, "center");
		descText2.y = descTextName.y + 55;
	}
	else{
		descText2.setFormat("fonts/Harbinger_Caps.otf", 30, 0xF2C0AC, "center");
		descText2.y = descTextName.y + 50;
	}
	descText2.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 3.2, 50);
	descTextName.text = member.name;

	descText.screenCenter(FlxAxes.X);
	descText2.screenCenter(FlxAxes.X);
	descTextName.screenCenter(FlxAxes.X);
}

function destroy() {Framerate.instance.visible = true; moustacheMode = false;}