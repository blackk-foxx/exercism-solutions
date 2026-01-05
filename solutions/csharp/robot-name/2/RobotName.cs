using System.Text;

public class Robot
{
    private static Random random = new Random();
    private static HashSet<string> namesInUse = new HashSet<string>();
    public string Name {get; private set;}

    public Robot()
    {
        Reset();
    }

    public void Reset()
    {
        Name = GenerateUniqueName();
    }

    static string GenerateUniqueName()
    {
        string name;
        do name = GenerateName(); while (namesInUse.Contains(name));
        namesInUse.Add(name);
        return name;
    }

    static string GenerateName() => new string([
            GetRandomLetter(), 
            GetRandomLetter(), 
            GetRandomDigit(), 
            GetRandomDigit(), 
            GetRandomDigit()
        ]);

    static char GetRandomLetter() => GetRandomChar('A', 26);

    static char GetRandomDigit() => GetRandomChar('0', 9);

    static char GetRandomChar(char _base, int maxOffset) => (char) (_base + random.Next(maxOffset));
}