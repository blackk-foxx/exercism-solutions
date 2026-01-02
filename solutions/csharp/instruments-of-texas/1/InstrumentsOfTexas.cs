public class CalculationException : Exception
{
    public CalculationException(int operand1, int operand2, string message, Exception inner):
        base(message)
    {
        Operand1 = operand1;
        Operand2 = operand2;
        Inner = inner;
    }

    public int Operand1 { get; private set; }
    public int Operand2 { get; private set; }
    public Exception Inner { get; private set; }
}

public class CalculatorTestHarness
{
    private Calculator calculator;

    public CalculatorTestHarness(Calculator calculator)
    {
        this.calculator = calculator;
    }

    public string TestMultiplication(int x, int y)
    {
        try
        {
            Multiply(x, y);
            return "Multiply succeeded";
        }
        catch (CalculationException ex)
        {
            return $"{ex.Message} {ex.Inner.Message}";
        }
    }

    public void Multiply(int x, int y)
    {
        try
        {
            calculator.Multiply(x, y);
        }
        catch (OverflowException ex) when (x < 0 && y < 0)
        {
            throw new CalculationException(x, y, "Multiply failed for negative operands.", ex);             }
        catch (OverflowException ex)
        {
            throw new CalculationException(x, y, "Multiply failed for mixed or positive operands.", ex);
        }
    }
}


// Please do not modify the code below.
// If there is an overflow in the multiplication operation
// then a System.OverflowException is thrown.
public class Calculator
{
    public int Multiply(int x, int y)
    {
        checked
        {
            return x * y;
        }
    }
}
