function create()
{
    comboGroup.x += 150;
    comboGroup.y -= 100;
    
    var pixelScript = importScript("data/scripts/pixel-gorefield"); 
    pixelScript.set("noteType", "binky");

    pixelScript.set("gameOverSong", "gameOvers/clown/CLOWN_GameOver_Loop");
    pixelScript.set("retrySFX", "gameOvers/clown/CLOWN_GameOver_End");
    pixelScript.set("lossSFX", "gameOverSFX");

    gameOverSong = "gameOvers/clown/CLOWN_GameOver_Loop";
    retrySFX = "gameOvers/clown/CLOWN_GameOver_End";
    lossSFX = "gameOverSFX";
}