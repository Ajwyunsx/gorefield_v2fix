//
import hxvlc.flixel.FlxVideo;
import funkin.backend.utils.WindowUtils;
import funkin.backend.utils.NativeAPI;

var video:FlxVideo;
var oldVolume:Float;

function create() {
    WindowUtils.preventClosing = true;

    video = new FlxVideo();
    video.onEndReached.add(end);
    video.load(Assets.getPath(Paths.video("PENKARU GRIDDY")));
    video.play();

    oldVolume = FlxG.sound.volume;
    FlxG.sound.changeVolume(2);
    FlxG.sound.music.volume = 0;
}

function update(elapsed:Bool)
    WindowUtils.resetClosing();

function end() {
    WindowUtils.preventClosing = false;
    WindowUtils.resetClosing();

    NativeAPI.showMessageBox("Error", "Null Object Referenace", 0x00000000);
    NativeAPI.showMessageBox("JK :P", "Thanks for playing the mod penk :)\n                         -lunar & lean & gorefield team", 0x00000000);

    video.dispose();
    FlxG.switchState(new StoryMenuState());
    FlxG.sound.music.volume = 1;

    FlxG.sound.volume = oldVolume;
    FlxG.sound.showSoundTray(true);
}