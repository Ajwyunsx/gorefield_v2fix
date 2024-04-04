package funkin.menus;

import flixel.util.FlxAxes;
import openfl.ui.Mouse;
import flixel.tweens.FlxTween;
import flixel.addons.display.FlxBackdrop;
import funkin.backend.utils.DiscordUtil;
import flixel.effects.FlxFlicker;
import funkin.menus.AlphaWarningScreen;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class LaguageSelectorScreen extends MusicBeatState {
var curSelected:Int = -1;
var selected_something:Bool = true;

var languages:Array<String> = ["English", "Espanol"];
var ogOffset:Array<Float> = [0, 0];
var options:FlxTypedGroup<FlxSprite>;

var colowTwn:FlxTween;

var camBG:FlxCamera;

public override function create()
{
    if(!FlxG.save.data.firstTimeLanguage){
        new FlxTimer().start(.1, function (tmr:FlxTimer) {
            FlxG.switchState(new AlphaWarningScreen());
        });
        return;
    }
    else{
        FlxG.save.data.firstTimeLanguage = false;
    }
    DiscordUtil.changePresence('Selecting Language...', "");
    FlxG.mouse.visible = FlxG.mouse.useSystemCursor = true;

    options = new FlxTypedGroup();
    add(options);

    for (i => language in languages)
    {
        var option:FlxSprite = new FlxSprite();
        option.loadGraphic(Paths.image("menus/language/" + language.toUpperCase()));
        option.ID = i;
        
        option.antialiasing = true;
        option.color = 0xFF7B7B7B;

        option.scale.set(0.7, 0.7);
        option.updateHitbox();

        option.screenCenter(FlxAxes.XY);
        option.x = (i * 600) + 180;
        option.y -= 40;

        ogOffset.push(option.offset.y);

        option.alpha = 0; option.y + 40;
        FlxTween.tween(option, {alpha: 1, y: option.y-40}, .3, {startDelay: .4 +  0.1*i});

        options.add(option);
    }

     super.create();
	
     FlxG.camera.alpha = 0;
    (new FlxTimer()).start(.3, (_) -> {
        FlxTween.tween(FlxG.camera, {alpha: 1}, .3);
        selected_something = false;
        FlxG.camera.zoom = 0.8;
    });

}

var tottalTimer:Float = -.6;
var cursor:String = null;
var zoomShit:Float = 0.9;
public override function update(elapsed:Float)
{
    tottalTimer += elapsed;
    cursor = null;

    var overSomething:Bool = false;
    if (!selected_something) {
        if (FlxG.mouse.justMoved)
        {
            for (i=>option in options.members) {
                if (FlxG.mouse.overlaps(option)) {
                    overSomething = true;
                    changeItem(option.ID, true);
                    
                    cursor = "button";
                }
            }

            if (!overSomething)
                changeItem(-1, true);
        }

        for (i=>option in options.members)
            option.offset.y = ogOffset[i] + ((Math.sin(tottalTimer + (i*.8)) * 10));

        if (controls.RIGHT_P)
            changeItem(1, false);
        else if (controls.LEFT_P)
            changeItem(-1, false);

        if (curSelected != -1
            && ((FlxG.mouse.justPressed && FlxG.mouse.overlaps(options.members[curSelected]))
            || controls.ACCEPT)) 
        {
            selected_something = true;

            FlxG.sound.play(Paths.sound('menu/confirm'));

            FlxG.save.data.spanish = curSelected == 1;
            FlxG.save.flush();

            for (i=>option in options.members)
                if (i != curSelected) 
                    FlxTween.tween(option, {alpha:0}, 0.15);
                else {
                    FlxTween.tween(option, {x: FlxG.width/2 - option.width/2, y: (FlxG.height/2 - option.height/2)-60}, 0.4, {ease: FlxEase.circOut});
                    zoomShit = 1;
                    FlxFlicker.flicker(option, .6, .05, true, false);
                    (new FlxTimer()).start(0.6, (_) -> {option.visible = false;});
                }
                    

            new FlxTimer().start(.7, function (tmr:FlxTimer) {
                FlxG.switchState(new AlphaWarningScreen());
            });
        }
    }

   super.update(elapsed);
	    
// MARIO MADNESS ????????? -lunar | OMG -EstoyAburridow
    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.008, (1/30)*240*elapsed);
    FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.008, (1/30)*240*elapsed);

    FlxG.camera.zoom = FlxMath.lerp(
        FlxG.camera.zoom, zoomShit * (.98 - 
        (Math.abs(((FlxG.mouse.screenX*0.4) + 
        (FlxMath.remapToRange(FlxG.mouse.screenY, 0, FlxG.height, 0, FlxG.width)*0.6))
        -(FlxG.width/2)) * 0.00001)), 
    (1/80)*240*elapsed);

    Mouse.cursor = cursor;
}

function changeItem(change:Int, force:Bool)
{
    if (force && curSelected == change)
        return;

    if (curSelected != -1) {
        var prevText = options.members[curSelected];
        prevText.color = 0xFF7B7B7B;
    }

    if (force)
        curSelected = change;
    else {
        curSelected += change;

        if (curSelected >= options.members.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = options.members.length - 1;
    }

    if (curSelected != -1) {
        FlxG.sound.play(Paths.sound("menu/scrollMenu"));

        var curText = options.members[curSelected];   
        curText.color = 0xFFFFFF;
    }
}
}
