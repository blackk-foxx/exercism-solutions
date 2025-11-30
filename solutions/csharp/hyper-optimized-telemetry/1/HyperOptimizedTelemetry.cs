using System.Data.SqlTypes;

public static class TelemetryBuffer
{
    public static byte[] ToBuffer(long reading)
    {
        var (isSigned, length) = reading switch
        {
            var r when long.MinValue <= r && r < int.MinValue => (true, sizeof(long)),
            var r when int.MinValue <= r && r < short.MinValue => (true, sizeof(int)),
            var r when short.MinValue <= r && r < 0 => (true, sizeof(short)),
            var r when 0 <= r && r <= ushort.MaxValue => (false, sizeof(ushort)),
            var r when ushort.MaxValue < r && r <= int.MaxValue => (true, sizeof(int)),
            var r when int.MaxValue < r && r <= uint.MaxValue => (false, sizeof(uint)),
            var r when uint.MaxValue < r && r <= long.MaxValue => (true, sizeof(long)),
            _ => default
        };
        byte prefix = (byte) (isSigned ? 256 - length : length);
        var bytes = new byte[] { prefix };
        var result = bytes.Concat(BitConverter.GetBytes(reading)).ToArray();

        // The tests require the ignored bytes to be set to 0
        Array.Fill<byte>(result, 0, length + 1, sizeof(long) - length);
        return result;
    }

    public static long FromBuffer(byte[] buffer)
    {
        short prefix = buffer[0];
        bool isSigned = prefix > 128;
        var length = isSigned ? 256 - prefix : prefix;
        if (length > 8)
            return 0;
        var data = buffer[1..(length + 1)];
        return length switch
        {
            2 when isSigned => BitConverter.ToInt16(data),
            2 => BitConverter.ToUInt16(data),
            4 when isSigned => BitConverter.ToInt32(data),
            4 => BitConverter.ToUInt32(data),
            8 => BitConverter.ToInt64(data),
            _ => default
        };
    }
}
