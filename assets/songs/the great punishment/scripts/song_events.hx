import flixel.text.FlxTextBorderStyle;

var finalPos:Array<Float> = [];
var dadPos:Array<Float> = [];

var enteringSinner:Bool = true;
var lerpGorefield:Bool = false;

var wrathSprites:Array<FlxSprite> = [];
var bloom:CustomShader;
var staticShader:CustomShader;
var redOverlay:FlxSprite;

var bulletsText:FlxText;

function create(){
    endTime = (Conductor.stepCrochet / 1000) * 16;

    finalPos = [dad.x, dad.y];
    dadPos = [dad.x += -1350, dad.y += 20]; 

    var bg:FlxSprite = stage.stageSprites["BG1"];
    FlxG.camera.setScrollBoundsRect(bg.x+20, bg.y, bg.width-20, bg.height, false);

    bloom = new CustomShader("glow");
    bloom.size = 8.0;// trailBloom.quality = 8.0;
    bloom.dim = 1.7;// trailBloom.directions = 16.0;
    if (FlxG.save.data.bloom) FlxG.camera.addShader(bloom);

    staticShader = new CustomShader("tvstatic");
	staticShader.time = 0; staticShader.strength = 0.1;
	staticShader.speed = 20;
	if (FlxG.save.data.static) FlxG.camera.addShader(staticShader);

    stage.stageSprites["black"].visible = stage.stageSprites["black"].active = true;
    camHUD.alpha = 0;

    boyfriend.cameraOffset.x -= 200;
    boyfriend.cameraOffset.x += 100;

    redOverlay = stage.stageSprites["red_overlay"];

    bulletsText = new FunkinText(finalPos[0] + 300, finalPos[1] + 560, 0, "BULLETS DON'T WORK, JON...", 42, true);
	bulletsText.setFormat("fonts/pixelart.ttf", 32, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	bulletsText.borderSize = 4; bulletsText.alpha = 0;
    insert(members.indexOf(redOverlay)-1, bulletsText);
}

var doHealthLerp:Bool = true;
var endTime:Float = 0;
var tottalTime:Float = 0;
function update(elapsed:Float) {
    tottalTime += elapsed/1000;
    staticShader.time = tottalTime*1000;

    if (lerpGorefield) {
        dad.setPosition(
            dadPos[0] = lerp(dadPos[0], finalPos[0], (tottalTime*2)/endTime),
            dadPos[1] = lerp(dadPos[1], finalPos[1], (tottalTime*2)/endTime)
        );

        dad.x += (Math.floor(FlxMath.fastSin((tottalTime*100) * (enteringSinner ? 12 : 6)) * 8) * 6);
        dad.y += (Math.floor(FlxMath.fastCos((tottalTime*140) * (enteringSinner ? 12 : 6)) * 8) * (enteringSinner ? 4 : 2));

        dad.x += FlxG.random.float(-2.5, 2.5);
        dad.y += FlxG.random.float(-2.5, 2.5);
    }

    bulletsText.setPosition(
        finalPos[0] + 380 + FlxG.random.float(-3, 3), 
        finalPos[1] + 470 + FlxG.random.float(-3, 3)
    );
    redOverlay.alpha = lerp(redOverlay.alpha, 0, 1/40);


    if (!doHealthLerp) return;
    var curHealthAlpha = lerp(gorefieldhealthBarBG.alpha, curCameraTarget == 1 ? 0.15 : 1, 1/20);
    for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
        spr.alpha = curHealthAlpha;
}

function stepHit(step:Int) {
    switch (step) {
        case 0:
            lerpCam = false; FlxG.camera.zoom = 1.7;
            FlxTween.tween(stage.stageSprites["black"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 112);

            FlxTween.tween(FlxG.camera, {zoom: 1.4}, (Conductor.stepCrochet / 1000) * 112);
            FlxG.camera.shake(0.0015, 999999);
        case 64: lerpGorefield = true; tottalTime = 0;
        //case 78: 
            //FlxTween.color(dad, (Conductor.stepCrochet / 1000) * 48, 0xFF20251F, 0xFF92B8A3);
        case 112:
            FlxTween.cancelTweensOf(FlxG.camera); 
            lerpCam = true; FlxG.camera.stopFX();

            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * 16);

        case 140: enteringSinner = false;
        case 1136: 
            FlxTween.tween(bulletsText, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
            FlxTween.tween(bulletsText.offset, {x: -40}, (Conductor.stepCrochet / 1000) * 8);

            bulletsText.text = "BULLETS"; doHealthLerp = false;
            tweenHUD(0, (Conductor.stepCrochet / 1000) * 4); 
            FlxTween.tween(stage.stageSprites["black_overlay"], {alpha: 0.95}, (Conductor.stepCrochet / 1000) * 4);
        case 1144: 
            bulletsText.text = "BULLETS DON'T"; 
        case 1148: 
            bulletsText.text = "BULLETS DON'T WORK,"; 
            tweenHUD(1, (Conductor.stepCrochet / 1000) * 4); doHealthLerp = true;
        case 1152: 
            bulletsText.text = "BULLETS DON'T WORK, JON..."; 
            FlxTween.tween(bulletsText, {alpha: 0}, (Conductor.stepCrochet / 1000) * 4);
            FlxTween.tween(stage.stageSprites["black_overlay"], {alpha: 0.75}, (Conductor.stepCrochet / 1000) * 4);
            FlxTween.tween(bulletsText.offset, {y: -30}, (Conductor.stepCrochet / 1000) * 8);
        case 1288: FlxG.camera.visible = camHUD.visible = false;
    }
}

function shoot() {FlxG.camera.shake(0.02, 0.3); camHUD.shake(0.01, 0.3); redOverlay.alpha = 1;}
function onPlayerHit(event) {event.showRating = false; songScore += event.score;}