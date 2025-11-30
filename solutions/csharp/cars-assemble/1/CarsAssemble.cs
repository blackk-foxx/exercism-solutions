static class AssemblyLine
{
    const int BASE_RATE = 221;
    const int MINUTES_PER_HOUR = 60;
    
    public static double SuccessRate(int speed) =>
        speed switch 
        {
            0 => 0,
            _ when (1 <= speed && speed <= 4) => 1,
            _ when (5 <= speed && speed <= 8) => 0.9,
            9 => 0.8,
            10 => 0.77,
            _ => 0
        };
    
    public static double ProductionRatePerHour(int speed) => 
        SuccessRate(speed) * BASE_RATE * speed;

    public static int WorkingItemsPerMinute(int speed) => 
        (int) Math.Floor(ProductionRatePerHour(speed) / MINUTES_PER_HOUR);
}
