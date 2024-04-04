//
import flixel.addons.display.FlxBackdrop;
import funkin.game.ComboRating;

importScript("data/scripts/easteregg/paintings");

var clouds:FlxBackdrop;
var oldClouds:FlxSprite;

function create() {
    comboGroup.x += 300;
    comboGroup.y += 300;

    oldClouds = stage.stageSprites["cloudsFinal"];
    oldClouds.alpha = 0;

    clouds = new FlxBackdrop(Paths.image("stages/stage/clouds"), 0x01, 0, 0);
    clouds.velocity.set(-150);

    insert(members.indexOf(oldClouds), clouds);

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

function update(elapsed:Float) clouds.visible = oldClouds.visible;