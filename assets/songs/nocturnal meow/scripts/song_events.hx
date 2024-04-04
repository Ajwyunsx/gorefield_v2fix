var scaryTime:Bool = false;

var hudMembers:Array<FlxSprite>;
var bloom:CustomShader;

function create()
{
    bloom = new CustomShader("glow");
    bloom.size = 0.0;// trailBloom.quality = 8.0;
    bloom.dim = 2;// trailBloom.directions = 16.0;
    if (FlxG.save.data.bloom) {FlxG.camera.addShader(bloom); camHUD.addShader(bloom);}
}

function postCreate()
{
    hudMembers = [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt];
    hudMembers = hudMembers.concat([for (note in cpuStrums.members) note]);
    for (member in hudMembers)
        member.visible = false;

    boyfriend.cameraOffset.x += 20;
    boyfriend.cameraOffset.y += 80;
}

function stepHit(step:Int) 
{
    if(scaryTime)
    {
        camGame.shake(0.006,0.1);
        camHUD.shake(0.005,0.1);
    }

    switch (step)
    {
        case 256:
            strumLineBfZoom = 1.5;
            boyfriend.cameraOffset.x -= 20;
            boyfriend.cameraOffset.y -= 80;
            showPopUp(true, PlayState.instance.misses);

            for (member in hudMembers)
            {
                member.visible = true;
                member.alpha = 0;
                FlxTween.tween(member, {alpha: 1}, 0.4);
            }
        case 1232:
            rain.visible = false;
            rain2.visible = true;

            remove(stage.stageSprites["black"]);
            insert(members.indexOf(stage.stageSprites["lightning_bolt"]) - 1, stage.stageSprites["black"]);

            stage.stageSprites["black"].alpha = 0.8;
            stage.stageSprites["black"].visible = stage.stageSprites["black"].active = true;
            FlxTween.tween(stage.stageSprites["black"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 6, {startDelay: (Conductor.stepCrochet / 1000) * 1});

            camGame.shake(0.02, 1);
            camHUD.shake(0.02, 1);

            bloom.size = 8.0;
            bloom.dim = 1.2;

            FlxTween.num(8, 0, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quadInOut,startDelay: (Conductor.stepCrochet / 1000) * 1}, (val:Float) -> {bloom.size = val;});
            FlxTween.num(1.2, 2, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quadInOut,startDelay: (Conductor.stepCrochet / 1000) * 1}, (val:Float) -> {bloom.dim = val;});

            var lightning_bolt:FlxSprite = stage.stageSprites["lightning_bolt"];
            lightning_bolt.visible = true;
            lightning_bolt.animation.play("lightning_bolt");
            lightning_bolt.animation.finishCallback = 
                function(_)
                {
                    lightning_bolt.animation.stop();
                    lightning_bolt.visible = lightning_bolt.active = false;
                    scaryTime = true;
                }
        case 1504:
            scaryTime = false;
            boyfriend.cameraOffset.y += 80;
        case 1632:
            scaryTime = true;
            camFollowChars = false;
            camFollow.setPosition(950, 250);
        case 1784:
            scaryTime = false;
            camHUD.visible = false;
            FlxG.camera.visible = false;
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
                spr.visible = false;
    }
}