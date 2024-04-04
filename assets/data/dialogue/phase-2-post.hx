Encuentrala//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        {
            message_en: "Back so soon??&& %I'm starting to think you just didn't even look...", 
            message_es: "Volviste tan pronto??&& %Estoy empezando a creer que ni siquiera lo buscaste...", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("smug", true);
                }
            }
        },
        {
            message_en: "%While you were gone,& I think I finally found out what the clown meant by highscore!", 
            message_es: "%Mientras no estabas,& creo que finalmente entendí lo que el payaso decia acerca de la mejor puntuación!", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                }
            }
        },
        {
            message_en: "%Highscore is something inside video games...&&\nLike Garfield Kart!!!! &&(Yeah,& my boyfriend is famous)", 
            message_es: "%Las puntuaciones suelen ser algo de video juegos...&&\nComo Garfield Kart!!!! &&(Si,& mi novio es famoso)", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.wind.stop(); dialscript.menuMusic.play();
                }
            }
        },
        {
            message_en: "Remember,&$ the second number of the code is the second digit of your accuracy in your highest highscore.$", 
            message_es: "Recuerda,&$ el segundo número del código es el segundo dígito de tu presición en tu mejor puntuación.$", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}
        },
        {
            message_en: "I don't know where your gonna find a highscore,&&\n%Life isn't a game...", 
            message_es: "No sé donde vas a encontrar una mejor puntuación,&&\n%La vida no es un juego...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("smug", true);
                }
            }
        },
        {
            message_en: "%Also...&& You didn't even find the joke!!", 
            message_es: "%Además...&& Ni siquiera encontraste el chiste!!", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                }
            }
        },
        {
            message_en: "%How am I meant to read you a joke if you didn't even find it?!", 
            message_es: "%Como se supone que voy a leerte un chiste si ni siquiera la has encontrado?!", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("smug", true);
                }
            }
        },
        {
            message_en: "%You know... &%Why am I even reading you these jokes in the first place??", 
            message_es: "%Sabes... &%Por qué si quiera estoy leyendote estos chistes en primer lugar??", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
                event: function (count:Int) {
                    switch (count) {
                        case 0: dialscript.eyes.animation.play("normal", true);
                        case 1: dialscript.eyes.animation.play("confused", true);
                    }
                }
        },
        {
            message_en: "Can't you read? &&%You were speaking fluent english just a moment ago...", 
            message_es: "No sabes leer? &&%Estabas hablando un inglés fluido hace un momento...", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("left", true);
                }
            }
        },
        {
            message_en: "%Either way...&\nReminder$,& the note is in a rain alleywa$y.&&\nThe clown left it for a crying cat.", 
            message_es: "%De cualquier manera...&\nRecuerda$,& la nota está en un callejón lluvios$o.&&\nEl payaso se lo dejó a un gato llorón.", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                }
            }
        },
        {
            message_en: "Go find it so we can continue hunting for more jokes...", 
            message_es: "Ve y buscala entonces podremos seguir buscando por más chistes...", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}
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

    trace("ARLENE DIALOGUE PHASE 2 POST");
}