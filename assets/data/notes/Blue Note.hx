function onNoteCreation(event) {
    if (event.noteType != "Blue Note") return;
    event.cancel(true); // stop continued calls to other script
    event.note.avoid = true;

    if (FlxG.save.data.baby) {
        event.note.strumTime -= 999999;
        event.note.exists = event.note.active = event.note.visible = false;
        return;
    }

    event.note.frames = Paths.getFrames(event.noteSprite);
    switch(event.strumID % 4) {
        case 0: event.note.animation.addByPrefix('scroll', 'blue arrow LEFT');
        case 1: event.note.animation.addByPrefix('scroll', 'blue arrow DOWN');
        case 2: event.note.animation.addByPrefix('scroll', 'blue arrow UP');
        case 3: event.note.animation.addByPrefix('scroll', 'blue arrow RIGHT');
    }

    event.note.scale.set(event.noteScale, event.noteScale);
    event.note.antialiasing = true;

    event.note.latePressWindow = 0.4; // slight decrease

    if (FlxG.save.data.blue_hard) {
        event.note.alpha = 0.5;
        event.note.latePressWindow *= 2; event.note.earlyPressWindow *= 2;
    }
}

function onPlayerMiss(event)
    if (event.noteType == "Blue Note") {event.cancel(true); event.note.strumLine.deleteNote(event.note);}

function onPlayerHit(event) 
    if (event.noteType == "Blue Note") {
        event.countAsCombo = event.showRating = event.showSplash = false; 
        event.strumGlowCancelled = true; health -= FlxG.save.data.blue_hard ? 2/3 : 0.25;
        FlxG.sound.play(Paths.sound('mechanics/Arrow_Sansfield_Sound'));
    }