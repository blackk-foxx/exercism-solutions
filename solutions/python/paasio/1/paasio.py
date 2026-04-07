import io


class MeteredFile(io.BufferedRandom):
    """Implement using a subclassing model."""

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._read_ops_count = 0
        self._read_bytes_count = 0
        self._write_ops_count = 0
        self._write_bytes_count = 0

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return super().__exit__(exc_type, exc_val, exc_tb)

    def __iter__(self):
        return self

    def __next__(self):
        buf = super().readline()
        if buf:
            self._read_ops_count += 1
            self._read_bytes_count += len(buf)
            return buf
        raise StopIteration

    def read(self, size=-1):
        buf = super().read(size)
        self._read_ops_count += 1
        self._read_bytes_count += len(buf)
        return buf

    @property
    def read_bytes(self):
        return self._read_bytes_count

    @property
    def read_ops(self):
        return self._read_ops_count

    def write(self, b):
        count = super().write(b)
        self._write_ops_count += 1
        self._write_bytes_count += count
        return count

    @property
    def write_bytes(self):
        return self._write_bytes_count

    @property
    def write_ops(self):
        return self._write_ops_count


class MeteredSocket:
    """Implement using a delegation model."""

    def __init__(self, socket):
        self._socket = socket
        self._read_ops_count = 0
        self._write_ops_count = 0
        self._read_bytes_count = 0
        self._write_bytes_count = 0

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        return self._socket.__exit__(exc_type, exc_val, exc_tb)

    def recv(self, bufsize, flags=0):
        buf = self._socket.recv(bufsize, flags)
        self._read_ops_count += 1
        self._read_bytes_count += len(buf)
        return buf

    @property
    def recv_bytes(self):
        return self._read_bytes_count

    @property
    def recv_ops(self):
        return self._read_ops_count

    def send(self, data, flags=0):
        count = self._socket.send(data, flags)
        self._write_ops_count += 1
        self._write_bytes_count += count
        return count

    @property
    def send_bytes(self):
        return self._write_bytes_count

    @property
    def send_ops(self):
        return self._write_ops_count
