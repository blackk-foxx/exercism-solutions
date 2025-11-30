using System.Text;

public static class CryptoSquare
{
    public static string Normalized(string text) =>
        String.Concat(
            text
                .Where(c => Char.IsLetter(c) || Char.IsDigit(c))
                .Select(c => Char.ToLower(c))
        );

    public static IEnumerable<string> Segmented(string text)
    {
        if (text == "") return [];
        var (numRows, numCols) = GetDimensions(text.Length);
        string padded = text.PadRight(numRows * numCols);
        return padded.Chunk(numCols).Select(chars => new string(chars));
    }

    private static (int, int) GetDimensions(int textLength)
    {
        int numRows = (int)Math.Sqrt(textLength);
        int numCols = numRows;
        while (numRows * numCols < textLength)
        {
            numCols++;
            if (numRows * numCols < textLength)
                numRows++;            
        }
        return (numRows, numCols);
    }

    public static string Encoded(IEnumerable<string> segments)
    {
        if (!segments.Any())
            return "";
        StringBuilder result = new();
        int numCols = segments.First().Length;
        var columns = Enumerable.Range(0, numCols)
            .Select(c => new string([.. segments.Select(row => row[c])]));
        return string.Join(" ", columns);
    }

    public static string Ciphertext(string plaintext) =>
        Encoded(Segmented(Normalized(plaintext)));
}