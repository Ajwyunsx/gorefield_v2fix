static var healthDrain:Float = 0.65;
static var quitaVida:Bool = false;

function create() {
    quitaVida = false;
}

function onDadHit(event) 
{
    if (quitaVida)
    {
        if(healthDrain > 0 && health > healthDrain / 10 + 0.1)
            health -= healthDrain / 10;
    }
}