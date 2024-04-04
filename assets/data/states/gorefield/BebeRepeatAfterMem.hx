import openfl.ui.Mouse;

var curSelected:Int = -1;
var selected_something:Bool = false;

var options:FlxTypedGroup<FlxSprite>;

function create()
{
    FlxG.sound.playMusic(Paths.music("bebe repeat after mem/Baby_Menu"));

    var background:FlxSprite = new FlxSprite();
    background.loadGraphic(Paths.image("menus/bebe repeat after mem/BEBE_REPEAT_AFTHER_MEM"));
    background.setGraphicSize(FlxG.width, FlxG.height);
    background.updateHitbox();
    background.antialiasing = true;
    add(background);

    options = new FlxTypedGroup();
    add(options);

    for (i => option in ["yes", "non"])
    {
        var sprite:FlxSprite = new FlxSprite(170 * i + 800, 400);
        sprite.loadGraphic(Paths.image("menus/bebe repeat after mem/skidibi dom dom dom " + option + " " + option), true, 143, 93);
        sprite.animation.add("idle", [1], 0, false);
        sprite.animation.add("selected", [0], 0, false);
        sprite.animation.play("idle");
        sprite.ID = i;
        
        sprite.antialiasing = true;

        options.add(sprite);
    }
}

function update(elapsed:Float)
{
    var overSomething:Bool = false;
    if (!selected_something) 
    {
        if (FlxG.mouse.justMoved)
        {
            for (sprite in options.members) 
            {
                if (FlxG.mouse.overlaps(sprite)) 
                {
                    overSomething = true;
                    changeItem(sprite.ID, true);
                }
            }

            if (!overSomething)
                changeItem(-1, true);
        }

        if (controls.RIGHT_P)
            changeItem(1, false);
        else if (controls.LEFT_P)
            changeItem(-1, false);

        if (curSelected != -1
            && ((FlxG.mouse.justPressed && FlxG.mouse.overlaps(options.members[curSelected]))
            || controls.ACCEPT)) 
        {
            FlxG.sound.play(Paths.sound('menu/confirm'));

            FlxG.save.data.baby = curSelected == 0;
            FlxG.save.flush();

            new FlxTimer().start(.3, (_) -> 
            {
                FlxG.switchState(new PlayState());
            });
        }
    }

    Mouse.cursor = overSomething ? "button" : "arrow";
}

function changeItem(change:Int, force:Bool)
{
    if (force && curSelected == change)
        return;

    if (curSelected != -1) 
    {
        var prevSprite = options.members[curSelected];
        prevSprite.animation.play("idle");
    }

    if (force)
        curSelected = change;
    else 
    {
        curSelected += change;

        if (curSelected >= options.members.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = options.members.length - 1;
    }

    if (curSelected != -1) 
    {
        FlxG.sound.play(Paths.sound("menu/scrollMenu"));

        var curSprite:FlxText = options.members[curSelected];   
        curSprite.animation.play("selected");
    }
}