//
var oldBfIndex:Int;

var drunkShader:CustomShader;
var bloom:CustomShader;
var staticShader:CustomShader;

var normalStrumPoses:Array<Array<Int>> = [];

function postCreate() {
    lerpCam = false;
    defaultCamZoom = 1.25;
    FlxG.camera.zoom = 1.25;

    stage.stageSprites["black"].active = stage.stageSprites["black"].visible = true;
    remove(stage.stageSprites["black"]);
    add(stage.stageSprites["black"]);
    camHUD.alpha = 0;

    stage.stageSprites["black_overlay"].visible = stage.stageSprites["black_overlay"].active = true;
	stage.stageSprites["black_overlay"].alpha = 0.25;

    oldBfIndex = members.indexOf(boyfriend);

    drunkShader = new CustomShader("drunk");
    drunkShader.time = 0; drunkShader.strength = 0;
    if (FlxG.save.data.drunk) stage.stageSprites["BG"].shader = drunkShader;

    bloom = new CustomShader("glow");
    bloom.size = 1.0; bloom.dim = 1.3;

    staticShader = new CustomShader("tvstatic");
	staticShader.time = 0; staticShader.strength = 0.6;
	staticShader.speed = 20;
	if (FlxG.save.data.static1) FlxG.camera.addShader(staticShader);

    for (i=>strum in strumLines.members) {
        normalStrumPoses[i] = [for (s in strum.members) s.y];

        for (char in strum.characters) {
			var newShader = new CustomShader("wrath");
            newShader.uDirection = 0.;
			newShader.uOverlayOpacity = 0;
			newShader.uDistance = 0.;
			newShader.uChoke = 0.;
			newShader.uPower = .0;
		
			newShader.uShadeColor = [237 / 255, 238 / 255, 255 / 255];
			newShader.uOverlayColor = [21 / 255, 19 / 255, 63 / 255];
            
			var uv = char.frame.uv;
			newShader.applyRect = [uv.x, uv.y, uv.width, uv.height];

			char.forceIsOnScreen = true;
			if (FlxG.save.data.wrath) char.shader = newShader;
		}
    }
}

function draw(e) {
	for (strum in strumLines)
		for (char in strum.characters) {
			if (char.shader == null) continue;

			var uv = char.frame.uv;
			char.shader.applyRect = [uv.x, uv.y, uv.width, uv.height];
		}
}

var cool:Bool = false;
function superCool(turnOn:Bool, steps:Int) {
    cool = turnOn;
    tweenHealthBar(turnOn ? 0 : 1, (Conductor.stepCrochet / 1000) * steps);
    FlxTween.tween(psBar, {alpha: turnOn ? 0 : 1}, (Conductor.stepCrochet / 1000) * steps);

    FlxTween.tween(stage.stageSprites["light"], {alpha: turnOn ? 0.3 : 1}, (Conductor.stepCrochet / 1000) * steps);

    FlxTween.num(!turnOn ? .8 : .0, turnOn ? .8 : .0, (Conductor.stepCrochet / 1000) * steps, {}, (val:Float) -> {drunkShader.strength = val;});
    FlxTween.color(stage.stageSprites["BG"], (Conductor.stepCrochet / 1000) * steps * .5, turnOn ? 0xFFFFFFFF : 0xFF31333D, !turnOn ? 0xFFFFFFFF : 0xFF31333D);
    for (strum in strumLines)
		for (char in strum.characters) {
			if (char.shader == null) continue;
            FlxTween.num(!turnOn ? 0.8 : .0, turnOn ? .8 : .0, (Conductor.stepCrochet / 1000) * steps, {}, (val:Float) -> {char.shader.uOverlayOpacity = val;});
            FlxTween.num(!turnOn ? 21. : .0, turnOn ? 21. : .0, (Conductor.stepCrochet / 1000) * steps, {}, (val:Float) -> {char.shader.uDistance = val;});
            FlxTween.num(!turnOn ? 10. : .0, turnOn ? 10. : .0, (Conductor.stepCrochet / 1000) * steps, {}, (val:Float) -> {char.shader.uChoke = val;});
            FlxTween.num(!turnOn ? 1.0 : .0, turnOn ? 1.0 : .0, (Conductor.stepCrochet / 1000) * steps, {}, (val:Float) -> {char.shader.uPower = val;});
		}
}

function tweenHUD2(a:Float, time:Float){ //hi psbar (hi -psbar)
    tweenHUD(a,time);
    FlxTween.tween(psBar,{alpha: a},time);
}

var tottalTime:Float = 0;
var coolSineX:Bool = false;
var coolSineY:Bool = false;
var coolSineBump:Bool = false;
var arrowSine:Bool = false;
function update(elapsed:Float) {
    tottalTime += elapsed;
    drunkShader.time = tottalTime;
    staticShader.time = tottalTime;

    gf.x = 755 + FlxG.random.float(-1.2, 1.2);
    gf.y = 285 + FlxG.random.float(-1.2, 1.2);

    camHUD.angle = lerp(camHUD.angle, coolSineY ? 2*FlxMath.fastSin(tottalTime*2) : 0, 0.25);
    camHUD.y = lerp(camHUD.y, coolSineY ? FlxMath.fastSin(tottalTime + Math.PI*2)*6 : 0, 0.25);
    camHUD.x = lerp(camHUD.x, coolSineX ? FlxMath.fastCos(tottalTime*2 + Math.PI*2)*12 : 0, 0.25);

    for (i => strumLine in strumLines.members)
        for (k=>s in strumLine.members) s.y = lerp(s.y, arrowSine ? normalStrumPoses[i][k] + (16*FlxMath.fastSin((tottalTime*4) + ((Conductor.stepCrochet / 1000) * k * 4))) : normalStrumPoses[i][k], .25);
}

function stepHit(step:Int){
    switch (step){
        case 0:
            FlxG.camera.shake(0.004, 999999);
            tweenHUD(0,0.0001);
            camHUD.alpha = 1; psBar.alpha = tottalTime = 0;

            FlxTween.tween(stage.stageSprites["black_overlay"], {alpha: .8}, (Conductor.stepCrochet / 1000) * 97);
            FlxTween.tween(stage.stageSprites["black"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 78, {startDelay: (Conductor.stepCrochet / 1000) * 20});
            FlxTween.tween(FlxG.camera, {zoom: 0.8}, (Conductor.stepCrochet / 1000) * 124, {onComplete: function (tween:FlxTween) {
                defaultCamZoom = 0.8; 
                lerpCam = true;
                tweenHUD2(1,(Conductor.stepCrochet / 1000) * 2);
                FlxTween.tween(stage.stageSprites["black_overlay"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 12);
            }});
        case 124:
            FlxTween.num(.6, 0, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {staticShader.strength = val;}); FlxG.camera.stopFX();
        case 268: 
            tweenHUD2(0,(Conductor.stepCrochet / 1000) * 4);
        case 272:
            remove(stage.stageSprites["black"]);
            insert(members.indexOf(dad),stage.stageSprites["black"]);
            remove(boyfriend);
            insert(members.indexOf(stage.stageSprites["black"]) - 1,boyfriend);

            FlxTween.num(.0, 1.3, (Conductor.stepCrochet / 1000) * 16, {}, (val:Float) -> {staticShader.strength = val;});

            FlxTween.tween(stage.stageSprites["black"], {alpha: 0.58}, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quadOut});
        case 287: tweenHUD2(1,(Conductor.stepCrochet / 1000) * 1);
        case 288: 
            remove(boyfriend);
            insert(oldBfIndex,boyfriend);

            FlxTween.tween(stage.stageSprites["black"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 1, {ease: FlxEase.quadOut});
            FlxTween.num(1.3, .0, (Conductor.stepCrochet / 1000) * 1, {}, (val:Float) -> {staticShader.strength = val;});
        case 672:
            FlxTween.num(.0, .8, (Conductor.stepCrochet / 1000) * 24, {}, (val:Float) -> {staticShader.strength = val;});
            FlxTween.tween(stage.stageSprites["black_overlay"], {alpha: .6}, (Conductor.stepCrochet / 1000) * 6);
            FlxTween.tween(stage.stageSprites["black"], {alpha: 0.5}, (Conductor.stepCrochet / 1000) * 6);
            boyfriend.cameraOffset.y += 30;
            coolSineX = true;
        case 928:
            if (FlxG.save.data.bloom) FlxG.camera.addShader(bloom);
            FlxTween.num(1, 8, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.size = val;});

            superCool(true, (Conductor.stepCrochet / 1000) * 24);
            boyfriend.cameraOffset.y += 30;
            arrowSine = true;

        case 1052:
            superCool(false, (Conductor.stepCrochet / 1000) * 8);
            boyfriend.cameraOffset.y -= 60; cool = true; // just cause

        case 1056: coolSineY = coolSineBump = true;
        case 1320:
            camGame.visible = coolSineBump = false;
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt, psBar, psBarTrail]) spr.visible = false;
    }

    if (step % 4 == 0 && coolSineBump) {
        camHUD.x += FlxG.random.float(80, 180) * (step % 8 >= 4 ? 1 : -1);
        camHUD.zoom -= FlxG.random.float(.1, .3);
        FlxG.camera.zoom += FlxG.random.float(.1, .3);
    }
}

function onPlayerHit(event) {
    if (!cool) return;
    event.showRating = false; songScore += event.score;
}
