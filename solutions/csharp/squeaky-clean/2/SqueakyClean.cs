using System.Text;

public static class Identifier
{
    public static string Clean(string identifier)
    {
        StringBuilder builder = new StringBuilder();
        bool followsDash = false;
        foreach (char c in identifier) 
        {
            builder.Append(c switch
            {
                _ when followsDash => Char.ToUpper(c),
                _ when Char.IsWhiteSpace(c) => '_',
                _ when Char.IsControl(c) => "CTRL",
                _ when IsLowercaseGreekLetter(c) => default,
                _ when Char.IsLetter(c) => c,
                _ => default,
            });
            followsDash = (c == '-');
        }
        return builder.ToString();
    }

    private static bool IsLowercaseGreekLetter(char c)
    {
        return 'α' <= c && c <= 'ω';
    }
}
