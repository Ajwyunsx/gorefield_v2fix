var preloadedIcons:Map<String, FlxSprite> = [];

function postCreate() 
{
    camFollowChars = false; camFollow.setPosition(1480, 850);
    snapCam();

    for (strum in strumLines) 
        for (char in strum.characters)
            if (char.curCharacter == "jon-cc") {
                char.x += 450;
                char.y -= 530;
            }

    for (strum in strumLines) 
        for (char in strum.characters)
            if (char.curCharacter == "cartoonfield") {
                char.x += 1920;
                char.y += 230;
            }

    camHUD.alpha = 0.00001;
    FlxG.camera.zoom = defaultCamZoom = 1.6;
    zoomDisabled = true;

    preloadedIcons.set(dad.getIcon(), gorefieldiconP2);
    preloadedIcons.set(boyfriend.getIcon(), gorefieldiconP1);

    for (strum in strumLines) 
        for (char in strum.characters)
            switch(char.curCharacter){
                case 'cartoonfield' | 'jon-cc':
                    var newIcon = createIcon(char);
                    newIcon.active = newIcon.visible = false;
                    newIcon.drawComplex(FlxG.camera);
                    preloadedIcons.set(char.getIcon(), newIcon);
            }
}

function updateIconShit(name:String,updateBF:Bool){
    var oldIcon = updateBF ? gorefieldiconP1 : gorefieldiconP2;
    var newIcon = preloadedIcons.get(name);

    if (oldIcon == newIcon) return;

    insert(members.indexOf(oldIcon), newIcon);
    newIcon.active = newIcon.visible = true;
    remove(oldIcon);
    if (updateBF) gorefieldiconP1 = newIcon;
    else gorefieldiconP2 = newIcon;


    newIcon.alpha = oldIcon.alpha;
    updateIcons(); 
}

function stepHit(step:Int){
    switch(step){
        case 0:
            FlxTween.tween(stage.stageSprites["black"],{alpha: 0}, (Conductor.stepCrochet / 1000) * 128, {ease: FlxEase.cubeIn});
            FlxTween.tween(FlxG.camera,{zoom: 1}, (Conductor.stepCrochet / 1000) * 127, {onComplete: function(twn){
                defaultCamZoom = 1;
                zoomDisabled = false;
            }});
            tweenHealthBar(0.2,0.00001);
        case 1:
            gorefieldiconP2.alpha = 0.0001;
        case 114:
            FlxTween.tween(camHUD,{alpha: 1}, (Conductor.stepCrochet / 1000) * 12, {ease: FlxEase.cubeIn});
        case 192 | 320 | 704 | 1216:
            updateIconShit('John_icons',true);

            if (step == 1216)
                updateIconShit('CC_Icons',false);    
        case 256 | 512 | 832 | 1344:
            updateIconShit('Luna_icons',true);     

            if (step == 1344)
                updateIconShit('CARTOON_GOREFIELD',false);    
        case 640:
            updateIconShit('CC_Icons',false);    
        case 768:
            updateIconShit('CARTOON_GOREFIELD',false);                    
        case 376 | 1144:
            updateIconShit('CARTOON_GOREFIELD',false);
            camFollow.setPosition(1500, 750);
            defaultCamZoom = 0.48;
            FlxTween.tween(stage.stageSprites["black_overlay"],{zoomFactor: -4}, (Conductor.stepCrochet / 1000) * 12, {ease: FlxEase.cubeInOut});
            tweenHealthBar(1,(Conductor.stepCrochet / 1000) * 12);

            if(step == 1144){
                for (strum in strumLines) 
                    for (char in strum.characters){
                        if (char.curCharacter == "jon-cc") {
                            for (strumNote in strum.members)
                                FlxTween.tween(strumNote,{alpha: 1}, (Conductor.stepCrochet / 1000) * 12, {ease: FlxEase.cubeOut});
                        }
                        if (char.curCharacter == "luna-angry") {
                            for (strumNote in strum.members)
                                FlxTween.tween(strumNote,{x: strumNote.x - 325}, (Conductor.stepCrochet / 1000) * 12, {ease: FlxEase.cubeOut});
                        }
                    }
            }
        case 896 | 1408:
            if(step == 896){
                updateIconShit('CC_Icons',false);
            }
            camFollow.setPosition(step == 1408 ? 1450 : 950, 830);
            FlxTween.tween(stage.stageSprites["black_overlay"],{zoomFactor: -0.5}, (Conductor.stepCrochet / 1000) * 12, {ease: FlxEase.cubeInOut});
            defaultCamZoom = 0.7;   
            tweenHealthBar(0.2,(Conductor.stepCrochet / 1000) * 12);

            for (strum in strumLines) 
                for (char in strum.characters){
                    if (char.curCharacter == "luna-angry") {
                        for (strumNote in strum.members)
                            FlxTween.tween(strumNote,{x: strumNote.x + 325}, (Conductor.stepCrochet / 1000) * 12, {ease: FlxEase.cubeOut});
                    }

                    if (char.curCharacter == "jon-cc") {
                        for (strumNote in strum.members)
                            FlxTween.tween(strumNote,{alpha: 0}, (Conductor.stepCrochet / 1000) * 12, {ease: FlxEase.cubeOut});
                    }
                }
        case 1472:
            defaultCamZoom = 0.8;   
            camFollow.setPosition(2070, 830);
        case 1536:
            camHUD.alpha = 0;
            stage.stageSprites["black_overlay"].zoomFactor = 0;
            FlxTween.tween(stage.stageSprites["black"],{alpha: 1}, (Conductor.stepCrochet / 1000) * 24, {ease: FlxEase.cubeOut, starDelay: (Conductor.stepCrochet / 1000) * 4});
    }
}