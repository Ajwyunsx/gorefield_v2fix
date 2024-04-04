//
import flixel.text.FlxTextBorderStyle;
import Xml;

var freePlayList:Array<String> = ["The Great Punishment", "Curious Cat", "Metamorphosis", "Hi Jon", "Terror in the Heights", "BIGotes"];
var freePlatIcons:Array<String> = ["gorefield-phase-0", "garfield", "gorefield-phase-2", "gorefield-phase-3", "gorefield-phase-4", "bigotes"];

var songMenuItems:Array<FunkinText> = [];
var iconMenuItems:Array<FunkinText> = [];

var curSelected:Int = 0;

function create() {
    for (i => song in freePlayList) {
        var newText:FunkinText = new FunkinText(0, 0, 0, song, 54, true);
        newText.setFormat("fonts/pixelart.ttf", 64, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        newText.borderSize = 4; newText.alpha = 0;
        songMenuItems.push(add(newText));

        var charXML = null;
        var xmlPath = Paths.xml('characters/' + freePlatIcons[i]);
        if (Assets.exists(xmlPath))
            charXML = Xml.parse(Assets.getText(xmlPath)).firstElement();
        else continue;
    
        var path = 'icons/' + (charXML.exists("icon") ? charXML.get("icon") : freePlatIcons[i]);
        if (!Assets.exists(Paths.image(path))) path = 'icons/face';
        var icon = new FlxSprite();
        if ((charXML != null && charXML.exists("animatedIcon")) ? (charXML.get("animatedIcon") == "true") : false) {
            icon.frames = Paths.getSparrowAtlas(path);
            icon.animation.addByPrefix("losing", "losing", 24, true);
            icon.animation.addByPrefix("idle", "idle", 24, true);
            icon.animation.play("idle");
        } else {
            icon.loadGraphic(Paths.image(path)); // load once to get the width and stuff
            icon.loadGraphic(icon.graphic, true, icon.graphic.width/2, icon.graphic.height);
            icon.animation.add("non-animated", [0,1], 0, false);
            icon.animation.play("non-animated");
        }
        iconMenuItems.push(add(icon));
    }
}

var __firstFrame:Bool = true;
function update(elapsed:Float) {
    if (controls.BACK) FlxG.switchState(new MainMenuState());
    if (controls.DOWN_P) changeSong(1);
	if (controls.UP_P) changeSong(-1);
	if (controls.ACCEPT) goToSong();

    for (i => song in songMenuItems) {
        var scaledY = FlxMath.remapToRange((i-curSelected), 0, 1, 0, 1.3);
        var y:Float = (scaledY * 120) + (FlxG.height * 0.48);
        var x:Float = ((i-curSelected) * 30) + 90;

        song.y = __firstFrame ? y + 0 : CoolUtil.fpsLerp(song.y, y, 0.16);
        song.x = __firstFrame ? x : CoolUtil.fpsLerp(song.x, x, 0.16);
        if (__firstFrame) {song.x -= 500+(1500*i);}

        iconMenuItems[i].alpha = song.alpha = lerp(song.alpha, i == curSelected ? 1 : 0.3, .25);

        iconMenuItems[i].updateHitbox();
        iconMenuItems[i].x = song.x + song.width + 16;
        iconMenuItems[i].y = song.y + (song.height/2) - (iconMenuItems[i].height/2);
    }
    __firstFrame = false;
}

function changeSong(change:Int) {
    curSelected = FlxMath.wrap(curSelected + change, 0, songMenuItems.length-1);
	FlxG.sound.play(Paths.sound("menu/scrollMenu"));
}

function goToSong() {
    FlxG.sound.play(Paths.sound("menu/confirmMenu"));
    PlayState.loadSong(freePlayList[curSelected], "hard", false, false);
    FlxG.switchState(new ModState("gorefield/LoadingScreen"));
}