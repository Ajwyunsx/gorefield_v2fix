//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        /*{
            message_en: "HI LEAN",  // HI - Lean
            message_es: "HOLA LEAN", // Hola -EstoyAburridow
            typingSpeed: 0.06, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}  
        },*/
        {
            message_en: "%You forgot already??&&& %Ok,&& I can't even be mad at you anymore.&& %I JUST WAN'T TO BE FREED!",
            message_es: "%Ya lo olvidaste??&&& %Ok,&& ni siquiera puedo molestarme contigo.&& %YO SOLO QUIERO SER LIBERADA!",
            typingSpeed: 0.06, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("smug", true);
                    case 2:
                        dialscript.eyes.animation.play("normal", true);
                }
            }  
        },
        {
            message_en: "%$Combine all the hints to form the code,&& %and release me from this CAGE!$", 
            message_es: "%$Combina todas las pistas para formar el código,&& %y libérame de esta JAULA!$", 
            typingSpeed: 0.03, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("left", true);
                    case 1:
                        dialscript.eyes.animation.play("normal", true);
                }
            }    
        }
    ];

    dialscript.endingCallback = function () {
        dialscript.fadeOut = dialscript.fastFirstFade = true; dialscript.blackTime = 0;
        dialscript.menuMusic.fadeOut(2); dialscript.introSound.volume = 0.3;
        dialscript.eyes.animation.play("normal", true);
        (new FlxTimer()).start(2/8, function () dialscript.introSound.play(true), 8);
        (new FlxTimer()).start(2.2, function () {FlxG.switchState(new StoryMenuState());});
    };
}

function postCreate() {
    dialscript.fastFirstFade = true; 
    dialscript.introSound = FlxG.sound.load(Paths.sound('easteregg/snd_test'), 0.4);
	(new FlxTimer()).start(2/8, function () dialscript.introSound.play(true), 8);
	if (FlxG.save.data.arlenePhase == -1 || !FlxG.save.data.canVisitArlene) return;
	(new FlxTimer()).start(4.2, function () FlxG.sound.play(Paths.sound('easteregg/mus_sfx_cinematiccut'), 0.1));
	(new FlxTimer()).start(6, dialscript.progressDialogue);

    trace("ARLENE DIALOGUE PHASE 4 POST");
}