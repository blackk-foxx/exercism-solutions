using Xunit.Internal;

public class Anagram
{
    SortedDictionary<char, int> countForChar;
    string baseWord;

    public Anagram(string baseWord)
    {
        this.countForChar = GetCountForChar(baseWord);
        this.baseWord = baseWord;
    }

    public string[] FindAnagrams(string[] potentialMatches) =>
        [.. potentialMatches.Where(s => IsAnagram(s))];

    private bool IsAnagram(string word) =>
        IsDifferentWord(word) && HasSameCharacterCounts(word);

    private bool IsDifferentWord(string word) => !word.Equals(baseWord, StringComparison.OrdinalIgnoreCase);

    private bool HasSameCharacterCounts(string word) => countForChar.SequenceEqual(GetCountForChar(word));


    private static SortedDictionary<char, int> GetCountForChar(string word) =>
        new(
            word
                .ToLower()
                .GroupBy(c => c)
                .ToDictionary(g => g.Key, g => g.Count())
        );
}