//
var bloom:CustomShader = null;
var coolShit:Bool = false; //so the console can SHUT UPPPPPPPPPPPPPPPPPPP

function create(){
    remove(dad); remove(boyfriend);
    add(boyfriend); add(dad);
    camHUD.alpha = 0;
}

var cooShit:Bool = false;
function stepHit(step:Int) {
    switch (step) {
        case 0: 
            FlxTween.tween(stage.stageSprites["black"], {alpha: 0}, (Conductor.stepCrochet / 1000) * (124));
            camFollowChars = false;
            camFollow.setPosition(960, 0);
            snapCam();
            FlxTween.tween(camFollow, {y: -400}, (Conductor.stepCrochet / 1000) * 50, {startDelay: (Conductor.stepCrochet / 1000) * 30});
        case 60:
        case 124:
            camFollowChars = true;
            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * (4));
        case 128: coolSineX = true; camZoomMult *= .97; glitchShader.glitchAmount = .6;
        case 512: camZoomMult *= .8; coolSineY = true; cloudSpeed = 1.6; coolSineMulti = 1.8; coolShit = true; glitchShader.glitchAmount = .8; 
        case 768: camZoomMult = 1; coolSineY = false; cloudSpeed = 1; coolSineMulti *= .8; coolShit = false; glitchShader.glitchAmount = .4; 
        case 1024: camZoomMult *= .6; coolSineY = true; cloudSpeed = 2.3; coolSineMulti *= 1.7; coolShit = arrowSinner = true; glitchShader.glitchAmount = 1.2; 
        case 1386: FlxTween.tween(stage.stageSprites["cloudScroll1"], {alpha: 0.05}, (Conductor.stepCrochet / 1000) * (1)); //so you can focus on bf when he falls incase clouds in the way
        case 1392: FlxTween.tween(stage.stageSprites["cloudScroll1"], {alpha: 1}, (Conductor.stepCrochet / 1000) * (3));
        case 1536:
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * (8));
        case 1544: camHUD.alpha = camGame.alpha = characterCam.alpha = 0;
    }

    if (step%4 == 0 && coolShit) cool();
}