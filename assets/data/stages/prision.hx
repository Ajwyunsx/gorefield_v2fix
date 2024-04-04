function create()
{
    comboGroup.x += 400;
    comboGroup.y += 100;

	FlxG.camera.bgColor = 0xff000000;
    gf.visible = false;
    gf.scrollFactor.set(1, 1);

    gameOverSong = "gameOvers/ultrafield/ultrafieldLOOP";
	retrySFX = "gameOvers/ultrafield/ultrafieldEnd";
}