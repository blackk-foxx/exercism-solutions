class WeighingMachine
{
    private double weight;
    
    public WeighingMachine(int precision) 
    {
        this.Precision = precision;
    }

    public int Precision { get; }

    public double Weight 
    { 
        get => weight;
        set
        {
            if (value < 0)
            {
                throw new System.ArgumentOutOfRangeException();
            }
            weight = value;
        }
    }

    public double TareAdjustment { get; set; } = 5;

    public string DisplayWeight
    {
        get 
        {
            var format = $"F{Precision}";
            var result = Weight - TareAdjustment;
            return $"{result.ToString(format)} kg";
        }
    }
}
