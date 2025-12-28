public static class SimpleCalculator
{
    public static string Calculate(int operand1, int operand2, string? operation)
    {
        try
        {
            var result = operation switch
            {
                "+" => operand1 + operand2,
                "*" => operand1 * operand2,
                "/" => operand1 / operand2,
                "" => throw new System.ArgumentException(),
                null => throw new System.ArgumentNullException(),
                _ => throw new System.ArgumentOutOfRangeException()
            };
            return $"{operand1} {operation} {operand2} = {result}";
        }
        catch (System.DivideByZeroException)
        {
            return "Division by zero is not allowed.";
        }
    }
}