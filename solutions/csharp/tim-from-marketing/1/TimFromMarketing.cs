static class Badge
{
    public static string Print(int? id, string name, string? department)
    {
        var prefix = id == null ? "" : $"[{id}] - ";
        var suffix = $" - {(department?? "owner").ToUpper()}";
        return prefix + name + suffix;
    }
}
