class RemoteControlCar
{
    private int distanceDriven = 0;
    private int batteryLevel = 100;
    private const int DISTANCE_PER_DRIVE = 20;

    public static RemoteControlCar Buy() => new RemoteControlCar();

    public string DistanceDisplay() =>
        $"Driven {distanceDriven} meters";

    public string BatteryDisplay()
    {
        var indication = batteryLevel > 0 ? $"at {batteryLevel}%" : "empty";
        return "Battery " + indication;
    }

    public void Drive()
    {
        if (batteryLevel > 0)
        {
            distanceDriven += DISTANCE_PER_DRIVE;
            batteryLevel -= 1;            
        }
    }
}
