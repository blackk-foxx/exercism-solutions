from functools import reduce


def grep(pattern, flags, files):
    result = []
    matcher = Matcher(flags, pattern)
    formatter = Formatter(flags, len(files))
    for file in files:
        for index, line in enumerate(open(file)):
            if matcher.match(line.strip()):
                result.append(formatter.format(index + 1, line.strip(), file))
    return collate(result, flags)


def collate(result, flags):
    if result:
        if "-l" in flags:
            result = remove_duplicates(result)
        return "\n".join(result) + "\n"
    return ""


def remove_duplicates(_list):
    return reduce(lambda a, x: a if x in a else a + [x], _list, [])


class Matcher:
    def __init__(self, flags, pattern):
        self.flags = flags
        self.pattern = pattern

    def match(self, line):
        if "-i" in self.flags:
            return self.pattern.lower() in line.lower()
        if "-v" in self.flags:
            return self.pattern not in line
        if "-x" in self.flags:
            return self.pattern == line
        return self.pattern in line


class Formatter:
    def __init__(self, flags, file_count):
        self.flags = flags
        self.show_filename_prefix = file_count > 1

    def format(self, line_number, line, filename):
        if "-l" in self.flags:
            return filename
        result = [line]
        if "-n" in self.flags:
            result = [str(line_number)] + result
        if self.show_filename_prefix:
            result = [filename] + result
        return ":".join(result)
