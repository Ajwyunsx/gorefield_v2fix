function onEvent(eventEvent) {
    var params:Array = eventEvent.event.params;
    if (eventEvent.event.name == "Change Stage Zoom") {
        if (params[0]) defaultCamZoom = params[4];
        if (params[1]) strumLineBfZoom = params[4] * strumLineBfMult;
        if (params[2]) strumLineDadZoom = params[4] * strumLineDadMult;
        if (params[3]) strumLineGfZoom = params[4] * strumLineGfMult;
    }
}

