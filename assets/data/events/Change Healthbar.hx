var preloadedBars:Map<String, FlxSprite> = [];

function create()
    for (event in PlayState.SONG.events)
        if (event.name == "Change Healthbar" && !preloadedBars.exists(event.params[0])) {
            var newBar:FlxSprite = createBGBar(event.params[0]);
            newBar.active = newBar.visible = false;
            newBar.drawComplex(camHUD); // Push to GPU

            preloadedBars.set(event.params[0], newBar);
        }

function onEvent(eventEvent)
    if (eventEvent.event.name == "Change Healthbar") {
        var oldBar:FlxSprite = gorefieldhealthBarBG;
        var newBar:FlxSprite = preloadedBars.get(eventEvent.event.params[0]);
        var isPixel:String = eventEvent.event.params[1];

        insert(members.indexOf(oldBar), newBar);
        newBar.active = newBar.visible = true;
        remove(oldBar);

        gorefieldhealthBarBG = newBar;
        gorefieldhealthBar.y = (gorefieldhealthBarBG.y = FlxG.height * 0.83) + 34;

        for (spr in [gorefieldhealthBarBG, gorefieldiconP1, gorefieldiconP2])
            {
                spr.antialiasing = isPixel ? false : true;
        
                if (spr == gorefieldhealthBarBG)
                    continue;
                
                spr.scale.set(isPixel ? 0.83 : 1, isPixel ? 0.83 : 1);
                spr.updateHitbox();
            }

        if(isPixel){                
            gorefieldhealthBarBG.scale.set(6 - 2.85, 6 - 2.85);
            gorefieldhealthBarBG.updateHitbox();
            gorefieldhealthBarBG.screenCenter(0x01);
            gorefieldhealthBarBG.y -= 33;
            gorefieldhealthBarBG.x -= 2;
        }
    }