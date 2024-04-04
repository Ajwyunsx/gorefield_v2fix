//
import haxe.xml.Access;
import flixel.util.FlxAxes;
import openfl.geom.ColorTransform;
import openfl.geom.Rectangle;
import flixel.sound.FlxSound;
import funkin.backend.system.framerate.Framerate;
import flixel.text.FlxTextBorderStyle;
import flixel.addons.effects.FlxTrail;
import funkin.backend.scripting.Script;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatRange;
import hscript.TemplateClass;
import StringTools;

var box:FlxSprite;
var prompt:FlxSprite;
var bars:FlxSprite;
var eyes:FlxSprite;
var black:FlxSprite;

var cloudBubble1:FlxSprite;
var cloudBubble2:FlxSprite;
var cloudTrail:FlxTrail;
var cloud:FlxSprite;

var cloudPortraits:Map<String, FlxSprite> = ["Clown" => null, "cryfieldSecret" => null, "Emote" => null, "Explosion" => null, "Note" => null, "chart" => null, "Snow" => null, "Furniture" => null, "Note_Green" => null];
var cloudPositions:Map<String, Array<Float>> = ["Clown" => null, "cryfieldSecret" => null, "Emote" => null, "Explosion" => null, "Note" => null, "chart" => null, "Snow" => null, "Furniture" => null, "Note_Green" => null];
var cloudPortaitName:String = "Snow";

var cloudPortrait:FlxSprite;

var dialoguetext:FlxText;
var __curTxTIndx:Int = -1;
var __finishedMessage:String = "";
var __skippedText:Bool = false;
var __canAccept:Bool = false;

var __randSounds:Array<String> = ["easteregg/snd_text", "easteregg/snd_text_2"];
var dialogueList:Array<{message_en:String, message_es:String, expression:String, typingSpeed:Float, startDelay:Float, event:Int->Void}> = [];
var endingCallback:Void->Void = function () {
	dialoguetext.alpha = 1;
	dialoguetext.text = "END DIALOGUE\n(ESC to go back to freeplay)";
};
var curDialogue:Int = -1;

var menuMusic:FlxSound;
var clownTheme:FlxSound;
var wind:FlxSound;
var introSound:FlxSound;

var grpClouds = null;
var grpClouds1 = null;
var grpClouds2 = null;
var cacheInfo = [null, null, null, null];
var cacheInfo1 = [null, null, null, null];
var cacheInfo2 = [null, null, null, null];

var script:Script;

function create()
{
	FlxG.sound.music.volume = 0;

	//FlxG.save.data.arlenePhase = 4; 
	//FlxG.save.data.canVisitArlene = true;
	//FlxG.save.data.hasVisitedPhase = false;

	var scriptPath:String = Paths.script("data/dialogue/phase-" + Std.string(FlxG.save.data.arlenePhase) + (FlxG.save.data.hasVisitedPhase ? "-post" : ""));
	// var scriptPath:String =  Paths.script("data/dialogue/phase-anim-testing");
	if (Assets.exists(scriptPath)) {
		script = Script.create(scriptPath);

		var scriptClass:TemplateClass = new TemplateClass();
		Reflect.setField(scriptClass, "__interp", __script__.interp);

		script.set("dialscript", scriptClass);
		script.load();
	}
		
	script.call("create");
	Framerate.instance.visible = false;

	bars = new FlxSprite(0, FlxG.height/6).loadGraphic(Paths.image("easteregg/Arlene_Box"));
	bars.scale.set(6, 6); bars.updateHitbox(); bars.screenCenter(FlxAxes.X);
	
	wind = FlxG.sound.play(Paths.sound('easteregg/Wind_Sound'), 0, true);
	FlxTween.tween(wind, {volume: 1}, 6);
		
	eyes = new FlxSprite().loadGraphic(Paths.image("easteregg/Arlene_Eyes"), true, 80, 34);
	eyes.animation.add("normal", [0], 0); eyes.animation.add("left", [1], 0);
	eyes.animation.add("smug", [2], 0); eyes.animation.add("confused", [3], 0);
	eyes.animation.play("normal");
	eyes.alpha = 0.000001; eyes.scale.set(3.5, 3.5); 
	eyes.updateHitbox(); eyes.screenCenter(FlxAxes.X);
	add(eyes);
	add(bars);

	grpClouds = new FlxTypedGroup();

	for(i in 0...4) {
		var cloudd = new FlxSprite().loadGraphic(Paths.image("easteregg/cloudMain"));
		cloudd.scale.set(3.5, 3.5); cloudd.updateHitbox();
		cloudd.setPosition(986, 65);
		cloudd.visible = false;
		grpClouds.add(cloudd);
	}

	grpClouds.ID = 0;
	add(grpClouds);

	cloud = new FlxSprite().loadGraphic(Paths.image("easteregg/cloudMain"));
	cloud.scale.set(3.5, 3.5); cloud.updateHitbox();
	cloud.setPosition(986, 65);

	/* cloudTrail = new FlxTrail(cloud, null, 4, 0, 1, 0.069);
	add(cloudTrail); */

	add(cloud);

	grpClouds1 = new FlxTypedGroup();

	for(i in 0...4) {
		var cloudBubble1d = new FlxSprite().loadGraphic(Paths.image("easteregg/cloud1"));
		cloudBubble1d.scale.set(3.5, 3.5); cloudBubble1d.updateHitbox();
		cloudBubble1d.setPosition(956, 256);
		grpClouds1.add(cloudBubble1d);
	}

	grpClouds1.ID = 1;
	add(grpClouds1);

	cloudBubble1 = new FlxSprite().loadGraphic(Paths.image("easteregg/cloud1"));
	cloudBubble1.scale.set(3.5, 3.5); cloudBubble1.updateHitbox();
	cloudBubble1.setPosition(956, 256);
	add(cloudBubble1);

	grpClouds2 = new FlxTypedGroup();

	for(i in 0...4) {
		var cloudBubble2d = new FlxSprite().loadGraphic(Paths.image("easteregg/cloud2"));
		cloudBubble2d.scale.set(3.5, 3.5); cloudBubble2d.updateHitbox();
		cloudBubble2d.setPosition(900, 246);
		grpClouds2.add(cloudBubble2d);
	}

	grpClouds2.ID = 2;
	add(grpClouds2);

	cloudBubble2 = new FlxSprite().loadGraphic(Paths.image("easteregg/cloud2"));
	cloudBubble2.scale.set(3.5, 3.5); cloudBubble2.updateHitbox();
	cloudBubble2.setPosition(900, 246);
	add(cloudBubble2);

	for (name in cloudPortraits.keys()) {
		var cloudPortrait:FlxSprite = new FlxSprite().loadGraphic(Paths.image("easteregg/" + name));
		cloudPortrait.scale.set(2.5, 2.5); cloudPortrait.updateHitbox();
		add(cloudPortrait); 

		switch (name) {
			case "Note" | "Note_Green": cloudPositions.set(name, [103, 73]);
			case "chart": cloudPositions.set(name, [112, 66]);
			case "cryfieldSecret": cloudPositions.set(name, [50, 36]);
			case "Explosion": cloudPositions.set(name, [74, 42]);
			case "Emote": cloudPositions.set(name, [132, 48]);
			case "Furniture": cloudPositions.set(name, [122, 62]);
			case "Snow": cloudPositions.set(name, [116, 62]);
			default: cloudPositions.set(name, [76, 38]);
		}
		
		cloudPortraits.set(name, cloudPortrait);
	}

	cloudPortrait = cloudPortraits.get(cloudPortaitName);
	//FlxG.camera.scroll.x = 200;

	box = new FlxSprite(0, (FlxG.height/6)*3).loadGraphic(Paths.image("easteregg/Arlene_Text"));
	box.scale.set(3.7,3.7); box.alpha = 0; box.scrollFactor.set();
	box.updateHitbox(); box.screenCenter(FlxAxes.X);
	add(box);
	
	dialoguetext = new FlxText(box.x + 80, box.y + 70, box.width - 160, "", 24);
	dialoguetext.setFormat("fonts/GrapeSoda.ttf", 44, 0xff8f93b7, "left", FlxTextBorderStyle.SHADOW, 0xFF19203F);
	dialoguetext.borderSize = 2; dialoguetext.shadowOffset.x += 1; dialoguetext.shadowOffset.y += 1; dialoguetext.wordWrap = true;
	dialoguetext.textField.antiAliasType = 0/*ADVANCED*/; dialoguetext.textField.sharpness = 400/*MAX ON OPENFL*/;
	add(dialoguetext); dialoguetext.scrollFactor.set();

	prompt = new FlxSprite().loadGraphic(Paths.image("easteregg/arrow"));
	prompt.scale.set(3.7,3.7); prompt.updateHitbox(); prompt.alpha = 0;
	prompt.setPosition(box.x + box.width - 160 + prompt.width, box.y + box.height - 64);
	add(prompt); prompt.scrollFactor.set();

	black = new FlxSprite().makeSolid(FlxG.width, FlxG.height, 0xFF000000);
	black.scrollFactor.set();
	add(black);

	for (member in members) {
		if(member == grpClouds || member == grpClouds1 || member == grpClouds2) continue;
		member.antialiasing = false;
		member.visible = member == bars || member == black ? true : FlxG.save.data.canVisitArlene;
	}
	grpClouds.visible = cloud.visible = cloudBubble1.visible = cloudBubble2.visible = cloudPortrait.visible = grpClouds.visible = grpClouds1.visible = grpClouds2.visible = false;
	for (name => spr in cloudPortraits) spr.visible = false;

	script.call("postCreate");
}

var fastFirstFade:Bool = false;
var fadeOut:Bool = false;
var blackTime:Float = 0;
var tottalTime:Float = 0;
var gayTimer = 0;
var firstFrame = true;
function update(elapsed:Float) {
	script.call("update", [elapsed]);
	tottalTime += elapsed; blackTime += elapsed; gayTimer += elapsed;

	eyes.y = bars.y + ((bars.height/2)-(eyes.height/2)) + Math.floor(5 * FlxMath.fastSin(tottalTime + (Math.PI/2)));
	var blackA:Float = Math.floor(((blackTime * (fastFirstFade ? 2 : 1))/4) * 8) / 8;
	black.alpha = FlxMath.bound(fadeOut ? blackA : 1-blackA, 0, 1);

	prompt.y = box.y + box.height - 64 + Math.floor(4 * FlxMath.fastSin(tottalTime* 1.5));
	prompt.color = tottalTime % 1 > .5 ? 0xFFADADAD : 0xFFFFFFFF;

	prompt.alpha = __canAccept && __curTxTIndx == __finishedMessage.length-1 ? 1 : 0;

	cloud.setPosition(986 + (6 * (Math.floor(FlxMath.fastSin(tottalTime/1.5)*4)/4)), 65 + (6 * (Math.floor(FlxMath.fastCos(tottalTime/1.5)*4)/4)));
	cloudBubble1.setPosition(956 + (6 * (Math.floor(FlxMath.fastSin((tottalTime+.2)/1.5)*4)/4)) + (tottalTime*6%6), 256+ (4 * (Math.floor(FlxMath.fastCos((tottalTime+.2)/1.5)*4)/4)));
	cloudBubble2.setPosition(900 + (6 * (Math.floor(FlxMath.fastSin((tottalTime+.3)/1.5)*4)/4)), 246 + (4 * (Math.floor(FlxMath.fastCos((tottalTime+.3)/1.5)*4)/4)));
	/*for (i=>tt in cloudTrail.members) {
		var scale = Math.max(1.3 + .11 * FlxMath.fastSin(tottalTime + (i * FlxG.random.float(0, .3))), 0.9);
		tt.scale.set(3 + scale, 3 + scale);
	}*/

	var cis = [cacheInfo, cacheInfo1, cacheInfo2];

	for(ci in cis) {
		for(c in ci) {
			if(c != null) c.alpha -= 0.25 * elapsed;
		}
	}

	for(grp in [grpClouds, grpClouds1, grpClouds2])
	for(i => c in grp.members) {
		var inf = cis[grp.ID][i];
		if(inf != null) {
			c.visible = true;
			c.x = inf.x;
			c.y = inf.y;
			c.alpha = inf.alpha;
			c.scale.x = c.scale.y = 2.7 + Math.max(1 + .11 * FlxMath.fastSin(tottalTime + (i * FlxG.random.float(0, .3))), 0.9);
		}
	}

	var delya = 1;//1/1;
	while(gayTimer > delya) {
		cacheInfo[0] = {
			x: cloud.x,
			y: cloud.y,
			alpha: 0.7,
		}
		cacheInfo.push(cacheInfo.shift());

		cacheInfo1[0] = {
			x: cloudBubble1.x,
			y: cloudBubble1.y,
			alpha: 0.7,
		}
		cacheInfo1.push(cacheInfo1.shift());

		cacheInfo2[0] = {
			x: cloudBubble2.x,
			y: cloudBubble2.y,
			alpha: 0.7,
		}
		cacheInfo2.push(cacheInfo2.shift());
		gayTimer -= delya;
	}

	if (cloudPortrait != null) {
		cloudPortrait.setPosition((cloud.x + cloudPositions.get(cloudPortaitName)[0]), (cloud.y + cloudPositions.get(cloudPortaitName)[1]));
		if (cloudPortaitName != "cryfieldSecret" && cloudPortaitName != "Furniture" && cloudPortaitName != "Snow" && cloudPortaitName != "chart" && cloudPortaitName != "Emote") 
			{cloudPortrait.x += FlxG.random.int(-1, 1); cloudPortrait.y += FlxG.random.int(-1, 1);}
		if (cloudPortaitName == "Snow") {
			cloudPortrait.angle = Math.floor((Math.sin(tottalTime + Math.PI) * 16)/6)*6;
			cloudPortrait.x += Math.floor((Math.sin(tottalTime+ (Math.PI/2))*6) *4)/4;
			cloudPortrait.scale.x = cloudPortrait.scale.y = 2.7 + (Math.floor((Math.sin(tottalTime+Math.PI)*.3) * 6)/6);
		}
	}

	if (tottalTime >= (fastFirstFade ? 2 : 4)) eyes.alpha = FlxMath.bound((Math.floor(((tottalTime-(fastFirstFade ? 4 : 6))/1) * 8) / 8), 0, 1);

	if (controls.ACCEPT && __canAccept) progressDialogue();
	if (controls.BACK) FlxG.switchState(new StoryMenuState());

	firstFrame = false;
	script.call("postUpdate", [elapsed]);
}

function progressDialogue() {
	if (__curTxTIndx != __finishedMessage.length-1) {__skippedText = true; return;}

	if (curDialogue++ >= dialogueList.length-1) {box.alpha = dialoguetext.alpha = prompt.alpha = 0; endingCallback(); __canAccept = false; endDialogue(); return;}
	var dialogueData = dialogueList[curDialogue]; endDialogue();

	eventCount = __curTxTIndx = 0; __canAccept = true;
	dialoguetext.text = __finishedMessage = "";

	(new FlxTimer()).start(dialogueData.startDelay == null ? 0 : dialogueData.startDelay, function () {
		__finishedMessage = (FlxG.save.data.spanish ? dialogueData.message_es : dialogueData.message_en) + "&&&"; // add empty space just cause it feels better
		buildHighlights();
		__typeDialogue(dialogueData.typingSpeed);
	});
}

var yellowFormat:FlxTextFormat = new FlxTextFormat(0xFFFFFF00, false, false, 0xFF19203F, false);
function buildHighlights() {
	var removedChars:Int = 0;

	var ranges:Array<Dynamic> = [];
	var lastRange:Dynamic = null;
	for (i in 0...__finishedMessage.length) {
		var char = __finishedMessage.charAt(i);
		if (char != "$") continue; removedChars++;
		if (lastRange != null) {
			lastRange.end = i-removedChars;
			ranges.push(lastRange);
			lastRange = null;
		} else {lastRange = {start: i-removedChars, end: i-removedChars};}
	}

	// unclosed one
	if (lastRange != null) {
		lastRange.end = __finishedMessage.length-1;
		ranges.push(lastRange);
	}

	__finishedMessage = StringTools.replace(__finishedMessage, "$", "");
	dialoguetext._formatRanges = [
		for (range in ranges) new FlxTextFormatRange(yellowFormat, range.start, range.end+1)
	];

}

function endDialogue() {
	if (curDialogue-1 >= 0 && dialogueList[curDialogue-1].onEnd != null) dialogueList[curDialogue-1].onEnd();
}

var eventCount:Int = 0;
function __typeDialogue(time:Float = 0) {
	box.alpha = dialoguetext.alpha = 1;
	(new FlxTimer()).start(Math.max(0, time + FlxG.random.float(-0.005, 0.015)), function () {
		if (__skippedText) {
			__skippedText = false; dialoguetext.text = StringTools.replace(StringTools.replace(__finishedMessage, "%", ""), "&", "");
			while (__curTxTIndx < __finishedMessage.length) {
				__curTxTIndx++; 
				if (dialogueList[curDialogue].event != null && __finishedMessage.charAt(__curTxTIndx) == "%") 
					dialogueList[curDialogue].event(eventCount++);
			}
			__curTxTIndx--; return;
		}

		if (__finishedMessage.charAt(__curTxTIndx) != "&" && __finishedMessage.charAt(__curTxTIndx) != "%") {
			FlxG.sound.play(Paths.sound(__randSounds[FlxG.random.int(0, __randSounds.length-1)]), 0.4 + FlxG.random.float(-0.1, 0.1));
			dialoguetext.text += __finishedMessage.charAt(__curTxTIndx);
		}
		if (dialogueList[curDialogue].event != null && __finishedMessage.charAt(__curTxTIndx) == "%") 
			dialogueList[curDialogue].event(eventCount++);
		__curTxTIndx++; if (__curTxTIndx < __finishedMessage.length) {
			if (__finishedMessage.charAt(__curTxTIndx) != "&") __typeDialogue(time);
			else {(new FlxTimer()).start(0.15, function() __typeDialogue(time));}
		} else __curTxTIndx--;
	});
}

function isCharPhrase(char:Int, string:String)
	return char == string.length-1;

function showCloud(visible:Bool) {
	FlxTween.num(visible ? 0 : 220, visible ? 220 : 0, visible ? 1.2 : 1.6, {startDelay: visible ? .5 : 0.1}, (val:Float) -> {FlxG.camera.scroll.x = Math.floor(val/20)*20;});
	if (visible && cloudPortaitName == "Clown") (new FlxTimer()).start(0.5, function () {menuMusic.fadeOut(1);});
	else clownTheme.fadeOut(.4);
	(new FlxTimer()).start(visible ? .5 : .3, function (t) {
		FlxG.sound.play(Paths.sound("easteregg/Cloud_Arlene_Sound"));
		switch (visible ? t.elapsedLoops : t.loopsLeft + 1) {
			case 2: cloudBubble1.visible = grpClouds1.visible = visible;
			case 1: 
				cloudBubble2.visible = grpClouds2.visible = visible; 
				if (!visible) {(new FlxTimer()).start(0.4, () -> {menuMusic.play(); menuMusic.volume = 1; clownTheme.pause();});}
			case 3 | 0: 
				if (visible && cloudPortaitName == "Clown") {(new FlxTimer()).start(.7, function() {menuMusic.pause(); clownTheme.play();});}
				cloud.visible = grpClouds.visible = visible; cloudPortrait.visible = true; cloudPortrait.alpha = visible ? 1 : 0;
				if (visible)
					FlxTween.num(visible ? 0 : 1, visible ? 1 : 0, visible ? 1.3 : .4, {}, (val:Float) -> {cloudPortrait.visible = true; cloudPortrait.alpha = (Math.floor((val*100)/8)*8)/100;});
				else {cloudPortrait.visible = false; cloudPortrait.alpha = 0;}
		}
	}, 3);
}

function switchPortrait(time:Float, newOne:String) {
	FlxTween.num(1, 0, time, {}, (val:Float) -> {cloudPortraits.get(cloudPortaitName).visible = true; cloudPortraits.get(cloudPortaitName).alpha = (Math.floor((val*100)/8)*8)/100;});
	FlxTween.num(0, 1, time, {onComplete: (_) -> {cloudPortrait = cloudPortraits.get(newOne); cloudPortaitName = newOne;}}, 
	(val:Float) -> {cloudPortraits.get(newOne).visible = true; cloudPortraits.get(newOne).alpha = (Math.floor((val*100)/8)*8)/100;});
}

function destroy() {Framerate.instance.visible = true; script.destroy(); FlxG.sound.music.volume = 1;}