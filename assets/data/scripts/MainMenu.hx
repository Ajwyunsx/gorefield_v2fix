import funkin.backend.MusicBeatState;

var glowShader:CustomShader;
var glitchShader:CustomShader;
var heatWaveShader:CustomShader;

function postCreate(){

glowShader = new CustomShader("glow");
	glowShader.size = 8.0;// trailBloom.quality = 8.0;
    glowShader.dim = 1;// trailBloom.directions = 16.0;

	heatWaveShader = new CustomShader("heatwave");
    heatWaveShader.time = 0; heatWaveShader.speed = 1; 
    heatWaveShader.strength = 1; 

	glitchShader = new CustomShader("glitch");
    glitchShader.glitchAmount = .4;
}

var tottalTime:Float = 0;
function update(elapsed:Float) {
	tottalTime += elapsed;
	heatWaveShader.time = tottalTime;
	glitchShader.time = tottalTime;
}