using System.Data;

public static class RomanNumeralExtension
{
    private static readonly Dictionary<int, string> romanDigitForValue = new Dictionary<int, string>
    {
        {1, "I"},
        {5, "V"},
        {10, "X"},
        {50, "L"},
        {100, "C"},
        {500, "D"},
        {1000, "M"},
    };

    public static string ToRoman(this int value)
    {
        if (value == 0) return "";
        if (romanDigitForValue.TryGetValue(value, out var digit))
            return digit;
        int order = (int) Math.Log10(value);
        int unit = (int) Math.Pow(10, order);
        int limit = unit * 10;
        var mid = limit / 2;
        (int high, int increment) = value < mid ? (mid, unit) : (limit, mid);
        var incrementLimit = high - unit;
        if (value < incrementLimit)
            return GetDigits([increment]) + ToRoman(value - increment);
        else
            return GetDigits([unit, high]) + ToRoman(value - incrementLimit);
    }

    private static string GetDigits(List<int> values) =>
        string.Join("", values.Select(n => romanDigitForValue[n]));
}