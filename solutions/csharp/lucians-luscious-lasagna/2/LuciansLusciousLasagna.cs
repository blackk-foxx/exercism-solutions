class Lasagna
{
    public int ExpectedMinutesInOven() => 40;

    public int RemainingMinutesInOven(int elapsed) 
    {
        return ExpectedMinutesInOven() - elapsed;
    }

    public int PreparationTimeInMinutes(int layers) => 2 * layers;

    public int ElapsedTimeInMinutes(int layers, int timeInOven)
    {
        return timeInOven + PreparationTimeInMinutes(layers);
    }
}
