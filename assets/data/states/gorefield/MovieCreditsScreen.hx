import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxTextBorderStyle;
import std.Xml;
import funkin.backend.scripting.GlobalScript;

importScript("data/scripts/menuVars");

var curSelected:Int = 0;
var credits:Array<{name:String,role:String,description:String,social_link:String}> = [];

var colowTwn:FlxTween;

var logoBl:FlxSprite;
var thanksText:FlxSprite;

var icon:FlxSprite;
var name:FlxText;
var role:FlxText;
var description:FlxText;
function create() {
	redirectStates.set(StoryMenuState, "gorefield/StoryMenuScreen");

	CoolUtil.playMusic(Paths.music("Layers_on_Layers_Credits_Song"));


	var data:Xml = Xml.parse(Assets.getText(Paths.file("data/config/credits.xml"))).firstElement();
	for (member_data in data.elementsNamed("member")) {
		credits.push({
			name: member_data.get("name"),
			role: member_data.get("rol_" + (FlxG.save.data.spanish ? "es" : "en")),
			description: member_data.get("desc_" + (FlxG.save.data.spanish ? "es" : "en")),
			social_link: member_data.get("social_link"),
		});
	}


	FlxG.cameras.remove(FlxG.camera, false);
	
	var camBG:FlxCamera = new FlxCamera(0, 0);
	for (cam in [camBG, FlxG.camera])
		{FlxG.cameras.add(cam, cam == FlxG.camera); cam.bgColor = 0x00000000; cam.antialiasing = true;}
	camBG.bgColor = FlxColor.fromRGB(17,5,33);

	var bgSprite:FlxBackdrop = new FlxBackdrop(Paths.image("menus/WEA_ATRAS"), 0x11, 0, 0);
	bgSprite.cameras = [camBG]; 
	bgSprite.colorTransform.color = 0xFFFFFFFF;
	bgSprite.velocity.set(100, 100);
	add(bgSprite);

	colowTwn = FlxTween.color(null, 5.4, 0xFF90D141, 0xFFF09431, {ease: FlxEase.qaudInOut, type: 4 /*PINGPONG*/, onUpdate: function () {
		bgSprite.colorTransform.color = colowTwn.color;
	}});
	

	logoBl = new FlxSprite(451, 100);
	logoBl.frames = Paths.getSparrowAtlas('menus/logoMod');
	logoBl.animation.addByPrefix('bump', 'logo bumpin', 24, false);
	logoBl.animation.play('bump');
	logoBl.scale.set(0.5, 0.5);
	logoBl.updateHitbox();
	logoBl.antialiasing = true;
	add(logoBl);

	thanksText = new FlxText(0, 394, 0, FlxG.save.data.spanish ? "Gracias por jugar!" : "Thanks for playing!");
	thanksText.setFormat("fonts/pixelart.ttf", 40, 0xFFFFFFFF, "center", FlxTextBorderStyle.OUTLINE, 0xFF000000);
	thanksText.screenCenter(FlxAxes.X);
	add(thanksText);

	var acceptStr1:String = CoolUtil.keyToString(Options.P1_ACCEPT[0]);
	var acceptStr2:String = CoolUtil.keyToString(Options.P2_ACCEPT[0]);
	var enterText:FLxText = new FlxText(0, FlxG.height - 30, 0, 
		FlxG.save.data.spanish ? 
		"Presiona " + acceptStr1 + " o " + acceptStr2 + " para continuar" : 
		"Press " + acceptStr1 + " or " + acceptStr2 + " to continue");
	enterText.setFormat("fonts/pixelart.ttf", 20, 0xFFFFFFFF, "center", FlxTextBorderStyle.OUTLINE, 0xFF000000);
	enterText.screenCenter(FlxAxes.X);
	enterText.alpha = 0.4;
	add(enterText);


	icon = new FlxSprite(200);
	icon.loadGraphic(Paths.image("menus/credits/Jloor"));
	icon.active = icon.visible = false;
	add(icon);

	role = new FlxText(0, 220, 690, "");
	role.setFormat(Paths.font("pixelart.ttf"), 40, 0xFFFFFFFF, "center", FlxTextBorderStyle.OUTLINE, 0xFF000000);
	role.x = 824 - role.width / 2;
	add(role);
	
	description = new FlxText(0, 280, 700, "");
	description.setFormat(Paths.font("Harbinger_Caps.otf"), 35, 0xFFFFFFFF, "center", FlxTextBorderStyle.OUTLINE, 0xFF000000);
	description.x = 824 - description.width / 2;
	add(description);

	/* Enable this for make the icon moves like DVD logo
	icon.velocity.set(100, 100); */
}

function beatHit(curBeat:Int) {
	if (!logoBl.active || !logoBl.visible) return;

	if (curBeat % 2 == 0) logoBl.animation.play('bump',true);
}

var totalTime:Float = 0; 
function calcIconPosition():Float {
	return 140 + Math.floor(10 * FlxMath.fastSin(totalTime * 2 + (Math.PI/2)));
}

var alpha_tweens:Array<{object:FlxSprite,delay:Float,duration:Float,curDuration:Float}> = [];
function updateTweens(elapsed:Float) {
	for (tween in alpha_tweens) {
		if (tween.delay > 0) {
			tween.object.alpha = 0;
			tween.delay -= elapsed;
			continue;
		}

		if (tween.duration <= 0) {
			alpha_tweens.remove(tween); 
			continue;
		}

		tween.curDuration += elapsed;
		tween.object.alpha = tween.curDuration / tween.duration;
	}
}

var iconAppearTween:FlxTween;

var changing:Bool = false;
function update(elapsed:Float) {
	if (controls.BACK) FlxG.switchState(new MainMenuState());
	if (controls.ACCEPT && !changing) changeSelection(curSelected++);

	updateTweens(elapsed);

	if (icon.active && icon.visible && iconAppearTween != null && !iconAppearTween.active) {
		totalTime += elapsed;

		icon.y = calcIconPosition();

		/* Enable this too for make the icon moves like the DVD logo
		if (icon.y + icon.height >= FlxG.height && icon.velocity.y > 0)
			icon.velocity.y *= -1;
		if (icon.x + icon.width >= FlxG.width && icon.velocity.x > 0)
			icon.velocity.x *= -1;
		if (icon.y <= -42 && icon.velocity.y < 0)
			icon.velocity.y *= -1;
		if (icon.x <= 0 && icon.velocity.x < 0)
			icon.velocity.x *= -1; */
	}
}

function alphaTween(object:FlxSprite, delay:Float, duration:Float) {
	alpha_tweens.push({
		object: object,
		delay: delay,
		duration: duration,
		curDuration: 0
	});
}

function changeSelection(selection:Int) {
	if (selection >= credits.length) {
		if (!FlxG.save.data.alreadySeenCredits) {
			FlxG.save.data.alreadySeenCredits = fromMovieCredits = true;
			FlxG.save.flush();
		}
		FlxG.switchState(new StoryMenuState());
		return;
	}
	FlxG.sound.play(Paths.sound("menu/scrollMenu"));

	changing = true;

	var data = credits[selection];
	
	if (iconAppearTween != null && iconAppearTween.active)
		iconAppearTween.cancel();

	function switchOut(){
		if (selection == 0) {
			logoBl.active = logoBl.visible = false;
			thanksText.active = thanksText.visible = false;
	
			icon.active = icon.visible = true;
		}

		icon.y = FlxG.height;
		iconAppearTween = FlxTween.tween(icon, {y: calcIconPosition()}, 0.8, {ease: FlxEase.cubeOut});
	
		role.y = 220;
		role.text = data.role;
		description.text = data.description;
		description.y = role.y + role.height + 31;
	
		role.alpha = description.alpha = 0;
		// El FlxTween del alpha no se cancela como quiero así que haré como ese gif de Lean que dice: "Fine, I'll do it myself" -EstoyAburridow   XD - Lean
		alpha_tweens = [];
		for (i => sprite in [role, description])
			alphaTween(sprite, 0.4 + i * 0.1, 0.3);
	
		if (selection % 2 == 0) {
			icon.x = 100;
			role.x = description.x = description.x = 824 - description.width / 2;
		} else { 
			icon.x = 812;
			role.x = description.x = description.x = 456 - description.width / 2;
		}
	
		icon.loadGraphic(Paths.image("menus/credits/" + data.name));

		changing = false;
	}

	if (selection >= 1){
		for (i => sprite in [role, description]){
			for (tween in alpha_tweens){
				if (tween.object == sprite)
					alpha_tweens.remove(tween);
			}
			FlxTween.tween(sprite, {alpha: 0, y: sprite.y + 70},0.3, {startDelay: i * 0.05, ease: FlxEase.cubeOut});
		}
		iconAppearTween = FlxTween.tween(icon, {y: -440}, 0.8, {ease: FlxEase.cubeOut, onComplete: function(twn){
			switchOut();
		}});
	}
	else if (selection == 0){
		for (i => sprite in [thanksText, logoBl])
			FlxTween.tween(sprite, {y: sprite.y + 700},0.9, {startDelay: i * 0.05, ease: FlxEase.cubeInOut});
		new FlxTimer().start(0.9 * 1.05, function(tmr){
			switchOut();
		});
	}
	else{switchOut();}
}