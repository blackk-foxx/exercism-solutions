class RemoteControlCar
{
    int speed;
    int batteryDrain;
    int distanceDriven = 0;
    int batteryLevel = 100;


    public RemoteControlCar(int speed, int batteryDrain)
    {
        this.speed = speed;
        this.batteryDrain = batteryDrain;    
    }

    public bool BatteryDrained() => batteryLevel < batteryDrain;

    public int DistanceDriven() => distanceDriven;

    public void Drive()
    {
        if (!BatteryDrained())
        {
            distanceDriven += speed;
            batteryLevel -= batteryDrain;
        }
    }

    public static RemoteControlCar Nitro() => new RemoteControlCar(50, 4);
}

class RaceTrack
{
    int distance;

    public RaceTrack(int distance)
    {
        this.distance = distance;    
    }

    public bool TryFinishTrack(RemoteControlCar car)
    {
        while (car.DistanceDriven() < distance)
        {
            if (car.BatteryDrained())
                return false;
            car.Drive();
        }
        return true;
    }
}
