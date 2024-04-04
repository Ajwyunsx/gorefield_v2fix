var strumColors:Array<Int> = [];
var strumColorMulti:Float = 2;

function create()
{
    if (FlxG.save.data.baby)
        __script__.didLoad = __script__.active = false;
}

function update(elapsed:Float) 
{
    strumColors = [0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF,0xFFFFFFFF];
        strumLines.members[1].notes.forEach(function (note) {
            if (note.strumTime > (Conductor.songPosition - (hitWindow * note.latePressWindow * 0.2))
				&& note.strumTime < (Conductor.songPosition + (hitWindow * note.earlyPressWindow * (note.noteType == "Orange Note" ? strumColorMulti*2 : strumColorMulti)))) {
                if (note.noteType == "Orange Note" && strumColors[note.noteData] == 0xFFFFFFFF) strumColors[note.noteData] = 0xFFFF8400;
                if (note.noteType == "Blue Note" && strumColors[note.noteData] == 0xFFFFFFFF) strumColors[note.noteData] = 0xFF00DDFF;
            }
        });

    for (i => strum in player.members)
        strum.color = FlxColor.interpolate(strum.color, strumColors[i], 1/14);
}
