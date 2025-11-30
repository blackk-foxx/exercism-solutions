public static class PlayAnalyzer
{
    public static string AnalyzeOnField(int shirtNum) =>
        shirtNum switch
        {
            1 => "goalie",
            2 => "left back",
            3 or 4 => "center back",
            5 => "right back",
            6 or 7 or 8 => "midfielder",
            9 => "left wing",
            10 => "striker",
            11 => "right wing",
            _ => "UNKNOWN",
        };

    public static string AnalyzeOffField(object report) =>
        report switch
        {
            int n => $"There are {n} supporters at the match.",
            string s => s,
            Incident i when i is Injury => 
                $"Oh no! {i.GetDescription()} Medics are on the field.",
            Incident i => i.GetDescription(),
            Manager { Club: not null } m => $"{m.Name} ({m.Club})",
            Manager m => m.Name,
            _ => "",
        };
}
