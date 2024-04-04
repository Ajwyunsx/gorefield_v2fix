function onNoteCreation(event)
    if (event.noteType == "Breaking PS Note") {
        event.noteSprite = "game/notes/types/Breaking PS Note";
        event.note.avoid = true;
        if (FlxG.save.data.baby) {
            event.note.strumTime -= 999999;
            event.note.exists = event.note.active = event.note.visible = false;
            return;
        }

        if (FlxG.save.data.ps_hard) event.note.alpha = 0.5;
        event.note.latePressWindow = 0.25;
    }

function onPlayerMiss(event)
    if (event.noteType == "Breaking PS Note") {event.cancel(true); event.note.strumLine.deleteNote(event.note);}

function onPlayerHit(event)
    if (event.noteType == "Breaking PS Note") {
        event.countAsCombo = event.showRating = event.showSplash = false;
        event.strumGlowCancelled = true;
        FlxG.sound.play(Paths.sound('mechanics/ps'));

        losePS(1);
    }