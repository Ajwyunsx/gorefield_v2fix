function onNoteCreation(event) {
    if (event.noteType != "Warning Pixel Note") return;
    event.cancel(true); // stop continued calls to other scripts

    if (FlxG.save.data.baby) 
    {
        event.note.strumTime -= 999999;
        event.note.exists = event.note.active = event.note.visible = false;
        return;
    }
    
    event.note.loadGraphic(Paths.image('game/pixel/types/Warning Pixel Note'), true, 17, 17);
    event.note.animation.add("scroll", [4 + event.strumID]);
    event.note.scale.set(6, 6);
}

function onPlayerMiss(event)
    if (event.noteType == "Warning Pixel Note") {health -= 9999; event.cancel(true);}