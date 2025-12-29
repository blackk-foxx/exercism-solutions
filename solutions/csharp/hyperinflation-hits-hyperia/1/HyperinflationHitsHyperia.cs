public static class CentralBank
{
    public static string DisplayDenomination(long @base, long multiplier)
    {
        try
        {
            return checked(@base * multiplier).ToString();
        }
        catch (System.OverflowException)
        {
            return "*** Too Big ***";
        }
    }

    public static string DisplayGDP(float @base, float multiplier)
    {
        var result = @base * multiplier;
        return float.IsPositiveInfinity(result) ? "*** Too Big ***" : result.ToString();
    }

    public static string DisplayChiefEconomistSalary(decimal salaryBase, decimal multiplier)
    {
        try
        {
            return checked(salaryBase * multiplier).ToString();
        }
        catch (System.OverflowException)
        {
            return "*** Much Too Big ***";
        }
    }
}
