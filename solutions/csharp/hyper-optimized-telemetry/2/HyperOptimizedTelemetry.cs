using System.Data.SqlTypes;

public static class TelemetryBuffer
{
    public static byte[] ToBuffer(long reading)
    {
        var length = reading switch
        {
            < Int32.MinValue => sizeof(Int64),
            < Int16.MinValue => sizeof(Int32),
            <= UInt16.MaxValue => sizeof(UInt16),
            <= UInt32.MaxValue => sizeof(UInt32),
            <= Int64.MaxValue => sizeof(Int64)
        };
        var isSigned = reading < 0 ||
            (UInt16.MaxValue < reading && reading <= Int32.MaxValue) ||
            (UInt32.MaxValue < reading && reading <= Int64.MaxValue);
        byte prefix = (byte)(isSigned ? (1 + byte.MaxValue) - length : length);
        var result = new byte[1 + sizeof(long)];
        result[0] = prefix;
        var raw = BitConverter.GetBytes(reading); // 8 bytes
        // Copy only the used bytes; the remaining bytes are left as zero as required by tests.
        Array.Copy(raw, 0, result, 1, length);
        return result;
    }

    public static long FromBuffer(byte[] buffer)
    {
        short prefix = buffer[0];
        bool isSigned = prefix > sbyte.MaxValue;
        var length = isSigned ? (1 + byte.MaxValue) - prefix : prefix;
        var bufferEndIdx = Math.Min(length, sizeof(Int64)) + 1;
        var data = buffer[1..bufferEndIdx];
        return length switch
        {
            sizeof(Int16) when isSigned => BitConverter.ToInt16(data),
            sizeof(Int16) => BitConverter.ToUInt16(data),
            sizeof(Int32) when isSigned => BitConverter.ToInt32(data),
            sizeof(Int32) => BitConverter.ToUInt32(data),
            sizeof(Int64) => BitConverter.ToInt64(data),
            _ => default
        };
    }
}
