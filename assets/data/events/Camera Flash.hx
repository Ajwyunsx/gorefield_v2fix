import Reflect;

function onEvent(eventEvent) {
    if (eventEvent.event.name == "Camera Flash" && FlxG.save.data.flashing)
        (Reflect.getProperty(PlayState.instance, eventEvent.event.params[2])).flash(eventEvent.event.params[0], eventEvent.event.params[1], null, true);
}