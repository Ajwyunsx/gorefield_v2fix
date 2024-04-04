//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    // for future refernce, set this to the first portiat you want, THEN use switch portriat -lunar
    dialscript.cloudPortaitName = "Clown";

    dialscript.dialogueList = [
        {
            message_en: "Welcome back again...&&\nI think this is finally the last note!", 
            message_es: "Bienvenido de vuelta...&&\nCreo que esta es finalmente la última nota!", 
            typingSpeed: 0.06, startDelay: 0,
            onEnd: function () {
                dialscript.wind.fadeOut(0.8);
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
            },
            event: function (count:Int){}  
        },
        {
            message_en: "You know the drill...&&\n%Let's read some more HILARIOUS jokes... ", 
            message_es: "Ya sabes que hacer...&&\n%Leamos algunos chistes HILARANTES... ", 
            typingSpeed: 0.05, startDelay: 1,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;

                dialscript.showCloud(true);
            },
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("smug", true);
                }
            }    
        },
        {
            message_en: "%'Blue balled boy,&& BLUE BALLED BOY!&&\nThis joke will have you &CRACKING!& UP!!!&& BHAHAAHAHA!!!'", 
            message_es: "%'Pequeño enano azul,&& PEQUEÑO ENANO AZUL!&&\nEste chiste te hará &PARTIR DE RISA& VAMOS!!!&& BJAJAAJAJA!!!'", 
            typingSpeed: 0.05, startDelay: 2,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: 
                        dialscript.__randSounds = ["easteregg/snd_binky", "easteregg/snd_binky_2", "easteregg/snd_binky_3"];
                        dialscript.eyes.animation.play("normal", true);
                }
            }    
        },
        {
            message_en: "'What did the match &say to the firecraker?&& BOOM!!!!!&&& BAHHAHAHHAHAA!!!!!!!'", 
            message_es: "'Qué le dijo el partido &al petardo??&& BOOM!!!!!&&& BAJJAJAJJAJAA!!!!!!!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}    
        },
        {
            message_en: "'Also,& SORRY!!!!&& NO EXPLANATION THIS TIME!!!&&\nYour friend got a little, &too annoying...'", 
            message_es: "'Además,& LO SIENTO!!!!&& NO HAY EXPLICACIONES ESTA VEZ!!!&&\ntu amigo se hizo un poco, &muy molesto...'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}    
        },
        {
            message_en: "'Turn the paper around for your clue,&&\nBLUE BALLED BOY!!& HEE HEE!'%", 
            message_es: "'Dale la vuelta al papel para encontrar tu pista,&&\nPEQUEÑO ENANO AZUL!!& HEE HEE!'%", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int) {
                switch(count){
                    case 0: dialscript.__randSounds = ["easteregg/snd_text", "easteregg/snd_text_2"];
                }
            }    
        },
        {
            message_en: "%Okay...&& H%e's actually getting better the more he writes us jokes.", 
            message_es: "De acuerdo...&& É%l se está haciendo mejor escribiendo sus chistes.", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("smug", true);
                    case 1: dialscript.eyes.animation.play("left", true);
                }
            }  
        },
        {
            message_en: "%But still...&& These hints keep on getting more and more confusing...", 
            message_es: "%Pero...&& Estas pistas se están haciendo aún más y más confusas...", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("confused", true);
                }
            }    
        },
        {
            message_en: "%Either way,& this time it reads:& %'LAST NUMBER OF THE CODE,& BLUE HAIRED BOY!!'", 
            message_es: "%De cualquier manera,& esta vez dice:& %'ÚLTIMO NÚMERO DEL CÓDIGO,& CHICO DEL CABELLO AZUL!!'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.eyes.animation.play("normal", true);
                    case 1: dialscript.__randSounds = ["easteregg/snd_binky", "easteregg/snd_binky_2", "easteregg/snd_binky_3"];
                }
            }  
        },
        {
            message_en: "'Kinda sad acuttaly,& I was just starting to get to my GOOD jokes...'", 
            message_es: "'Algo triste de hecho,& estaban empezando a hacerse BUENOS chistes...'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}  
        },
        {
            message_en: "'OKAY!!&& The last digit of the code is...'", 
            message_es: "'DE ACUERDO!!&& El último dígito del código es...'", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}  
        },
        {
            message_en: "$'The number of songs you face of with a GOD,& PLUS!,& the first digit of the minutes.&&\n(HINT:& THE :39 &in 4:39PM!!!)'$", 
            message_es: "$'El número de canciones en las que te enfrentas a un DIOS,& MÁS!,& el primer dígito de los minutos.&&\n(PISTA:& EL :39 &en 4:39PM!!!)'$", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}  
        },
        {
            message_en: "'That's all little dwarf,& I can't WAIT TO MEET YOU!!!&& HEE HEE!'%", 
            message_es: "'Eso es todo enano,& no puedo ESPERAR A CONOCERTE!!!&& HEE HEE!'%", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {
                dialscript.__canAccept = false;
                dialscript.box.alpha = dialscript.dialoguetext.alpha = dialscript.prompt.alpha = 0;
                
                dialscript.showCloud(false);
            },
            event: function (count:Int){
                switch (count) {
                    case 0: dialscript.__randSounds = ["easteregg/snd_text", "easteregg/snd_text_2"];

                }
            }  
        },
        {
            message_en: "%I can feel it!!& Freedom is close!!!", 
            message_es: "%Puedo sentirlo!!& La libertad está cerca!!!", 
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
            message_en: "All you have to do is $combine all the hints you got earlier to form the code!!$", 
            message_es: "Todo lo que debes hacer es $combinar todas las pistas que obtuviste del código!!$", 
            typingSpeed: 0.05, startDelay: 0,
            onEnd: function () {},
            event: function (count:Int){}  
        },
        {
            message_en: "Thank you so much for doing all this scavenging for me!\n&&See you soon...", 
            message_es: "Muchas gracias por hacer toda esta busquedo por mi!\n&&Te veo pronto...", 
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

    trace("ARLENE DIALOGUE PHASE 4 LOADED");
}