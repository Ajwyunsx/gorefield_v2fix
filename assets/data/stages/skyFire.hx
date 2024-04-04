//
import funkin.game.ComboRating;
import flixel.math.FlxRect;

var heatWaveShader:CustomShader;
var bloom:CustomShader;
var bloom2:CustomShader;
public var glitchShader:CustomShader;
public var characterCam:FlxCamera;

var normalStrumPoses:Array<Array<Int>> = [];

function create() {
    for (cam in [camGame, camHUD]) FlxG.cameras.remove(cam, false);

    characterCam = new FlxCamera();
    for (strum in strumLines)
        for (char in strum.characters)
            char.cameras = [characterCam];
    for (cam in [camGame, characterCam, camHUD]) {cam.bgColor = 0x00000000; FlxG.cameras.add(cam, cam == camGame);}
    FlxG.camera.bgColor = FlxColor.fromRGB(54, 34, 83);

    stage.stageSprites["black"].cameras = [camGame, characterCam];
    stage.stageSprites["black_overlay"].cameras = [characterCam];

    heatWaveShader = new CustomShader("heatwave");
    heatWaveShader.time = 0; heatWaveShader.speed = 5; 
    heatWaveShader.strength = 0.38; 

    if (FlxG.save.data.heatwave) camHUD.addShader(heatWaveShader);
    if (FlxG.save.data.heatwave) characterCam.addShader(heatWaveShader);

    bloom = new CustomShader("glow");
    bloom.size = 28.0; bloom.dim = .5;
    if (FlxG.save.data.bloom) stage.stageSprites["fireSky"].shader = bloom;
    stage.stageSprites["fireSky"].clipRect = new FlxRect(0, 20,stage.stageSprites["fireSky"].width, stage.stageSprites["fireSky"].height-20);

    bloom2 = new CustomShader("glow");
    bloom2.size = size = 13.0; bloom2.dim = dim = .8;
    if (FlxG.save.data.bloom) characterCam.addShader(bloom2);
    if (FlxG.save.data.bloom) camGame.addShader(bloom2);

    glitchShader = new CustomShader("glitch");
    glitchShader.glitchAmount = .4;
    //if (FlxG.save.data.glitch) characterCam.addShader(glitchShader);

	comboGroup.x += 500;
    comboGroup.y = 200;

    comboRatings = [
		new ComboRating(0, "F", 0xFF941616),
		new ComboRating(0.5, "E", 0xFFCF1414),
		new ComboRating(0.7, "D", 0xFFFFAA44),
		new ComboRating(0.8, "C", 0xFFFFA02D),
		new ComboRating(0.85, "B", 0xFFFE8503),
		new ComboRating(0.9, "A", 0xFF933AB6),
		new ComboRating(0.95, "S", 0xFFB11EEA),
		new ComboRating(1, "S++", 0xFFC63BFD),
	];
}

function postCreate(){
    remove(stage.stageSprites["cloudScroll1"]);
    remove(stage.stageSprites["black_overlay"]);
    add(stage.stageSprites["black_overlay"]);

    for (i=>strum in strumLines.members)
        normalStrumPoses[i] = [for (i=>s in strum.members) s.y];
}

public function cool() {
    bloom2.dim = dim = 1.6;
    bloom2.size = size = 18;
}

var tottalTime:Float = 0;
public var coolSineMulti:Float = 1;
public var coolSineX:Bool = true;
public var coolSineY:Bool = false;
public var arrowSinner:Bool = false;
public var cloudSpeed:Float = 1;
var size:Float = 0; var dim:Float = 0;
function update(elapsed:Float) {
    tottalTime += elapsed;
    heatWaveShader.time = tottalTime;
    glitchShader.time = tottalTime;

    bloom2.dim = dim = lerp(dim, 2.2, .08);
    bloom2.size = size = lerp(size, 13, .08);

    characterCam.scroll = FlxG.camera.scroll;
    characterCam.zoom = FlxG.camera.zoom;

    dad.y -= 35 * elapsed;
    boyfriend.y -= 35 * elapsed;

    camHUD.angle = lerp(camHUD.angle, coolSineY ? (2* coolSineMulti)*FlxMath.fastSin(tottalTime*2) : 0, 0.25);
    camHUD.y = lerp(camHUD.y, coolSineY ? FlxMath.fastSin(tottalTime + Math.PI*2)*(6*coolSineMulti) : 0, 0.25);
    camHUD.x = lerp(camHUD.x, coolSineX ? FlxMath.fastCos(tottalTime*2 + Math.PI*2)*(12*coolSineMulti) : 0, 0.25);

    for (i => strumLine in strumLines.members)
        for (k=>s in strumLine.members) 
            s.y = lerp(s.y, arrowSinner ? normalStrumPoses[i][k] + ((16*coolSineMulti)*FlxMath.fastSin((tottalTime*4) + ((Conductor.stepCrochet / 1000) * k * 4))) : normalStrumPoses[i][k], .25);
            

    // yum yum code - luner  he took a bite of that gum gum
    stage.stageSprites["cloudScroll1"].y += 700 * elapsed * cloudSpeed;
    stage.stageSprites["cloudScroll2"].y += 550 * elapsed * cloudSpeed;
    stage.stageSprites["cloudScroll3"].y += 350 * elapsed * cloudSpeed;
    stage.stageSprites["cloudScroll4"].y += 250 * elapsed * cloudSpeed;
    stage.stageSprites["cloudScroll5"].y += 100 * elapsed * cloudSpeed;
    if(stage.stageSprites["cloudScroll1"].y > 1300) 
        {stage.stageSprites["cloudScroll1"].y = -1000; stage.stageSprites["cloudScroll1"].x = FlxG.random.float(-100,300);}
    if(stage.stageSprites["cloudScroll2"].y > 1300) 
        {stage.stageSprites["cloudScroll2"].y = -1900; stage.stageSprites["cloudScroll2"].x = FlxG.random.float(-300,600);}
    if(stage.stageSprites["cloudScroll3"].y > 1300) 
        {stage.stageSprites["cloudScroll3"].y = -2100; stage.stageSprites["cloudScroll3"].x = FlxG.random.float(-100,900);}
    if(stage.stageSprites["cloudScroll4"].y > 1300) 
        {stage.stageSprites["cloudScroll4"].y = -1700; stage.stageSprites["cloudScroll4"].x = FlxG.random.float(-100,1000);}
    if(stage.stageSprites["cloudScroll5"].y > 1300) 
        {stage.stageSprites["cloudScroll5"].y = -1900; stage.stageSprites["cloudScroll5"].x = FlxG.random.float(-300,800);}
}

function onPlayerHit(event) {event.showRating = false; songScore += event.score;}
function onPostCountdown(event) {event?.sprite?.cameras = [characterCam]; insert(999999,stage.stageSprites["cloudScroll1"]); stage.stageSprites["cloudScroll1"].cameras = [characterCam];}