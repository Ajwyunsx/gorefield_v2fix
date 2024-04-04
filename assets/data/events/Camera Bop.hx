function onEvent(eventEvent)
    if (eventEvent.event.name == "Camera Bop") {
        camZoomingInterval = eventEvent.event.params[0];
        camZoomingStrength = eventEvent.event.params[1];
    }