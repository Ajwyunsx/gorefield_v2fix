function onNoteCreation(event) {
    if (event.noteType != "Life Note") return;
    event.cancel(true); // stop continued calls to other scripts
    event.note.avoid = true;

    if (FlxG.save.data.baby) {
        event.note.strumTime -= 999999;
        event.note.exists = event.note.active = event.note.visible = false;
        return;
    }

    event.note.frames = Paths.getFrames(event.noteSprite);
    switch(event.strumID % 4) {
        case 0: event.note.animation.addByPrefix('scroll', 'cura note');
        case 1: event.note.animation.addByPrefix('scroll', 'cura note');
        case 2: event.note.animation.addByPrefix('scroll', 'cura note');
        case 3: event.note.animation.addByPrefix('scroll', 'cura note');
    }

    event.note.scale.set(event.noteScale, event.noteScale);
    event.note.antialiasing = true;
}

function onPlayerMiss(event)
    if (event.noteType == "Life Note") {event.cancel(true); event.note.strumLine.deleteNote(event.note);}

function onPlayerHit(event)
{
    if (event.noteType != "Life Note") 
        return;

    health += 0.4; 
    event.showSplash = false; 
    event.preventAnim();

    FlxG.sound.play(Paths.sound('mechanics/health'),10);

    addPS(1);
}