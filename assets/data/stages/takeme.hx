import funkin.game.ComboRating;

import flixel.addons.effects.FlxTrail;
import funkin.game.ComboRating;
import funkin.backend.shaders.CustomShader;

public var camCharacters:FlxCamera;

function create() {
    comboGroup.x += 300;
    comboGroup.y += 300;

	FlxG.camera.bgColor = 0xff231118;

	camCharacters = new FlxCamera(0, 0);
	camCharacters.x = -800;
	camCharacters.zoom = 0.71;
	stage.stageSprites["otherView"].cameras = [camCharacters];
    for (strum in strumLines)
		for (i=>strumLine in strumLines.members){
			switch (i){
				case 0 | 2:
					for (char in strumLine.characters)
						char.cameras = [camCharacters];
			}
		}

	for (cam in [camCharacters]) {cam.bgColor = 0x00000000; FlxG.cameras.add(cam, cam == camGame);}

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

function update(elapsed:Bool) {
	camCharacters.zoom = lerp(camCharacters.zoom, 0.71, 0.05);
}

function beatHit(beat:Int) {
    if (Options.camZoomOnBeat && lerpCam && beat % camZoomingInterval == 0)
    {
        camCharacters.zoom += 0.01 * camZoomingStrength;
    }
}