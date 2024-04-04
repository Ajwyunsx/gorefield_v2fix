var card:FlxSprite;

var camIntroTitleCard:FlxCamera;
var data:T;

var previousCardY:Float = 0;
var slideUp:Bool = false;
var slideDown:Bool = false;
var changeAlpha:Bool = true;
function postCreate() {
    var path:String = "assets/songs/" + SONG.meta.name.toLowerCase() + "/intro-title-card.json";
    if (!Assets.exists(path)) { disableScript(); return; }

    data = Json.parse(Assets.getText(path));

    camIntroTitleCard = new FlxCamera();
    camIntroTitleCard.bgColor = 0x00000000;
    FlxG.cameras.add(camIntroTitleCard, false);

    card = new FlxSprite();
    card.loadGraphic(Paths.image("intro-title-cards/" + data.image));
    card.cameras = [camIntroTitleCard];
    card.screenCenter();
    if (data.offset != null) {
        card.x += data.offset[0];
        card.y += data.offset[1];
    }
    if (data.slideUp != null) slideUp = data.slideUp;
    if (data.slideDown != null) slideDown = data.slideDown;
    if (data.changeAlpha != null) changeAlpha = data.changeAlpha;
    previousCardY = card.y;
    card.alpha = changeAlpha ? 0 : 1;
    add(card);

    if(slideUp){
        card.y += 350;}
    else if(slideDown){
        card.y -= 600;}
}

function onSongStart() {
    FlxTween.tween(card, {alpha: 1, y: previousCardY}, slideUp || slideDown ? 1 : 0.5, {startDelay: data.startDelay ?? 0, ease: FlxEase.cubeInOut});

    var sixthOfDuration:Float = (data.duration ?? 2.5) / 5;
    FlxTween.tween(card, {alpha: changeAlpha ? 0 : 1, y: previousCardY + (slideUp ? 400 : slideDown ? -600 : 0)}, sixthOfDuration * (slideUp || slideDown ? 3 : 1),
    {
        startDelay: (data.startDelay ?? 0) + 0.5 + sixthOfDuration * 4,
        ease: FlxEase.cubeInOut,
        onComplete: function() {
            card.kill();
            remove(card);
            card.destroy();

            FlxG.cameras.remove(camIntroTitleCard, true);

            disableScript();
        }
    });
}