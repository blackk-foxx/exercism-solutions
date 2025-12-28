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
            var result = Math.Round(Weight - TareAdjustment, Precision);
            var format = $"F{Precision}";
            return $"{result.ToString(format)} kg";
        }
    }
}
