public var controlHealthAlpha:Bool = true;
public var curHealthAlpha:Float = 1;

var bg:FlxSprite;
function create() {
    controlHealthAlpha = boyfriend.forceIsOnScreen = true; boyfriend.zoomFactor = 0.8;
    //FlxG.camera.bgColor = 0xFFADABAB;

    gameOverSong = "gameOvers/ultrafield/ultrafieldLOOP";
	retrySFX = "gameOvers/ultrafield/ultrafieldEnd";

    bg = stage.stageSprites["BG1"];
}

function onMeasureHit() {
    camMoveOffset = curCameraTarget == 1 ? 30 : 150;
}

function update(elapsed:Float) {
    bg.skew.y = lerp(bg.skew.y, camFollowChars ? (curCameraTarget == 1 ? (dad.curCharacter == "ultra-gorefield-centipede" ? -4 : -8) : 0) : 0, 1/20);

    if (controlHealthAlpha) {
        curHealthAlpha = lerp(curHealthAlpha, curCameraTarget == 1 ? 0.25 : 1, 1/20);
        for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
            spr.alpha = curHealthAlpha;
    }
}