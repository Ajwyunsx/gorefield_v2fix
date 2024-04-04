function onEvent(eventEvent)
    if (eventEvent.event.name == "Change MaxCamZoom")
        maxCamZoom = eventEvent.event.params[0];