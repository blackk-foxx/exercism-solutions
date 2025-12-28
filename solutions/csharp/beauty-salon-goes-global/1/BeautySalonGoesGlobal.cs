using System.Globalization;
using System.Runtime.InteropServices;

public enum Location
{
    NewYork,
    London,
    Paris
}

public enum AlertLevel
{
    Early,
    Standard,
    Late
}

public static class Appointment
{
    public static DateTime ShowLocalTime(DateTime dtUtc)
    {
        return dtUtc + TimeZoneInfo.Local.GetUtcOffset(dtUtc);
    }

    public static DateTime Schedule(string appointmentDateDescription, Location location)
    {
        DateTime rawDateTime = DateTime.Parse(appointmentDateDescription);
        return rawDateTime - GetTimeZoneInfo(location).GetUtcOffset(rawDateTime);
    }

    public static DateTime GetAlertTime(DateTime appointment, AlertLevel alertLevel)
    {
        var lag = alertLevel switch 
        {
            AlertLevel.Early => TimeSpan.FromDays(1),
            AlertLevel.Standard => TimeSpan.FromHours(1.75),
            AlertLevel.Late => TimeSpan.FromMinutes(30)
        };
        return appointment - lag;
    }

    public static bool HasDaylightSavingChanged(DateTime dt, Location location)
    {
        var timeZoneInfo = GetTimeZoneInfo(location);
        var isDaylightTime = timeZoneInfo.IsDaylightSavingTime(dt);
        var wasDaylightTime = timeZoneInfo.IsDaylightSavingTime(dt - TimeSpan.FromDays(7));
        return isDaylightTime ^ wasDaylightTime;
    }

    public static DateTime NormalizeDateTime(string dtStr, Location location)
    {
        var locale = location switch 
        {
            Location.NewYork => "en-US",
            Location.London => "en-GB",
            Location.Paris => "fr-FR"
        };
        try 
        {
            return DateTime.Parse(dtStr, new CultureInfo(locale));
        }
        catch (System.FormatException)
        {
            return new DateTime(1, 1, 1, 0, 0, 0);
        }
    }
    
    static TimeZoneInfo GetTimeZoneInfo(Location location)
    {
        var isWindows = RuntimeInformation.IsOSPlatform(OSPlatform.Windows);
        var timeZoneId = location switch 
        {
            Location.NewYork => isWindows ? "EasternStandardTime" : "America/New_York",
            Location.London => isWindows ? "GMT Standard Time" : "Europe/London",
            Location.Paris => isWindows ? "W. Europe Standard Time" : "Europe/Paris"
        };
        return TimeZoneInfo.FindSystemTimeZoneById(timeZoneId);
    }
}
