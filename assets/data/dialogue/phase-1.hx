//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);
    FlxG.save.data.hasVisitedPhase = false;

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        {
            message_en: "%Oh,&&& you're back.&&&& And you have a piece of paper with you.&&&&\n%Is it a drawing?&& Could I see It?", 
            message_es: "%Oh,&&& has vuelto.&&&& Y traes un pedazo de papel.&&&&\n%Es un dibujo?&& Podría ver?", 
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
                }
            }    
        },
        {
            message_en: "%Oh!&& It's the clown's joke that I mentioned earlier!&&& %Ok...&&&& What does this say.", 
            message_es: "%Oh!&& Es la broma del payaso que mencioné antes!&&& %Ok...&&&& Qué dice esto.", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {
                dialscript.showCloud(true); dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
                dialscript.__randSounds = ["easteregg/snd_binky", "easteregg/snd_binky_2", "easteregg/snd_binky_3"];
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                        dialscript.wind.stop(); 
                        dialscript.menuMusic.play();
                    case 1:
                        dialscript.eyes.animation.play("smug", true);
                        dialscript.menuMusic.fadeOut(2);
                }
            }    
        },
        {
            message_en: "'Dear blue-haired dwarf!&&& Are you aware about the cat and the mouse joke?'", 
            message_es: "'Querido enano de pelo azul!&&& Conoces el chiste del gato y el ratón?'", 
            typingSpeed: 0.05, startDelay: 2.1,
            onEnd: function () {
            },
            event: function (count:Int){

            }    
        },
        {
            message_en: "'The more jokes there are,&& the more cheesy they get.&&& The more cheese there is,&& the more mice.'", 
            message_es: "'Cuantos más chistes hay,&& más cursis se ponen.&&& Cuanto más queso hay,&& más ratones.'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){

            }    
        },
        {
            message_en: "'The more mice,&& the more Binky there is!&&&& HahahaHAhA!'", 
            message_es: "'Cuantos más ratones,&& más Binky hay!&&&& JajajaJAjA!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.switchPortrait(.8, "Note");
                dialscript.clownTheme.fadeOut(0.8);
                dialscript.__randSounds = ["easteregg/snd_text", "easteregg/snd_text_2"];
            },
            event: function (count:Int){

            }    
        },
        {
            message_en: "%Well, that's the end of the note.&&& %Not really that funny if you ask me..&& %But the part where they call you a dwarf was kinda funny.", 
            message_es: "%Bueno, así termina la nota.&&& %No es realmente graciosa si me lo preguntas..&& %Pero la parte en la que te dijo enano fue un poco graciosa.", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                        dialscript.menuMusic.play();
                        dialscript.menuMusic.fadeIn(0.8);
                    case 1:
                        dialscript.eyes.animation.play("smug", true);
                    case 2:
                        dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
        {
            message_en: "%Hold on,&& the note also says that if you don't get the joke,& you can check the back of it.&&& %WELL HOW PRACTICAL!!", 
            message_es: "%Espera,&& la nota también dice que si no entiendes el chiste,& puedes verificar la parte de atras.&&& %QUE PRÁCTICO!!", 
            typingSpeed: 0.045, startDelay: 0,
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
            message_en: "%Let's see...&& It mentions how you've been selected to be his playmate,&& and that you will have a %wonderful reward if you continue playing.", 
            message_es: "%Veamos...&& Dice que has sido seleccionado para ser su compañero de juego,&& y que tendrás una %maravillosa recompensa si sigues jugando.", 
            typingSpeed: 0.05, startDelay: 0,
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
            message_en: "%There's a drawing of me in this note's reward.& %It doesn't exactly capture my feminine essence if you ask me...", 
            message_es: "%Hay un dibujo de mi en la recompensa de esta nota.& %Si me lo preguntas, realmente no capta mi esencia femenina...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.switchPortrait(.5, "Emote");
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
        {
            message_en: "%Oh wait-& I'm already getting off topic here.&& Alright, %returning to the note.", 
            message_es: "%Oh espera-& ya me estoy saliendo del tema aqui.&& De acuerdo, %volviendo a la nota.", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.menuMusic.volume = 0;
                        dialscript.eyes.animation.play("normal", true);
                    case 1:
                        dialscript.switchPortrait(.5, "Note");
                }
            }    
        },
        {
            message_en: "%It also mentions that $you'll need to know 4 numbers in order to free me,$&& and that you have just earned the first one through this note.", 
            message_es: "%También menciona que $debes encontrar 4 números en orden para poder liberarme,$&& y que te acabas de ganar el primero a través de esta nota.", 
            typingSpeed: 0.045, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.menuMusic.fadeIn(0.5);
                        dialscript.eyes.animation.play("normal", true);
                }
            }    
        },
        {
            message_en: "%That's Wonderful!!!&&& Hm.&& %Ok, let me get into the specifics of this number then.", 
            message_es: "%Eso es maravilloso!!!&&& Hm.&& %Ok, déjame entrar en los detalles de este número entonces..", 
            typingSpeed: 0.045, startDelay: 0,
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
            message_en: "%It says that $the first number is the last digit of today's day.$&&&& If I were you,& %I'd probably write this down somewhere.", 
            message_es: "%Dice que $el primer número es el último dígito de este día.$&&&& Si yo fuera tú,& %yo escribiría esto en algún lugar.", 
            typingSpeed: 0.045, startDelay: 0,
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
        {
            message_en: "%Oh Yeah!& While you were away,&&& the clown had commented on seeing the same blue dwarf with a very cool cat.", 
            message_es: "%Oh claro!& Mientras no estabas,&&& el payaso comentó que vio a un enano de pelo azul con un gato muy genial.", 
            typingSpeed: 0.045, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                        dialscript.switchPortrait(.5, "Emote");
                }
            }    
        },
        {
            message_en: "%Which he didn't specify much, besides the fact that $the area was in a snowy biome.$", 
            message_es: "%No especificó mucho, además del hecho de $que fue en un lugar nevado.$", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                        dialscript.switchPortrait(.5, "Snow");
                }
            }    
        },
        {
            message_en: "%I don't exactly understand why he would hide a note in some pine tree.&&& %It's not even decorated for Christmas!", 
            message_es: "%No entiendo exactamente por qué escondería una nota en algún pino..&&& %Ni siquiera está decorado para Navidad!", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.showCloud(false); 
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0; 
                dialscript.__canAccept = false;
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("smug", true);
                    case 1:
                        dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
        {
            message_en: "%Anyways,& I hope to see you soon.&&&& Good Luck!", 
            message_es: "%De igual forma,& espero verte pronto.&&&& Buena suerte!", 
            typingSpeed: 0.045, startDelay: 2.1,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0:
                        dialscript.eyes.animation.play("normal", true);
                }
            }    
        }
    ];

    dialscript.endingCallback = function () {
        dialscript.fadeOut = dialscript.fastFirstFade = true; dialscript.blackTime = 0;
        dialscript.menuMusic.stop(); dialscript.introSound.volume = 0.3;
        dialscript.eyes.animation.play("normal", true);
        (new FlxTimer()).start(2/8, function () dialscript.introSound.play(true), 8);
        (new FlxTimer()).start(2.2, function () {FlxG.switchState(new StoryMenuState()); FlxG.save.data.hasVisitedPhase = true;});
    };
}

function postCreate() {
    dialscript.fastFirstFade = true; 
    dialscript.introSound = FlxG.sound.load(Paths.sound('easteregg/snd_test'), 0.4);
	(new FlxTimer()).start(2/8, function () dialscript.introSound.play(true), 8);
	if (FlxG.save.data.arlenePhase == -1 || !FlxG.save.data.canVisitArlene) return;
	(new FlxTimer()).start(4.2, function () FlxG.sound.play(Paths.sound('easteregg/mus_sfx_cinematiccut'), 0.1));
	(new FlxTimer()).start(6, dialscript.progressDialogue);

    if (FlxG.save.data.paintPosition == -1) {
        FlxG.save.data.paintPosition = 11;
        FlxG.save.flush();
    }

    trace("ARLENE DIALOGUE PHASE 1 LOADED");
}