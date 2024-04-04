function onNoteCreation(event) {
    if (event.noteType != "Recharge Note") return;
    event.cancel(true); // stop continued calls to other scripts

    if (FlxG.save.data.baby) {
        event.note.strumTime -= 999999;
        event.note.exists = event.note.active = event.note.visible = false;
        return;
    }

    event.note.frames = Paths.getFrames(event.noteSprite);
    switch(event.strumID % 4) {
        case 0: event.note.animation.addByPrefix('scroll', 'RECARGA');
        case 1: event.note.animation.addByPrefix('scroll', 'RECARGA');
        case 2: event.note.animation.addByPrefix('scroll', 'RECARGA');
        case 3: event.note.animation.addByPrefix('scroll', 'RECARGA');
    }

    event.note.scale.set(event.noteScale, event.noteScale);
    event.note.antialiasing = true;
}

function onPlayerHit(event)
    if (event.noteType == "Recharge Note") 
    {
        event.showSplash = false; 
        event.strumGlowCancelled = true;
    
        boyfriend.playAnim("recharge", true);
        event.preventAnim();
    }

function onPlayerMiss(event)
    if (event.noteType == "Recharge Note") {health -= 9999; event.cancel(true);}