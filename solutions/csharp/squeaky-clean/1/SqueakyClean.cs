using System.Text;

public static class Identifier
{
    public static string Clean(string identifier)
    {
        StringBuilder builder = new StringBuilder();
        bool uppercaseNext = false;
        foreach (char c in identifier) 
        {
            if (c == '-')
                uppercaseNext = true;
            else 
            {
                if (c == ' ')
                    builder.Append('_');
                else if (Char.IsControl(c))
                    builder.Append("CTRL");
                else if (Char.IsLetter(c) && (c < 'α' || 'ω' < c))
                    builder.Append(uppercaseNext ? Char.ToUpper(c) : c);
                uppercaseNext = false;
            }
        }
        return builder.ToString();
    }
}
