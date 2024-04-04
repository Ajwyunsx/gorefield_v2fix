import funkin.game.PlayState;

importScript("data/scripts/VideoHandler");

var dodgeCat:Character;

function postCreate() 
{
	VideoHandler.load(["somethingisComming"], false);

	tweenHUD(0,0.01);
}

function create()
{
	dodgeCat = new Character(-335, -200, "dodge-lasagna-cat");
	dodgeCat.visible = dodgeCat.active = false;
	dodgeCat.danceOnBeat = true; dodgeCat.danceInterval = 0;
	dodgeCat.playAnim('idle', true);
	add(dodgeCat);

	stage.stageSprites["lasagnaCat"].color = 0xFF000000;
	stage.stageSprites["lasagnaCat"].colorTransform.color = 0xFF527F3A;
	stage.stageSprites["lasagnaCat"].drawComplex(FlxG.camera);
	
	stage.stageSprites["nonblack"].active = stage.stageSprites["nonblack"].visible = true;
}

function stepHit(step:Int) 
{
    switch (step) 
    {
        case 0:
			FlxTween.tween(stage.stageSprites["nonblack"], {alpha: 0}, (Conductor.stepCrochet / 1000) * 140);
			maxCamZoom = 0;
		case 128:
			defaultCamZoom += 0.5;
			dad.cameraOffset.x -= 270;
			dad.cameraOffset.y += 100;
			boyfriend.cameraOffset.x += 270;
			boyfriend.cameraOffset.y += 100;
		case 138:
			zoomDisabled = true;
			FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.4}, (Conductor.stepCrochet / 1000) * 113, {ease: FlxEase.linear});
		case 252:
			zoomDisabled = false;
			defaultCamZoom -= 0.5;
			dad.cameraOffset.x += 270;
			dad.cameraOffset.y -= 100;
			boyfriend.cameraOffset.x -= 270;
			boyfriend.cameraOffset.y -= 100;
			tweenHUD(1,(Conductor.stepCrochet / 1000) * 4);
		case 1024:
			var itsFinished:Bool = false;
			function fadeShit(alpha:Float) {
				for (strumLine in strumLines)
					for (strum in strumLine.members)
						FlxTween.tween(strum, {alpha: alpha}, (Conductor.stepCrochet / 1000) * 4);
				for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
					FlxTween.tween(spr, {alpha: alpha}, (Conductor.stepCrochet / 1000) * 4);
			}

			stage.stageSprites["lasagnaCat"].animation.play('run', true);
			stage.stageSprites["lasagnaCat"].visible = true;
			
			stage.stageSprites["lasagnaCat"].animation.finishCallback = function () {
				if (itsFinished) return;
				
				stage.stageSprites["lasagnaCat"].visible = false;
				fadeShit(1);
				itsFinished = true;
			};
			fadeShit(0);
		case 1035:
			VideoHandler.playNext();
		case 1056:
			dodgeCat.visible = dodgeCat.active = true;
			dodgeCat.playAnim("enter", true);
		case 1104 | 1112 | 1168 | 1176 | 1232 | 1240 | 1296 | 1304:
			camHUD.angle -= 10;
			camGame.angle -= 3.5;
			camHUD.y += 5;
			FlxTween.tween(camHUD, {angle: 0, y: 0}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.quadOut});
			FlxTween.tween(camGame, {angle: 0}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.quadOut});

			dodgeCat.playAnim('attack', true);
		case 1108 | 1116 | 1172 | 1180 | 1236 | 1244 | 1300 | 1308:
			camHUD.angle += 10;
			camGame.angle += 3.5;
			camHUD.y -= 5;
			FlxTween.tween(camHUD, {angle: 0, y: 0}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.quadOut});
			FlxTween.tween(camGame, {angle: 0}, (Conductor.stepCrochet / 1000) * 4, {ease: FlxEase.quadOut});

			dodgeCat.playAnim('attack', true);
		case 1312:
			dodgeCat.playAnim('scape', true);
			dodgeCat.animation.finishCallback = (name:String) -> {if (name == 'scape') dodgeCat.visible = false;};
		case 1568:
			stage.stageSprites["nonblack"].alpha = 0;
            FlxTween.tween(stage.stageSprites["nonblack"], {alpha: 1}, (Conductor.stepCrochet / 1000) * 4);
		case 1587:
			tweenHUD(0,(Conductor.stepCrochet / 1000) * 4);
    }
}

function onStrumCreation(_) _.__doAnimation = false;