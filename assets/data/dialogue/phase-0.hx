//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);
    FlxG.save.data.hasVisitedPhase = false;

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    //! Añade % para llamar a la función event!!!! -EstoyAburridow
    dialscript.dialogueList = [
        {
            message_en: "%Hello???&& Who are you??? &&&\nHow did you get trapped down here???", 
            message_es: "%Hola???&& Quién eres??? &&&\nCómo quedaste atrapado aquí abajo???", 
            typingSpeed: 0.065, startDelay: 2,
            onEnd: function () {},
            event: function (count:Int)
                if (count == 0) {dialscript.wind.volume = 0.5; dialscript.eyes.animation.play("confused", true);}
            
        },
        {
            message_en: "I mean you don't look trapped... &&&%You look funny... &&&&&\n%Are you from that stupid clown???", 
            message_es: "Quiero decir que no pareces atrapado... &&&%Te ves gracioso... &&&&&\n%Vienes de ese estupido payaso???", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("left", true);
                case 1: dialscript.eyes.animation.play("smug", true);
            }
        },
        {
            message_en: "%I'm sorry...,&&&  I'm Sorry. &&&\nI didn't mean it that way.", 
            message_es: "%Lo siento...,&&&  Lo siento. &&&\nNo quise decir eso.", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int)
                if (count == 0) {dialscript.eyes.animation.play("normal", true); dialscript.wind.stop(); dialscript.menuMusic.play();}
        },
        {
            message_en: "%Guess being alone down here so long has made me a bit,&&&%\nirritable...", 
            message_es: "%Supongo que estar aquí sola tanto tiempo me hecho algo,&&&%\nirritable...", 
            typingSpeed: 0.054, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("smug", true);
            }
        },
        {
            message_en: "%I might as well introduce myself,&&&% since I'm already spewing my life story...", 
            message_es: "%También podría presentarme,&&&% ya que ya he dicho toda la historia de mi vida...", 
            typingSpeed: 0.058, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("smug", true);
            }
        },
        {
            message_en: "%My name is Arlene,&&&\nand I'm Garfield's girlfriend.", 
            message_es: "%Mi nombre es Arlene,&&&\ny soy la novia de Garfield.", 
            typingSpeed: 0.052, startDelay: 0,
            onEnd: function () {
                (new FlxTimer()).start(.9, function () dialscript.eyes.animation.play("confused", true)); dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
            },
            event: function (count:Int) {
                if (count == 0) {dialscript.eyes.animation.play("normal", true);}
            }
        },
        {
            message_en: "%Huh? &&&&&&You want to know how I got down here?", 
            message_es: "%Huh? &&&&&&Quieres saber como llegué aquí??", 
            typingSpeed: 0.05, startDelay: 1.6,
            onEnd: function () {},
            event: function (count:Int) {
                if (count == 0) {dialscript.eyes.animation.play("confused", true);}
            }
        },
        {
            message_en: "%To be honest I've got no clue...&&&&&&\n%I just went to bed one night and woke up here...", 
            message_es: "%Para ser honesta no tengo idea....&&&&&&\n%Una noche fui a cama y cuando desperté estaba aquí...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0; dialscript.eyes.animation.play("normal", true); dialscript.__canAccept = false;
                (new FlxTimer()).start(.6, function () dialscript.eyes.animation.play("left", true));
            },
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("confused", true);
                case 1: dialscript.eyes.animation.play("normal", true);
            }
        },
        {
            message_en: "%Hey,&&& since you're down here already...&&&&\n%Can you get a hold of Nermal or Garfield for me?", 
            message_es: "%Hey,&&& ya que estas aquí...&&&&\n%Podrias ponerte en contacto con Nermal o Garfield por mí?", 
            typingSpeed: 0.05, startDelay: 0.9,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("left", true);
                case 1: dialscript.eyes.animation.play("confused", true);
            }
        },
        {
            message_en: "%I've been trying to reach them for the longest time...&&&&\n%But they never seem to notice for some reason.&", 
            message_es: "%He estado tratando de encontrarlos por mucho tiempo...&&&&\n%Pero nunca parecen darse cuenta por alguna razón.&", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.eyes.animation.play("normal", true); dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
            },
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("left", true);
            }
        }
        {
            message_en: "%I'm still so thankful you came down here,&&&&&% I finally have someone to talk to...", 
            message_es: "%Todavía estoy tan agradecida de que hayas venido aquí,&&&&&% finalmente tengo a alguien con quien hablar...", 
            typingSpeed: 0.054, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("left", true);
            }
        },
        {
            message_en: "%Being locked up for awhile has made me a bit,...&&&& \n%uh,& observant...", 
            message_es: "%Estar encerrada por un tiempo me ha hecho un poco,...&&&& \n%uh,& observadora...", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("left", true);
                case 1: dialscript.eyes.animation.play("normal", true);
            }
        },
        {
            message_en: "%Like why are you carrying a microphone with you???&&&\nWhat do you want to sing together or something???", 
            message_es: "%Como por qué llevas un micrófono contigo???&&&\nQuieres que cantemos juntos o algo así???", 
            typingSpeed: 0.048, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int)
                if (count == 0) {dialscript.eyes.animation.play("confused", true);}
        },
        {
            message_en: "%Reminds me of the other day...&&&&\n%I think I heard a clown's voice somewhere...", 
            message_es: "%Me recuerda a que el otro día...&&&&\n%Me parece que escuché la voz de un payaso...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.showCloud(true); dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
            },
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("left", true);
                case 1: dialscript.eyes.animation.play("normal", true);
            }
        },
        {
            message_en: "%The clown was saying that a blue haired dwarf,&& and a delivery man,&& are going to stop a monsterous cat.", 
            message_es: "%El payaso decia que un enano de pelo azul,&& y un repartidor,&& iban a detener a un gato monstruoso.", 
            typingSpeed: 0.055, startDelay: 2.1,
            onEnd: function () {},
            event: function (count:Int)
                if (count == 0) {dialscript.eyes.animation.play("confused", true);}
        },
        {
            message_en: "%Yeah I know right!&&&\n%Biggest lies I've ever heard...", 
            message_es: "%Lo sé!&&&\n%Las más grandes mentiras que jamás escuché...", 
            typingSpeed: 0.045, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("smug", true);
            }
        },
        {
            message_en: "%That clown is crazy...&&\n%So crazy that he hides %his jokes???", 
            message_es: "%Ese payaso está loco...&&\n%Tan loco que escondia %sus bromas???", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("confused", true);
                case 2: dialscript.switchPortrait(.8, "Note"); // Este es el primer tercer evento :scream: -EsoyAburridow
            }
        },
        {
            message_en: "%Why would a clown do that???&&&\n%Doesn't that defeat the purpose of being funny???", 
            message_es: "%Por qué un payaso haría eso???&&&\n%Eso no anula el propósito de ser gracioso???", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("smug", true);
                case 1: dialscript.eyes.animation.play("left", true);
            }
        },
        {
            message_en: "%He said he $hid it behind a %very particular painting$...&&&&\n%I still don't know where,&& he wasn't very specific.", 
            message_es: "%Dijo que la $escondió detrás de %una pintura particular$...&&&&\n%Sigo sin saber donde,&& no fue muy específico.", 
            typingSpeed: 0.045, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.switchPortrait(.8, "chart");
                case 2: dialscript.eyes.animation.play("confused", true);
            }
        },
        {
            message_en: "%Find the joke for me,&&\nand I will reward you with an adventure&&.&.&.&&&&&% Of finding more jokes...", 
            message_es: "%Encuentra la broma por mi,&&\ny te compensaré con una aventura&&.&.&.&&&&&% De encontrar más bromas...", 
            typingSpeed: 0.045, startDelay: 0,
            onEnd: function () {dialscript.showCloud(false); dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0; dialscript.__canAccept = false;},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("smug", true);
            }
        },
        {
            message_en: "%Anyways,& thanks for visiting me.&&& \n%One more day down here,& and I would have went insane like that clown.", 
            message_es: "%De todas maneras,& gracias por visitarme.&&& \n%Un día más aquí abajo,& y me hubiera vuelto loca como ese payaso.", 
            typingSpeed: 0.045, startDelay: 1.5,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("left", true);
            }
        },
        {
            message_en: "%Just please come back okay???&&&\n%I don't want to end up losing my own sanity stuck in this wretched cage.", 
            message_es: "%Asegurate de volver de acuerdo???&&&\n%Solo no quiero terminar perdiendo mi propia sanidad mental atorada en esta miserable jaula.", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("left", true);
            }
        },
        {
            message_en: "%And,&& If you can.&& Bring back the joke to me,&&\n%it would be at least entertaining i'd hope.", 
            message_es: "%Y,&& si puedes.&& Tráeme la broma,&&\n%Sería al menos entretenido espero..", 
            typingSpeed: 0.06, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) switch (count) {
                case 0: dialscript.eyes.animation.play("normal", true);
                case 1: dialscript.eyes.animation.play("smug", true);
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
    dialscript.fastFirstFade = false; 
    dialscript.introSound = FlxG.sound.load(Paths.sound('easteregg/snd_test'), 0.4);
	(new FlxTimer()).start(4/8, function () dialscript.introSound.play(true), 8);
	if (FlxG.save.data.arlenePhase == -1 || !FlxG.save.data.canVisitArlene) return;
	(new FlxTimer()).start(6.2, function () FlxG.sound.play(Paths.sound('easteregg/mus_sfx_cinematiccut'), 0.1));
	(new FlxTimer()).start(8, dialscript.progressDialogue);

    // Paintings
    //  Punishment: 0, 1
    //  Stage | Hijon: 2
    //  Lasagna Pixel: 3, 4
    //  New Lasagna Pixel: 5, 6
    //  God: 7, 8, 9, 10
    //  Patella: 11
    //  Cryfield: 12
    if (FlxG.save.data.paintPosition == -1) {
        FlxG.save.data.paintPosition = FlxG.random.int(0, 1);
        FlxG.save.flush();
    }

    trace("ARLENE DIALOGUE PHASE 0 LOADED");
}