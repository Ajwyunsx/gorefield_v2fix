import flixel.input.keyboard.FlxKeyList;
import flixel.FlxG;
import flixel.util.FlxAxes;

importScript("data/scripts/pixel-gorefield");
importScript("data/scripts/easteregg/paintings");

function create()
{
    var floorText:FlxText = new FlxText(0, 0, 0, 
        FlxG.save.data.spanish ?
        "Piso 2" :
        "Floor 2");
	floorText.setFormat("fonts/pixelart.ttf", 62, 0xFFD0DF8E, "center");
	floorText.screenCenter();
    floorText.scrollFactor.set();
    floorText.alpha = 0;
    add(floorText);
    
    camHUD.alpha = 0;

    // Countdown time is 1.8
    FlxTween.tween(floorText, {alpha: 1}, 0.5, {startDelay: 2.3});
    
    FlxTween.tween(camHUD, {alpha: 1}, 1.3, {startDelay: 3});
    FlxTween.tween(stage.stageSprites["nonblack"], {alpha: 0}, 1.3, {startDelay: 3});
    FlxTween.tween(floorText, {alpha: 0}, 1.3, {startDelay: 3});
}


function postCreate(){
	snapCam();
}