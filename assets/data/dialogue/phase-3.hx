//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        {
            message_en: "If it's not my favorite short warrior...&&\nback with another note!", 
            message_es: "No será mi pequeño guerrero favorito...&&\nde vuelta con otra nota!", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "Thank you blue haired boy...&&\nA few more of these notes and I might get to be free!", 
            message_es: "Gracias chico del cabello azul...&&\nUnas cuantas notas más de estas y podré ser libre!", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "Anyway,& let me see the clown's note to the gray cat...\n&&%this better be good...", 
            message_es: "De cualquier manera,& Dejame ver la nota del payaso que le dio al gato gris...\n&&%será mejor que esto sea bueno...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;

                dialscript.wind.fadeOut(0.8);
                dialscript.showCloud(true);
            },
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("left", true);
                }
            }
        },
        {
            message_en: "%'Poor& poor &little thing...'", 
            message_es: "%'Pobre& pobre &cosita fea...'", 
            typingSpeed: 0.05, startDelay: 2,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0:
                        dialscript.__randSounds = ["easteregg/snd_binky", "easteregg/snd_binky_2", "easteregg/snd_binky_3"];

                        dialscript.wind.stop();
                        dialscript.eyes.animation.play("normal", true);
                }
            }
        },
        {
            message_en: "'Don't you know it's harmful to be outside,&\nESPICALLY WHILE IT'S STORMING?!!!'", 
            message_es: "'No sabes que es peligroso estar afuera,&\nESPECIALMENTE CUANDO HAY TORMENTA?!!!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'Not only that,& but you got into the diriest of places:& a DISGUSTING Alleyway!!'", 
            message_es: "'No solo eso,& pero te metiste en un uno de los lugares más sucios:& un DESAGRADABLE callejón!!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'HEE HEE!&& Do you know what happens in alleyways& little cat?'", 
            message_es: "'HEE HEE!&& Sabes que es lo que pasa en los callejones& pequeño gato?'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'Clowns like me wonder...&& SEARCHING FOR PEOPLE TO TELL THE FUNNIEST OF JOKES TO!!'", 
            message_es: "'Los payasos como yo...&& BUSCAN GENTE A LA QUE CONTARLE LOS CHISTES MÁS GRACIOSOS!!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'And I noticed your friend was crying alot,& so I made a joke for him:'", 
            message_es: "'Y me di cuenta de que tu amigo estaba llorando mucho,& así que le hice un chiste:'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'Do you know why rain makes people wet?\n&&BECAUSE A SHOWER WASNT ENOUGH!!!!'", 
            message_es: "'Sabes por qué la lluvia hace que la gente se moje?\n&&PORQUE UNA DUCHA NO FUE SUFICIENTE!!!!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'BHAHHAAHAHA!!!&&\nThat will surely cheer him up!'", 
            message_es: "'BJAJJAAJAJA!!!&&\nEso seguramente lo animará!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'One more thing...'", 
            message_es: "'Una cosa más...'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'If you see any blue haired dwarf wandering around...\n&&Don't be afraid to call me,& it's the least you owe from that FUNNY joke!!'", 
            message_es: "'Si ves que un enano de pelo azul buscando algo por acá...\n&&No tengas miedo de llamarme,& es lo último que deberias hacer después de que te haya dado ese chiste GRACIOSO!!'", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'-PS:& My phone number is on the back of this note.'", 
            message_es: "'-PS:& Mi número de teléfono está a la vuelta de esta nota.'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;

                dialscript.clownTheme.fadeOut(0.8);

                dialscript.menuMusic.play();
                dialscript.menuMusic.fadeIn(0.8);

                dialscript.switchPortrait(.5, "Note_Green");
            },
            event: function (count:Int) {}
        },
        {
            message_en: "%Okay...&& %there's no way the clown put his phone number on the back of this.", 
            message_es: "%De acuerdo...&& %no hay manera de que el payaso haya puesto su número a la vuelta de esto.", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: 
                        dialscript.clownTheme.stop();
                        dialscript.__randSounds = ["easteregg/snd_text", "easteregg/snd_text_2"];
                    case 1: dialscript.eyes.animation.play("smug", true);
                }
            }
        },
        {
            message_en: "%Yeah& %the back of this note doesn't mention anything about a phone number at all...", 
            message_es: "%Si& %la parte de atras de esta nota no menciona nada acerca de un número de teléfono del todo...", 
            typingSpeed: 0.055, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                    case 1: dialscript.eyes.animation.play("left", true);
                }
            }
        },
        {
            message_en: "%It only has another one of those explantions,& %and another clue...", 
            message_es: "%Solo tiene otra de esas explicaciones,& %y otra pista...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                    case 1: dialscript.eyes.animation.play("smug", true);
                }
            }
        },
        {
            message_en: "I'm not gonna bother reading you the explantion,& it's really straight forward.", 
            message_es: "No te voy a molestar leyendo la explicación,& it's really straight forward.", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "%But the clue...&& %It's so strange..?", 
            message_es: "%Pero la pista...&& %Es algo extraña..?", 
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
            message_en: "%It says:&\n%'Little dwarf,&& Little dwarf...&& you are very lucky to posscess this knowledge...'", 
            message_es: "%Dice:&\n%'Pequeño enano,&& pequeño enano...&& tienes mucha suerte de poseer estos conocimientos...'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch(count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                    case 1: dialscript.__randSounds = ["easteregg/snd_binky", "easteregg/snd_binky_2", "easteregg/snd_binky_3"];
                }
            }
        },
        {
            message_en: "$'The third number of the code is:& the number of songs that start with C,& MINUS!,& the number of songs that start with M.'$", 
            message_es: "$'El tercer número del código es:& el número de canciones que empiezan con C,& MENOS!,& el número de canciones que empiezan con M.'$", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "'OK,& THAT'S THE CLUE!!&&\nI can't wait to meet you soon,& Good Luck!!!'", 
            message_es: "OK, y ESA ES LA PISTA!! && ¡¡¡No puedo esperar a conocerte pronto y buena suerte!!!", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;

                dialscript.switchPortrait(.5, "Emote");
            },
            event: function (count:Int) {}
        },
        {
            message_en: "%This clowns notes are getting more and more confusing everytime...", 
            message_es: "%Estas notas del payaso se están haciendo más y más confusas cada vez...", 
            typingSpeed: 0.05, startDelay: .5,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.__randSounds = ["easteregg/snd_text", "easteregg/snd_text_2"];
                }
            }
        },
        {
            message_en: "%Like what do songs have to do with this...& I know a lot of songs on the top of my head already!!!", 
            message_es: "%O sea, que tienn que ver las canciones con esto...& Ya tengo varias canciones en mente!!!", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("confused", true);
                }
            }
        },
        {
            message_en: "%At this point I think I'm never gonna be free...", 
            message_es: "%A este punto no creo que vaya a ser libre...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                }
            }
        },
        {
            message_en: "But the clown said you know the answer,& so I'll put faith in you...", 
            message_es: "Pero el payaso dijo que tu sabias la respuesta,& así que confiaré en ti...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {}
        },
        {
            message_en: "Also,& while you were gone the other day...&&\nThe clown mentioned where the next note was!", 
            message_es: "Además,& el otro día mientras no estabas...&&\nEl payaso mencionó donde estaba la otra nota!", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;

                dialscript.switchPortrait(.5, "Explosion");
            },
            event: function (count:Int) {}
        },
        {
            message_en: "He said $he hid the joke in a pile of rubble,& %somewhere near a explosion..?$", 
            message_es: "El dijo que escondió la nota en una pila de escombros ,& %en algún lugar cerca de una explosión..?", 
            typingSpeed: 0.05, startDelay: .5,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("confused", true);
                }
            }
        },
        {
            message_en: "%Keep on going little dwarf,& the next note is in your hands...&&\nSee you soon.", 
            message_es: "%Sigue como vas pequeño enano,& La siguiente nota está en tus manos...&&\nTe veo pronto.", 
            typingSpeed: 0.05, startDelay: .0,
            onEnd: function () {},
            event: function (count:Int) {
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                }
            }
        },
    ];

    dialscript.endingCallback = function () {
        dialscript.fadeOut = dialscript.fastFirstFade = true; dialscript.blackTime = 0;
        dialscript.menuMusic.fadeOut(2); dialscript.introSound.volume = 0.3;
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
        FlxG.save.data.paintPosition = 2;
        FlxG.save.flush();
    }

    trace("ARLENE DIALOGUE PHASE 3 LOADED");
}