function postCreate() {
    if (stage == null || stage.stageXML == null) return;

    if (stage.stageXML.exists("middleScroll") && stage.stageXML.get("middleScroll") == "true") {
        for (strum in cpuStrums) strum.visible = false;
        for (playerStrum in playerStrums) playerStrum.x = ((FlxG.width/2) - (Note.swagWidth * 2)) + (Note.swagWidth * playerStrums.members.indexOf(playerStrum)); // ACUTTALY CENTERED BOZOS!!!!
        
    }

    // destroy scripts
    __script__.didLoad = __script__.active = false;
}