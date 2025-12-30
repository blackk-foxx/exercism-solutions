using System.Globalization;

public static class HighSchoolSweethearts
{
    public static string DisplaySingleLine(string studentA, string studentB) 
    {
        var fieldWidth = (61 - 1 - 2) / 2;
        return $"{studentA.PadLeft(fieldWidth)} ♡ {studentB.PadRight(fieldWidth)}";
    }

    public static string DisplayBanner(string studentA, string studentB)
    {
        var top = @"
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
";
        var bottom = @"
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
";
        return top + $"**     {studentA} +  {studentB}    **" + bottom;
    }

    public static string DisplayGermanExchangeStudents(string studentA
        , string studentB, DateTime start, float hours)
    {
        return string.Create(
            CultureInfo.GetCultureInfo("de-DE"),
            $"{studentA} and {studentB} have been dating since " +
            $"{start:d} - that's {hours:N2} hours"
        );
    }
}
