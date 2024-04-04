function onNoteCreation(event) {
    if (event.noteType != "pixelBigote") return;
    event.cancel(true);


    var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/pixel/pixelbigotes/Notes_Assets_End'), true, 7, 6);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	} else {
		note.loadGraphic(Paths.image('game/pixel/pixelbigotes/Notes'), true, 17, 17);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(6, 6);
	note.updateHitbox();
    note.antialiasing = false;
}

function onPlayerHit(event:NoteHitEvent) {
    if (event.note.noteType != "pixelBigote") return;
    var skin:String = event.note.noteType;
    event.note.splash = "gorefield_orange-pixel";
    event.ratingPrefix = "game/pixel/pixelbigotes/";
    event.ratingScale = event.numScale = 6 * 0.7 * 0.8;
    event.numScale *= 1.1;
    event.ratingAntialiasing = false;

    event.numAntialiasing = false;

    if (event.rating == 'sick' || event.rating == 'good' || event.rating == 'bad' || event.rating == 'shit' || event.rating == 'combo')
        event.ratingScale = 1.5;
}