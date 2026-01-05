use std::io::{Read, Result, Write};

pub struct ReadStats<R> {
    calls: usize,
    byte_count: usize,
    wrapped: R
}

impl<R: Read> ReadStats<R> {
    pub fn new(wrapped: R) -> ReadStats<R> {
        ReadStats::<R> { calls: 0, byte_count: 0, wrapped: wrapped }
    }

    pub fn get_ref(&self) -> &R {
        &self.wrapped
    }

    pub fn bytes_through(&self) -> usize {
        self.byte_count
    }

    pub fn reads(&self) -> usize {
        self.calls
    }
}

impl<R: Read> Read for ReadStats<R> {
    fn read(&mut self, buf: &mut [u8]) -> Result<usize> {
        self.calls += 1;
        self.wrapped.read(buf).and_then(|byte_count| {
            self.byte_count += byte_count;
            Ok(byte_count)
        })
    }
}

pub struct WriteStats<W> {
    calls: usize,
    byte_count: usize,
    wrapped: W
}

impl<W: Write> WriteStats<W> {
    pub fn new(wrapped: W) -> WriteStats<W> {
        WriteStats::<W> {calls: 0, byte_count: 0, wrapped: wrapped}
    }

    pub fn get_ref(&self) -> &W {
        &self.wrapped
    }

    pub fn bytes_through(&self) -> usize {
        self.byte_count
    }

    pub fn writes(&self) -> usize {
        self.calls
    }
}

impl<W: Write> Write for WriteStats<W> {
    fn write(&mut self, buf: &[u8]) -> Result<usize> {
        self.calls += 1;
        self.wrapped.write(buf).and_then(|byte_count| {
            self.byte_count += byte_count;
            Ok(byte_count)
        })
    }

    fn flush(&mut self) -> Result<()> {
        self.wrapped.flush()
    }
}
