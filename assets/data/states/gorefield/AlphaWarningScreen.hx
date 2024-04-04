import funkin.backend.MusicBeatState;
import funkin.backend.utils.CoolSfx;
import flixel.util.FlxAxes;
import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;

var titleAlphabet:Alphabet;
var disclaimer:FunkinText;

var transitioning:Bool = false;

function create() 
{
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

function update(elapsed:Float) 
{
    if (controls.ACCEPT && transitioning) 
    {
        FlxG.camera.stopFX(); FlxG.camera.visible = false;
        goToTitle();
    }

    if (controls.ACCEPT && !transitioning) 
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