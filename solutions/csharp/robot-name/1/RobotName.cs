using System.Text;

public class Robot
{
    private static Random random = new Random();
    private static HashSet<string> namesInUse = new HashSet<string>();
    private string _name;
    public string Name
    {
        get
        {
            if (_name == null)
                Reset();
            return _name;
        }
    }

    public void Reset()
    {
        _name = GenerateUniqueName();
    }

    string GenerateUniqueName()
    {
        string name;
        do name = GenerateName(); while (namesInUse.Contains(name));
        namesInUse.Add(name);
        return name;
    }

    string GenerateName() => new string([
            GetRandomLetter(), 
            GetRandomLetter(), 
            GetRandomDigit(), 
            GetRandomDigit(), 
            GetRandomDigit()
        ]);

    char GetRandomLetter() => GetRandomChar('A', 26);

    char GetRandomDigit() => GetRandomChar('0', 9);

    char GetRandomChar(char _base, int maxOffset) => (char) (_base + random.Next(maxOffset));
}