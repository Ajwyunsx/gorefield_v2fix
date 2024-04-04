//

function create() {
    dialscript.menuMusic = FlxG.sound.load(Paths.music('easteregg/areline_theme'), 1.0, true);
    dialscript.clownTheme = FlxG.sound.load(Paths.music('easteregg/menu_clown'), 1.0, true);

    dialscript.dialogueList = [
        {
            message_en: "I $LOVE$ HIGHLIGHTS, MI$D WO$RD ONES, AND EVEN $INCOMPLETE ONES!", 
            message_es: "PRUEBA DE ANIMACIÓN 1\nPRUEBA DE ANIMACIÓN 1\nPRUEBA DE ANIMACIÓN 1\nPRUEBA DE ANIMACIÓN 1\nPRUEBA DE ANIMACIÓN 1", 
            typingSpeed: 0.04, startDelay: 2,
            onEnd: function () {dialscript.switchPortrait(.8, "Clown");},
            event: function (char:Int) {
                if (char == 0) {dialscript.showCloud(true); dialscript.wind.stop(); dialscript.menuMusic.play();}
            }
        },
        {
            message_en: "ANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST ", 
            message_es: "PRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN ", 
            typingSpeed: 0.04, startDelay: 1,
            onEnd: function () {dialscript.switchPortrait(.8, "Emote");},
            event: function (char:Int) {}
        },
        {
            message_en: "ANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST ", 
            message_es: "PRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN ", 
            typingSpeed: 0.04, startDelay: 1,
            onEnd: function () {dialscript.switchPortrait(.8, "cryfieldSecret");},
            event: function (char:Int) {}
        },
        {
            message_en: "ANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST ", 
            message_es: "PRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN ", 
            typingSpeed: 0.04, startDelay: 1,
            onEnd: function () {dialscript.switchPortrait(.8, "Furniture");},
            event: function (char:Int) {}
        },
        {
            message_en: "ANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST ", 
            message_es: "PRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN ", 
            typingSpeed: 0.04, startDelay: 1,
            onEnd: function () {dialscript.switchPortrait(.8, "Explosion");},
            event: function (char:Int) {}
        },
        {
            message_en: "ANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST ", 
            message_es: "PRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN ", 
            typingSpeed: 0.04, startDelay: 1,
            onEnd: function () {dialscript.switchPortrait(.8, "chart");},
            event: function (char:Int) {}
        },
        {
            message_en: "ANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST ", 
            message_es: "PRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN ", 
            typingSpeed: 0.04, startDelay: 1,
            onEnd: function () {dialscript.switchPortrait(.8, "Note");},
            event: function (char:Int) {}
        },
        {
            message_en: "ANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST \nANIMATION TEST ", 
            message_es: "PRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN \nPRUEBA DE ANIMACIÓN ", 
            typingSpeed: 0.04, startDelay: 1,
            onEnd: function () {dialscript.switchPortrait(.8, "Note_Green");},
            event: function (char:Int) {}
        }
    ];
}

function postCreate() {
    dialscript.fastFirstFade = false; 
    dialscript.introSound = FlxG.sound.load(Paths.sound('easteregg/snd_test'), 0.4);
	(new FlxTimer()).start(4/8, function () dialscript.introSound.play(), 8);
	if (FlxG.save.data.arlenePhase == -1 || !FlxG.save.data.canVisitArlene) return;
	(new FlxTimer()).start(6.2, function () FlxG.sound.play(Paths.sound('easteregg/mus_sfx_cinematiccut'), 0.1));
	(new FlxTimer()).start(8, dialscript.progressDialogue);
}