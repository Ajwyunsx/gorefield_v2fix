function onNoteCreation(event)
{
    if (event.noteType != "Lasagna Boy Sing")
        return;

    event.cancel(true);

	var note = event.note;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('game/pixel/lasagnaBoy/Notes_Assets_End'), true, 7, 6);
		note.animation.add("hold", [event.strumID]);
		note.animation.add("holdend", [4 + event.strumID]);
	} else {
		note.loadGraphic(Paths.image('game/pixel/lasagnaBoy/Notes'), true, 17, 17);
		note.animation.add("scroll", [4 + event.strumID]);
	}
	note.scale.set(daPixelZoom, daPixelZoom);
	note.updateHitbox();
}

function onPlayerHit(event)
{
    if (event.noteType != "Lasagna Boy Sing") 
        return;

    event.character = gf;
}

function onPlayerMiss(event)
{
    if (event.noteType != "Lasagna Boy Sing") 
        return;

    event.animCancelled = true;
}