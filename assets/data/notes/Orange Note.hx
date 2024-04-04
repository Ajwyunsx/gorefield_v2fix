function onNoteCreation(event) {
    if (FlxG.save.data.baby) 
    {
        event.noteType = null;
        event.noteSprite = "game/notes/sans";
        return;
    }

    if (event.noteType != "Orange Note") return;
    event.cancel(true); // stop continued calls to other scripts

    event.note.frames = Paths.getFrames(event.noteSprite);
    switch(event.strumID % 4) {
        case 0: event.note.animation.addByPrefix('scroll', 'orange arrow left');
        case 1: event.note.animation.addByPrefix('scroll', 'orange arrow DOWN');
        case 2: event.note.animation.addByPrefix('scroll', 'orange arrow up');
        case 3: event.note.animation.addByPrefix('scroll', 'orange arrow right');
    }

    event.note.scale.set(event.noteScale, event.noteScale);
    event.note.antialiasing = true;

    if (FlxG.save.data.orange_hard)
        event.note.alpha = 0.5;

    event.note.latePressWindow *= FlxG.save.data.orange_hard ? 0.3 : 0.5; 
    event.note.earlyPressWindow *= FlxG.save.data.orange_hard ? 0.3 : 0.5;
}

function postCreate()
{
    if (FlxG.save.data.baby)
        __script__.didLoad = __script__.active = false;
}

function onPlayerHit(event)
    if (event.noteType == "Orange Note") {event.showSplash = false; event.strumGlowCancelled = true;}


function onPlayerMiss(event)
    if (event.noteType == "Orange Note") 
    {
        health -= FlxG.save.data.orange_hard ? 2/3 : 0.25;
        FlxG.sound.play(Paths.sound('mechanics/Arrow_Sansfield_Sound'));

        event.note.strumLine.deleteNote(event.note);
        event.cancel(true);
    }