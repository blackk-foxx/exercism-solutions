class BirdCount
{
    private int[] birdsPerDay;

    public BirdCount(int[] birdsPerDay)
    {
        this.birdsPerDay = birdsPerDay;
    }

    public static int[] LastWeek()
    {
        return [0, 2, 5, 3, 7, 8, 4];
    }

    public int Today()
    {
        return birdsPerDay[birdsPerDay.Length - 1];
    }

    public void IncrementTodaysCount()
    {
        birdsPerDay[birdsPerDay.Length - 1]++;
    }

    public bool HasDayWithoutBirds()
    {
        return birdsPerDay.Any(c => c == 0);
    }

    public int CountForFirstDays(int numberOfDays)
    {
        return birdsPerDay[0..numberOfDays].Sum();
    }

    public int BusyDays()
    {
        return birdsPerDay.Where(c => c >= 5).Count();
    }
}
