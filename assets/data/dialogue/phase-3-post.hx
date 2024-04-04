//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        {
            message_en: "%Back again buddy?&&\n%What's with you and just not listening?&&%\nI'm starting to lose all my hope in you...", 
            message_es: "%Otra vez aquí colega?&&\n%Qué hay cerca de tí y no escuchar?&&%\nEstoy empezando a perder todas las esperanzas en tí...", 
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
                        dialscript.eyes.animation.play("left", true);
                }
            }    
        },
        {
            message_en: "%You know,& I'm still trying to figure out what the clown meant by 'songs'?", 
            message_es: "%Sabes,& sigo intentando entender lo que el payaso decia acerca de las 'canciones'?", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;

                dialscript.showCloud(true);
            },
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                }
            }    
        },
        {
            message_en: "He said something about:$&&%\n'The number of songs that start with C,& MINUS!,& the number of songs that start with M.'%$", 
            message_es: "El dijo algo así como:$&&%\n'El número de canciones que empiezan con C,& MENOS!,& el número de canciones que empiezan con M.'%$", 
            typingSpeed: 0.05, startDelay: 2,
            onEnd: function () {
            },
            event: function (count:Int){
                switch(count){
                    case 0: 
                        dialscript.eyes.animation.play("normal", true);
                        dialscript.__randSounds = ["easteregg/snd_binky", "easteregg/snd_binky_2", "easteregg/snd_binky_3"];
                    case 1: 
                        dialscript.__randSounds = ["easteregg/snd_text", "easteregg/snd_text_2"];
                        
                }
            }    
        },
        {
            message_en: "I still find that clown so strange...&& Like why did he choose to hide the note under rubble?", 
            message_es: "Aún encuentro a ese payaso muy raro...&& O por qué él esconderia la nota debajo de unos escombros?", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}  
        },
        {
            message_en: "And near a explosion of all places!!\n&&He was just getting at nermal for being in a alley...", 
            message_es: "Y cerca de una explosión de todos los lugares!!!\n&&Solo estaba criticando a Nermal por estar en un callejón...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
                
                dialscript.showCloud(false);
            },
            event: function (count:Int){}  
        },
        {
            message_en: "%Either way,&& come back with a note or I'm just gonna repeat the same thing over and over...", 
            message_es: "%De cualquier manera,&& vuelve con la nota o solo voy a repetir lo mismo una y otra vez...", 
            typingSpeed: 0.05, startDelay: 2,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: 
                        dialscript.wind.stop(); 
                        dialscript.menuMusic.play();
                }
            }  
        },
        {
            message_en: "Bye darling!", 
            message_es: "Adios querido!", 
            typingSpeed: 0.05, startDelay: 0,
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

    trace("ARLENE DIALOGUE PHASE 3 POST");
}