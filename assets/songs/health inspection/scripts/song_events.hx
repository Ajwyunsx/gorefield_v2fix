importScript("data/scripts/VideoHandler");

function create() 
{
    VideoHandler.load(["OH_NO_AGAIN"], true, function() {
        FlxG.camera.flash(0xffD4DE8F);
    });

    gf.scrollFactor.set(1, 1);
    gf.visible = false;
}

var goingInsane:Bool = false;
function stepHit(step:Int) 
{
    switch (step) 
    {
        case 832:
            for (strumLine in strumLines) tweenStrum(strumLine, 0.5, (Conductor.stepCrochet / 1000) * 2);
            tweenHealthBar(0,(Conductor.stepCrochet / 1000) * 2);
            VideoHandler.playNext();
        case 864:
            for (strumLine in strumLines) tweenStrum(strumLine, 1, (Conductor.stepCrochet / 1000) * 2);
            tweenHealthBar(1,(Conductor.stepCrochet / 1000) * 2);
            gf.visible = true;
            
            dad.x = -500;
        case 1376:
            goingInsane = true;
        case 1504:
            goingInsane = false;
            zoomDisabled = true;
            camFollowChars = false;
            FlxTween.tween(FlxG.camera, {zoom: 1.4}, (Conductor.stepCrochet / 1000) * 128, {ease: FlxEase.linear});
            FlxTween.tween(camFollow, {x: camFollow.x + 150}, (Conductor.stepCrochet / 1000) * 127, {ease: FlxEase.linear});
            tweenHealthBar(0,(Conductor.stepCrochet / 1000) * 20);
        case 1632:
            zoomDisabled = false;
            camFollowChars = true;
            tweenHealthBar(1,(Conductor.stepCrochet / 1000) * 4);
        case 1652:
            camFollowChars = false;
        case 1653:
            FlxTween.tween(dad, {x: 800}, 0.8);
        case 1662:
            FlxTween.cancelTweensOf(dad);
            camFollowChars = true;

            gf.visible = false;
            dad.x = -490;
        case 1936: camGame.visible = false;
        case 1944: FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.cubeInOut});
    }
}

function beatHit(beat:Int){
    if(!goingInsane) return;
    if (beat % 2 == 0){
        camHUD.angle -= 8;
        camGame.angle -= 3.5;
        camHUD.y += 5;
        FlxTween.tween(camHUD, {angle: 0, y: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        FlxTween.tween(camGame, {angle: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});   
    }
    else if (beat % 2 == 1){
        camHUD.angle += 8;
        camGame.angle += 3.5;
        camHUD.y -= 5;
        FlxTween.tween(camHUD, {angle: 0, y: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        FlxTween.tween(camGame, {angle: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});   
    }
}