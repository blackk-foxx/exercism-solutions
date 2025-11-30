class Lasagna
{
    public int ExpectedMinutesInOven() 
    {
        return 40;
    }

    public int RemainingMinutesInOven(int elapsed) 
    {
        return ExpectedMinutesInOven() - elapsed;
    }

    public int PreparationTimeInMinutes(int layers)
    {
        return 2 * layers;
    }

    public int ElapsedTimeInMinutes(int layers, int timeInOven)
    {
        return timeInOven + PreparationTimeInMinutes(layers);
    }
}
