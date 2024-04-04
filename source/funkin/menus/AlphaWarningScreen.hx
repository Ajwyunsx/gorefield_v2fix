package funkin.menus;

import funkin.backend.MusicBeatState;
import flixel.util.FlxAxes;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import funkin.backend.FunkinText;


class AlphaWarningScreen extends MusicBeatState {
var titleAlphabet:Alphabet;
var disclaimer:FunkinText;

var transitioning:Bool = false;

public override function create() {
super.create();

    titleAlphabet = new Alphabet(0, 0, FlxG.save.data.spanish ? "AVISO" : "WARNING", true);
    titleAlphabet.screenCenter(FlxAxes.X);
    add(titleAlphabet);

    disclaimer = new FunkinText(16, titleAlphabet.y + titleAlphabet.height + 10, FlxG.width - 32, "", 32);
    disclaimer.alignment = 'center';
    disclaimer.applyMarkup(
        FlxG.save.data.spanish ?
        "Este engine todavía está en estado beta. Eso significa que *la mayoría de las funciones* tienen *defectos* o *no están terminadas*. Si encuentra algún error, por favor reportelo a Codename Engine GitHub.\n\nPresione ENTER para continuar" :
        "This engine is still in a beta state. That means *majority of the features* are either *buggy* or *non finished*. If you find any bugs, please report them to the Codename Engine GitHub.\n\nPress ENTER to continue",
        [
            new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFFF4444), "*")
        ]
    );
    add(disclaimer);

    var off = Std.int((FlxG.height - (disclaimer.y + disclaimer.height)) / 2);
    disclaimer.y += off;
    titleAlphabet.y += off;
	}

    public override function update(elapsed:Float) 
    {
        super.update(elapsed);
	if (FlxG.mouse.justPressed && transitioning) 
    {
        FlxG.camera.stopFX(); FlxG.camera.visible = false;
        goToTitle();
    }

    if (FlxG.mouse.justPressed && !transitioning) 
    {
        transitioning = true;
        CoolUtil.playMenuSFX(CoolSfx.CONFIRM);
        FlxG.camera.flash(FlxColor.WHITE, 1, function() {
            FlxG.camera.fade(FlxColor.BLACK, 2.5, false, goToTitle);
        });
    }
}

function goToTitle() 
{
    MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
    FlxG.switchState(new TitleState());
}
}
