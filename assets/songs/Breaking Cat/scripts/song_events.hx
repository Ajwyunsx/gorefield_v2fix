function create()
{
    comboGroup.x += 320;
    comboGroup.y += 300;
}

function stepHit(step:Int){
    switch(step){
        case 0:
            FlxTween.tween(stage.stageSprites["black"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 40);
        case 1624:
            stage.stageSprites["jesseBG2"].alpha = 1;
            stage.stageSprites["jesseBG"].visible = stage.stageSprites["jesseBG"].active = false;
    }
}

var totalTime:Float = 0;
function update(elapsed) {
    totalTime += elapsed;

    for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2]) {
        if (spr == null) continue;
        spr.alpha = 0;
    }
}