//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        {
            message_en: "%Oh,&& it's you.&&& I see you don't have the note with you yet,&&& %Which is perfectly fine,& %No Rush...", 
            message_es: "%Oh,&& eres tú.&&& Veo que aún no tienes la nota contigo,&&& %lo que está completamente bien,& %sin prisas...", 
            typingSpeed: 0.06, startDelay: 0,
            onEnd: function () {
                dialscript.wind.fadeOut(0.8);
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.wind.volume = 0.5; 
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("confused", true);
                    case 2:
                        dialscript.eyes.animation.play("normal", true);
                }
            }    
        },
        {
            message_en: "%Seems like you need another reminder.& %Again$.&& Note in Snowy Bi$ome.&& In some pine tree, is what the clown said I think...", 
            message_es: "%Parece que necesitas otro recordatorio.& %De nuevo$.&& Nota en un lugar nev$ado.&& En algún pino, es lo que dijo el payaso supongo...", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.wind.stop(); 
                        dialscript.menuMusic.play();
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("smug", true);
                }
            }    
        },
        {
            message_en: "%Another Reminder,$&& the first number is the last digit of today's da$y.&&& %If you forgot to write that down...", 
            message_es: "%Otro recordatorio,$&& el primer número es el último dígito del número de ho$y.&&& %Si te olvidaste escribir eso...", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("smug", true);
                }
            }    
        },
        {
            message_en: "%Well, thats all I have to share with you for now.& %Continue looking for the note.", 
            message_es: "%Bueno, eso es todo lo que tengo para compartir contigo por ahora.& %Continua buscando la nota.", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
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

    trace("ARLENE DIALOGUE PHASE 1 POST");
}