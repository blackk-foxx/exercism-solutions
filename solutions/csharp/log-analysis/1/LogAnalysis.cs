public static class LogAnalysis 
{
    public static string SubstringAfter(this string str, string before) => 
        str.Substring(str.IndexOf(before) + before.Length);

    public static string SubstringBetween(this string str, string before, string after)
    {
        string substr = str.SubstringAfter(before);
        return substr[..substr.IndexOf(after)];
    }

    public static string Message(this string str) => str.SubstringAfter(": ");

    public static string LogLevel(this string str) => str.SubstringBetween("[", "]");
}