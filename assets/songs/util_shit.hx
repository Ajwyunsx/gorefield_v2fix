//
import Reflect;
static function tweenHUD(a:Float, time:Float) {
    for (strumLine in strumLines) tweenStrum(strumLine, a, time);
    tweenHealthBar(a, time);
}

static function tweenHealthBar(a:Float, time:Float) {
    for (spr in [gorefieldhealthBarBG, gorefieldhealthBar, gorefieldiconP1, gorefieldiconP2, scoreTxt, missesTxt, accuracyTxt])
        FlxTween.tween(spr,{alpha: a},time);
}

static function tweenStrum(strumLine:StrumLine, a:Float, time:Float) {
    var _a = a; var _t = time; // weird bug idk
    for (strum in strumLine.members)
        FlxTween.tween(strum, {alpha: a}, time);
    strumLine.notes.forEach(function (n) {
        FlxTween.tween(n, {alpha: _a}, _t);
    });
}

static var turnOffLerpNextFrame = false;
static var oldLerp:Float = -1;
static var frameCount:Int = 0;
static function snapCam() {
    oldLerp = FlxG.camera.followLerp;
    FlxG.camera.followLerp = 9999;
    turnOffLerpNextFrame = true;
    frameCount = 0;
}

function postUpdate(elapsed:Float) {
    if (turnOffLerpNextFrame && frameCount++ >= 2) {
        FlxG.camera.followLerp = oldLerp;
        turnOffLerpNextFrame = false;
    }
}
