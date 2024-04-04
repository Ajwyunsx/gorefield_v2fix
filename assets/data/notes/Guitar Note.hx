function onNoteCreation(event) {
    if (event.noteType != "Guitar Note") return;
    event.noteSprite = "game/notes/types/Guitar Note";
}