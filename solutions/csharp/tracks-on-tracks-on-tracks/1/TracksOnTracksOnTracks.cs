using System.Dynamic;

public static class Languages
{
    public static List<string> NewList() => new List<string>();

    public static List<string> GetExistingLanguages() => ["C#", "Clojure", "Elm"];

    public static List<string> AddLanguage(List<string> languages, string language) =>
        languages.Concat([language]).ToList();

    public static int CountLanguages(List<string> languages) => languages.Count;

    public static bool HasLanguage(List<string> languages, string language) =>
        languages.Contains(language);

    public static List<string> ReverseList(List<string> languages) =>
        languages.AsEnumerable().Reverse().ToList();

    public static bool IsExciting(List<string> languages)
    {
        if (languages.Count >= 1 && languages.First() == "C#")
            return true;
        if (languages.Count is 2 or 3)
            return languages[0..2].Contains("C#");
        return false;        
    }

    public static List<string> RemoveLanguage(List<string> languages, string language) =>
        languages.Where(l => l != language).ToList();

    public static bool IsUnique(List<string> languages)
    {
        var set = new HashSet<string>(languages);
        return set.Count == languages.Count;
    }
}
