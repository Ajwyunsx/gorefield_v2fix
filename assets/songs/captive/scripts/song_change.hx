importScript("data/scripts/VideoHandler");
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;

var distortionShader:CustomShader = null;
var blackScreen:FlxSprite;
var missText:FlxText;

var scareMeter:FlxText;

function create()
{
    missText = new FlxText(0, 0, 0, 
        FlxG.save.data.spanish ?
        "¡¡NO FALLES!!\n¡¡TIENES POCA VIDA!!" :
        "¡¡DON'T FAIL!!\n¡¡YOU HAVE LITTLE HEALTH!!");
    missText.setFormat("fonts/Harbinger_Caps.otf", 100, 0xFFFF4D00, "center");
    missText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 8, 50);
    missText.screenCenter();
    missText.scrollFactor.set();
    missText.alpha = 0;
    add(missText);

    scareMeter = new FlxText(0, camHUD.downscroll ? 612 : 618, 0,"S        c        a        r        e       -       O       -       M        e        t        e        r");
    scareMeter.setFormat("fonts/Harbinger_Caps.otf", 30, 0xFF8F0000, "center");
    scareMeter.screenCenter(FlxAxes.X);
    scareMeter.scrollFactor.set();
    scareMeter.cameras = [camHUD];

    VideoHandler.load(["CUTSCENE_1", "CAPTIVE_CINEMATIC_2"], false, function() {
        FlxG.camera.flash(0xff000000);
    });

    distortionShader = new CustomShader("chromaticWarp");
    distortionShader.distortion = 0;
    if (FlxG.save.data.warp) camGame.addShader(distortionShader);

    blackScreen = new FlxSprite().makeSolid(FlxG.width + 100, FlxG.height + 100, FlxColor.BLACK);
    blackScreen.alpha = 1;
    blackScreen.cameras = [camHUD];

    stage.stageSprites["RedOverlay"].active = stage.stageSprites["RedOverlay"].visible = true;
    stage.stageSprites["RedOverlay"].alpha = 0;
    stage.stageSprites["RedOverlay"].cameras = [camHUD];

    stage.stageSprites["Warning"].active = stage.stageSprites["Warning"].visible = true;
    stage.stageSprites["Warning"].alpha = 0;
    stage.stageSprites["Warning"].cameras = [camHUD];
}

function postCreate()
{
    for (spr in [gorefieldhealthBarBG, gorefieldhealthBar])
        remove(spr);

    for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, scareMeter])
        add(spr);

    for (spr in [gorefieldhealthBarBG, gorefieldhealthBar])
        spr.y += 10;

    add(blackScreen);
}

var boogie:Bool = false;
function stepHit(step:Int) 
{
    switch (step) {
        case 2:
            FlxTween.tween(blackScreen, {alpha: 0}, 1);
        case 432:
            FlxTween.tween(blackScreen, {alpha: 1}, 1);
        case 448:
            FlxTween.tween(blackScreen, {alpha: 0.35}, 1);
        case 703:
            VideoHandler.playNext();
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt, scareMeter])
                FlxTween.tween(spr, {alpha: 0}, 0.5);
        case 732:
            FlxTween.tween(blackScreen, {alpha: 1}, 1);
        case 1159:
            VideoHandler.playNext();
        case 576 | 771 | 1283:
            blackScreen.alpha = 0;
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt, scareMeter])
                spr.alpha = 1;
        case 1155:
            FlxTween.tween(camHUD, {alpha: 0}, 0.5);
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt, scareMeter])
                FlxTween.tween(spr, {alpha: 0}, 0.5);
        case 770:
            quitaVida = true;
            stage.stageSprites["BG1"].alpha = 0;
            stage.stageSprites["Entrada"].alpha = 1;
            stage.stageSprites["Suelo"].alpha = 1;
            stage.stageSprites["Barriles"].alpha = 1;

            stage.stageSprites["RedOverlay"].alpha = 0.15;
            FlxTween.tween(stage.stageSprites["RedOverlay"], {alpha: 0.35}, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.qaudInOut, type: 4});

            boyfriend.x -= 600;
            boyfriend.y -= 100;

            dad.scale.set(0.55, 0.55);
            dad.x += 100;
            dad.y -= 100;
            dad.color = 0x7F8CA9;

            gf.visible = true;
            cpuStrums.visible = false;
            for (playerStrum in playerStrums) playerStrum.x -= 640;
        case 772:
            boyfriend.cameraOffset.x += 450;
            boyfriend.cameraOffset.y += 150;
        case 1282:
            FlxTween.tween(camHUD, {alpha: 1}, 0.5);
            stage.stageSprites["RedOverlay"].visible = false;
            stage.stageSprites["Warning"].alpha = 1;
            stage.stageSprites["Rayo"].alpha = 1;

            camFollowChars = false;
            camFollow.setPosition(850, 550);

            boyfriend.x -= 400;
            boyfriend.y -= 100;
            gf.x -= 300;

            dad.visible = false;
            stage.stageSprites["Entrada"].alpha = 0;
            stage.stageSprites["Suelo"].alpha = 0;
            stage.stageSprites["Barriles"].alpha = 0;
            stage.stageSprites["BG3"].alpha = 1;
        case 1392:
            devControlBotplay = !(player.cpu = true);
            FlxTween.tween(camHUD, {alpha: 0}, 0.5);

            camFollowChars = true;
            gf.cameraOffset.x -= 150;
        case 1411:
            camFollowChars = false;
            camFollow.setPosition(850, 550);
        case 1415:
            devControlBotplay = !(player.cpu = false);
            FlxTween.tween(camHUD, {alpha: 1}, 0.25);
        case 1396:
            boogie = false;
        case 1412:
            boogie = true;
        case 1284:
            boogie = true;
            for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt, scareMeter])
                FlxTween.tween(spr, {alpha: 0}, 0.25);

            FlxTween.tween(missText, {alpha: 1}, 0.5, {startDelay: 1});
            FlxTween.tween(missText, {alpha: 0}, 1.25, {startDelay: 5});
        case 1538:
            boogie = false;
        case 1539:
            FlxTween.tween(blackScreen, {alpha: 1}, 0.5);
            FlxTween.tween(FlxG.camera, {zoom: 2}, 1, {ease: FlxEase.quadOut});
            FlxTween.num(1, 0, (Conductor.stepCrochet / 1000) * 4, {}, (val:Float) -> {distortionShader.distortion = val;});
    }

    if (boogie && step % 4 == 0) 
    {
        FlxTween.num(0, 1, 0.1, {}, (val:Float) -> {distortionShader.distortion = val;}); if (curStep > 1410) FlxTween.num(0, 2, 0.1, {}, (val:Float) -> {distortionShader.distortion = val;});
    }
}

function update() 
{
    for (spr in [gorefieldiconP1, gorefieldiconP2])
        spr.alpha = 0;
}

function onDadHit(event) if (curStep > 770) FlxG.camera.shake(0.007, 0.1); if (curStep > 1282) FlxG.camera.shake(0.015, 0.1);