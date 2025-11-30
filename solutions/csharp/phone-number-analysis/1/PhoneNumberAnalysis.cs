public static class PhoneNumber
{
    public static (bool IsNewYork, bool IsFake, string LocalNumber) Analyze(string phoneNumber)
    {
        var isNewYork = areaCode(phoneNumber) == "212";
        var isFake = prefix(phoneNumber) == "555";
        return (isNewYork, isFake, lastFour(phoneNumber));
    }

    private static string areaCode(string phoneNumber) => phoneNumber[0..3];

    private static string prefix(string phoneNumber) => phoneNumber[4..7];
    
    private static string lastFour(string phoneNumber) => phoneNumber[(phoneNumber.Length - 4)..];

    public static bool IsFake((bool IsNewYork, bool IsFake, string LocalNumber) phoneNumberInfo) => 
        phoneNumberInfo.IsFake;
}
