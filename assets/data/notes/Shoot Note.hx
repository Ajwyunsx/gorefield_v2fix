function onNoteCreation(event) {
    if (event.noteType != "Shoot Note") return;
    event.cancel(true); // stop continued calls to other scripts

    if (FlxG.save.data.baby) {
        event.note.strumTime -= 999999;
        event.note.exists = event.note.active = event.note.visible = false;
        return;
    }

    event.note.frames = Paths.getFrames(event.noteSprite);
    switch(event.strumID % 4) {
        case 0: event.note.animation.addByPrefix('scroll', 'gun note');
        case 1: event.note.animation.addByPrefix('scroll', 'gun note');
        case 2: event.note.animation.addByPrefix('scroll', 'gun note');
        case 3: event.note.animation.addByPrefix('scroll', 'gun note');
    }

    event.note.scale.set(event.noteScale, event.noteScale);
    event.note.antialiasing = true;
}

function onPlayerHit(event)
    if (event.noteType == "Shoot Note") 
    {
        event.showSplash = false; 
        event.strumGlowCancelled = true;
    
        boyfriend.playAnim("shoot", true);
		dad.playAnim("damage", true);
        event.preventAnim();
    }

function onPlayerMiss(event)
    if (event.noteType == "Shoot Note") {health -= 9999; event.cancel(true);}