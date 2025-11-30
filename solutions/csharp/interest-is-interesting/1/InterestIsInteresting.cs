static class SavingsAccount
{
    public static float InterestRate(decimal balance) =>
        balance switch
        {
            _ when balance < 0 => 3.213f,
            _ when balance < 1000 => 0.5f,
            _ when balance < 5000 => 1.621f,
            _ => 2.475f
        };

    public static decimal Interest(decimal balance) =>
        balance * (decimal) InterestRate(balance) / 100;

    public static decimal AnnualBalanceUpdate(decimal balance) =>
        balance + Interest(balance);

    public static int YearsBeforeDesiredBalance(decimal balance, decimal targetBalance)
    {
        var iterations = 0;
        while (balance < targetBalance)
        {
            balance += Interest(balance);
            iterations++;
        }
        return iterations;
    }
}
