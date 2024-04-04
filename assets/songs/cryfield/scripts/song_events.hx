var oldBlackIndex:Int;
var bloom:CustomShader;

function create(){
    bloom = new CustomShader("glow");
    bloom.size = 0.0;// trailBloom.quality = 8.0;
    bloom.dim = 2;// trailBloom.directions = 16.0;
    if (FlxG.save.data.bloom) {FlxG.camera.addShader(bloom); camHUD.addShader(bloom);}
}

function postCreate(){
    snapCam();
    tweenHUD(0,0.01);
    oldBlackIndex = members.indexOf(stage.stageSprites["black"]);
}

function stepHit(step:Int){
    switch(step){
        case 118:
            tweenHUD(1,(Conductor.stepCrochet / 1000) * 8);
        case 384:
            defaultCamZoom += 0.3;
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
                FlxTween.tween(spr, {alpha: 0}, (Conductor.stepCrochet / 1000) * 12);
        case 432 | 496 | 784 | 816 | 840 | 856 | 872 | 888:
            defaultCamZoom += 0.2;
        case 448 | 848 | 800 | 832 | 864 | 880 | 894:
            defaultCamZoom -= 0.2;
        case 512:
            defaultCamZoom -= 0.2;
            camFollowChars = false;
            camFollow.x = boyfriend.x - 50;
        case 526:
            zoomDisabled = true;
            FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom - 0.4}, (Conductor.stepCrochet / 1000) * 114);
        case 636:
            remove(stage.stageSprites["black"]);
            insert(members.indexOf(stage.stageSprites["lightning_bolt"]) - 1, stage.stageSprites["black"]);

            stage.stageSprites["lightning_bolt"].visible = true;
            stage.stageSprites["lightning_bolt"].animation.play('lightning_bolt',true);

            stage.stageSprites["black"].alpha = 0.8;
            stage.stageSprites["black"].visible = stage.stageSprites["black"].active = true;
            FlxTween.tween(stage.stageSprites["black"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 6, {startDelay: (Conductor.stepCrochet / 1000) * 1});

            bloom.size = 8.0;
            bloom.dim = 1.2;

            camGame.shake(0.01,0.3);
            camHUD.shake(0.005,0.3);
            
            FlxTween.num(8, 0, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quadInOut,startDelay: (Conductor.stepCrochet / 1000) * 1}, (val:Float) -> {bloom.size = val;});
            FlxTween.num(1.2, 2, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quadInOut,startDelay: (Conductor.stepCrochet / 1000) * 1}, (val:Float) -> {bloom.dim = val;});
        case 640:
            zoomDisabled = false;
            camFollowChars = true;
            defaultCamZoom -= 0.3; 
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
                FlxTween.tween(spr, {alpha: 1}, (Conductor.stepCrochet / 1000) * 8);
            
            FlxTween.tween(rain, {alpha: 0.6}, (Conductor.stepCrochet / 1000) * 24);
        case 650:
            remove(stage.stageSprites["black"]);
            insert(oldBlackIndex, stage.stageSprites["black"]);
        case 896:
            stage.stageSprites["black"].alpha = 0;
            FlxTween.tween(stage.stageSprites["black"], {alpha: 1}, (Conductor.stepCrochet / 1000) * 5);
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 8);
    }
}

function onStrumCreation(_) _.__doAnimation = false;