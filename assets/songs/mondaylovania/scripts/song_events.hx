//
import flixel.addons.effects.FlxTrail;
import funkin.backend.utils.FlxInterpolateColor;

var bloom:CustomShader = null;
var distortionShader:CustomShader = null;

var normalStrumPoses:Array<Array<Int>> = [];
var dadTrail:FlxTrail;
var bfTrail:FlxTrail;

var bones:FlxSprite;
var boneColor:FlxInterpolateColor;

var overlay:FlxSprite;

function create() {
    gf.visible = gf.active = boyfriend.visible = false;
    gf.drawComplex(FlxG.camera); // Gpu bla bla
    dad.forceIsOnScreen = true;

    bloom = new CustomShader("glow");
    bloom.size = 0; bloom.dim = 2.5;
    if (FlxG.save.data.bloom) FlxG.game.addShader(bloom);

    distortionShader = new CustomShader("chromaticWarp");
    distortionShader.distortion = 0;
    if (FlxG.save.data.warp) FlxG.game.addShader(distortionShader);

    dad.cameraOffset.y += 90;

    dadTrail = new FlxTrail(dad, null, 6, 16, 0.3, 0.069);
    dadTrail.beforeCache = dad.beforeTrailCache;
    dadTrail.afterCache = () -> {dad.afterTrailCache();}
    dadTrail.visible = false;
    if (FlxG.save.data.trails) insert(members.indexOf(dad), dadTrail);

    bfTrail = new FlxTrail(boyfriend, null, 6, 16, 0.45, 0.069);
    bfTrail.beforeCache = dad.beforeTrailCache;
    bfTrail.afterCache = () -> {dad.afterTrailCache();}
    bfTrail.visible = false;
    if (FlxG.save.data.trails) insert(members.indexOf(boyfriend), bfTrail);

    bones = stage.stageSprites["sansFieldBones"];
    boneColor = new FlxInterpolateColor(0xFFFFFFFF);

    overlay = stage.stageSprites["overlay"];
    overlay.alpha = 0;
}

function postCreate() {
    for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt]) spr.alpha = 0;
    for (strum in player.members) strum.alpha = 0;
    for (spr in stage.stageSprites) spr.alpha = 0;
    dad.alpha = camHUD.alpha = 0;

    for (i=>strum in strumLines.members)
        normalStrumPoses[i] = [for (i=>s in strum.members) s.y];
}

var coolSineMulti:Float = 1;
var coolSineX:Bool = false;
var coolSineY:Bool = false;
var coolDadTrail:Bool = false;
var coolBfTrail:Bool = false;
var tottalTime:Float = 0;
function update(elapsed:Float) {
    tottalTime += elapsed;
    camHUD.angle = lerp(camHUD.angle, coolSineY ? (3* coolSineMulti)*FlxMath.fastSin(tottalTime*2) : 0, 0.25);
    camHUD.y = lerp(camHUD.y, coolSineY ? FlxMath.fastSin(tottalTime*1.6 + Math.PI*2)*(9*coolSineMulti) : 0, 0.25);
    camHUD.x = lerp(camHUD.x, coolSineX ? FlxMath.fastCos(tottalTime*2 + Math.PI*2)*(12*coolSineMulti) : 0, 0.25);

    var _curBeat:Float = ((Conductor.songPosition / 1000) * (Conductor.bpm / 60));
    for (i=>trail in dadTrail.members) {
        var scale = !coolDadTrail ? 1 : FlxMath.bound(1 + (.16 * FlxMath.fastSin(_curBeat + (i * FlxG.random.float((Conductor.stepCrochet / 1000) * 1, (Conductor.stepCrochet / 1000) * 1.2)))), 0., 999);
        trail.scale.set(scale, scale);
        trail.color = switch (dad.animation.name) {
            case "singLEFT-alt": 0xFFC24B99;
            case "singDOWN-alt": 0xFF00FFFF;
            case "singUP-alt": 0xFF12FA05;
            case "singRIGHT-alt": 0xFFF9393F;
            default: 0xFFFFFFFF;
        }
    }

    boneColor.fpsLerpTo(switch (dad.animation.name) {
        case "singLEFT-alt": 0xFFF122A9;
        case "singDOWN-alt": 0xFF00FFFF;
        case "singUP-alt": 0xFF12FA05;
        case "singRIGHT-alt": 0xFFF9393F;
        default: 0xFFFFFFFF;
    }, 1/10);
    bones.color = boneColor.color;

    overlay.color = switch ((curCameraTarget == 1 ? boyfriend : dad).animation.name) {
        case "singLEFT-alt": 0xFFFF00A6;
        case "singDOWN-alt": 0xFF3AF7F7;
        case "singUP-alt": 0xFF22F217;
        case "singRIGHT-alt": 0xFFFF141C;
        default: 0xFFFFFFFF;
    };

    for (i=>trail in bfTrail.members) {
        var scale = !coolBfTrail ? 1 : FlxMath.bound(1 + (.16 * FlxMath.fastSin(_curBeat + (i * FlxG.random.float((Conductor.stepCrochet / 1000) * 1, (Conductor.stepCrochet / 1000) * 1.2)))), 0., 999);
        trail.scale.set(scale, scale);
        trail.color = switch (boyfriend.animation.name) {
            case "singLEFT-alt": 0xFFC24B99;
            case "singDOWN-alt": 0xFF00FFFF;
            case "singUP-alt": 0xFF12FA05;
            case "singRIGHT-alt": 0xFFF9393F;
            default: 0xFFFFFFFF;
        }
    }
}

function stepHit(step:Int) {
    switch (step){
        case 16 | 20 | 24 | 28: 
            FlxTween.tween(dad, {alpha: dad.alpha + 0.25}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.qaudInOut});
            if (step == 28) dad.cameraOffset.y -= 90;
        case 32:
            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
        case 96:
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
                FlxTween.tween(spr, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
            for (spr in stage.stageSprites) FlxTween.tween(spr, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
            for (spr in player.members) FlxTween.tween(spr, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
            boyfriend.visible = dadTrail.visible = true;

            FlxTween.num(2.5, 2.1, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.dim = val;});
            FlxTween.num(0, 8, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.size = val;});
            FlxTween.num(0, .25, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {distortionShader.distortion = val;});
        case 104 | 120 | 136 | 232 | 248 | 264:
            FlxTween.num(.25, .6 + FlxG.random.float(-0.2, .2), (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.qaudIn}, (val:Float) -> {distortionShader.distortion = val;});
        case 112 | 128 | 152 | 240 | 256 | 280:
            FlxTween.num(1, .25, (Conductor.stepCrochet / 1000) * 6, {ease: FlxEase.qaudOut}, (val:Float) -> {distortionShader.distortion = val;});
        case 160:
            FlxTween.num(2.1, 2.5, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.dim = val;});
            FlxTween.num(8, 0, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.size = val;});
            FlxTween.num(.25, .1, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {distortionShader.distortion = val;});
            dadTrail.visible = false;
        case 224:
            boyfriend.cameraOffset.x += 80; boyfriend.cameraOffset.y += 90; bfTrail.visible = true;
            FlxTween.num(2.5, 2.1, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.dim = val;});
            FlxTween.num(0, 8, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.size = val;});
            FlxTween.num(.25, .75, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {distortionShader.distortion = val;});
        case 288:
            boyfriend.cameraOffset.x -= 80; boyfriend.cameraOffset.y -= 90; bfTrail.visible = false;
            FlxTween.num(2.1, 2.5, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.dim = val;});
            FlxTween.num(8, 0, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.size = val;});
            FlxTween.num(.75, .1, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {distortionShader.distortion = val;});
        case 416: dadTrail.visible = bfTrail.visible = true;
        case 672:
            dadTrail.visible = bfTrail.visible = false;
            camZoomMult = 0.7; coolSineY = coolSineX = true; coolSineMulti = 1.2;
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
                FlxTween.tween(spr, {alpha: 0}, (Conductor.stepCrochet / 1000) * 8);

            FlxTween.num(2.5, 2.4, (Conductor.stepCrochet / 1000) * 8, {}, (val:Float) -> {bloom.dim = val;});
            FlxTween.num(0, 10, (Conductor.stepCrochet / 1000) * 8, {}, (val:Float) -> {bloom.size = val;});
            
            dad.cameraOffset.y += 180;

            for (strumLine in strumLines) 
                for (strum in strumLine.members) FlxTween.tween(strum, {y: strum.y-80}, (Conductor.stepCrochet / 1000) * 8);
        case 802: dad.cameraOffset.y += 180; camMoveOffset = 0;
        case 896: 
            camZoomMult = 1; coolSineY = coolSineX = false; camMoveOffset = 15;
            for (strumLine in strumLines) 
                for (strum in strumLine.members) FlxTween.tween(strum, {y: strum.y+80}, (Conductor.stepCrochet / 1000) * 4);
        case 928: FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 24); dad.cameraOffset.y -= 180;
        case 1052: 
            FlxTween.num(2.4, 2.5, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.dim = val;});
            FlxTween.num(10, 0, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {bloom.size = val;});

            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4); dad.cameraOffset.y -= 180;
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
                FlxTween.tween(spr, {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
        case 1172:
            devControlBotplay = !(player.cpu = dadTrail.visible = true);

            tweenHealthBar(0, (Conductor.stepCrochet / 1000) * 4);
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 4);
        case 1176:
            coolSineY = coolSineX = true; coolSineMulti = 1.4; camZoomMult = 0.9;
            for (strum in cpu) strum.visible = false;
            for (note in cpu.notes.members) note.visible = false;

            FlxTween.num(2.5, 2, (Conductor.stepCrochet / 1000) * 16, {}, (val:Float) -> {bloom.dim = val;});
            FlxTween.num(0, 12, (Conductor.stepCrochet / 1000) * 16, {}, (val:Float) -> {bloom.size = val;});
        case 1172: coolDadTrail = dadTrail.visible = true;
        case 1184: 
            for (i => trail in dadTrail.members) FlxTween.tween(trail, {alpha: 0.55}, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.qaudInOut}); 
            dadTrail.delay = 12; coolDadTrail = true; 
    
            for (i => trail in bfTrail.members) FlxTween.tween(trail, {alpha: 1}, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.qaudInOut}); 
            bfTrail.visible = true; bfTrail.delay = 12; coolBfTrail = true; 

            FlxTween.tween(overlay, {alpha: 1}, (Conductor.stepCrochet / 1000) * 64); 
            overlay.visible = overlay.active = true;
            FlxTween.tween(camHUD, {alpha: 1}, (Conductor.stepCrochet / 1000) * 16);

            for (i=>strum in player.members)
                FlxTween.tween(strum, {x: cpu.members[i].x}, (Conductor.stepCrochet / 1000) * 14, {ease: FlxEase.circInOut, startDelay: (Conductor.stepCrochet / 2000) * i});
        case 1200: devControlBotplay = !(player.cpu = false);
        case 1210: boyfriend.cameraOffset.x += 80; boyfriend.cameraOffset.y += 90;
        case 1304:
            gf.visible = gf.active = true;
            gf.alpha = 0.00001; //so the camera can actually focus while still hidden because apparently you need the character visible for it to actually focus
        case 1308: FlxTween.tween(overlay, {alpha: 0}, (Conductor.stepCrochet / 1000) * 4); 
        case 1312: 
            tweenHUD(0, (Conductor.stepCrochet / 1000) * 12); gf.alpha = 1;
            for (i=>strum in player.members)
                FlxTween.tween(strum, {x: strum.x - 2600 - (600*(3-i))}, (Conductor.stepCrochet / 1000) * 6, {ease: FlxEase.circIn, startDelay: (Conductor.stepCrochet / 2000) * i});
        case 1324: bfTrail.visible = false;
        case 1376: 
            boyfriend.cameraOffset.x -= 80; boyfriend.cameraOffset.y -= 90;
            stage.stageSprites["sansFieldBones"].active = stage.stageSprites["sansFieldBones"].visible = false; coolDadTrail = dadTrail.visible = false;
            dad.y -= 88; dad.cameraOffset.y += 240; dad.cameraOffset.x -= 29;
        case 1440: 
            FlxTween.tween(camHUD, {alpha: 0}, (Conductor.stepCrochet / 1000) * 16);
            FlxTween.tween(FlxG.camera, {zoom: .7}, (Conductor.stepCrochet / 1000) * (16*4), {ease: FlxEase.circOut, onComplete: function (tween:FlxTween) {defaultCamZoom = 1.2; lerpCam = true;}});
        case 1448: 
            stage.stageSprites["white"].active = stage.stageSprites["white"].visible = true;
            stage.stageSprites["white"].alpha = 0; 

            FlxTween.tween(stage.stageSprites["white"], {alpha: 1}, (Conductor.stepCrochet / 1000) * 56, {ease: FlxEase.circIn});
        case 1508: camHUD.visible = camGame.visible = false;
    }
}

function onStrumCreation(_) _.__doAnimation = false;
function destroy() {FlxG.game.setFilters([]);}