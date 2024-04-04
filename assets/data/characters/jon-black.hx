function onPlayAnim(event)
{
    if (animation.curAnim != null && animation.curAnim.name == "death")
        event.cancel();
}