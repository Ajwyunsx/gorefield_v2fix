function onNoteCreation(event) {
    if (event.noteType != "BW Note") return;
    event.noteSprite = "game/notes/gorefield_bw";
    event.note.splash = "gorefield_bw";
}