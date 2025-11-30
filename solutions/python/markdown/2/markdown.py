import re


MAX_HEADING_LEVEL = 6
LIST_ITEM_PATTERN = r'\* (.*)'
HEADING_PATTERN = '(#+) (.*)'
STRONG_PATTERN = '(.*)__(.*)__(.*)'
EM_PATTERN = '(.*)_(.*)_(.*)'


def is_heading(line):
    return line.startswith("#") and not line.startswith("#" * (MAX_HEADING_LEVEL + 1))


def make_element(tag, content):
    return f"<{tag}>" + content + f"</{tag}>"


def format_heading(line):
    _match = re.match(HEADING_PATTERN, line)
    level = len(_match.group(1))
    return make_element(f'h{level}', _match.group(2))


def apply_emphasis_style(pattern, tag, line):
    if _match := re.match(pattern, line):
        return _match.group(1) + make_element(tag, _match.group(2)) + _match.group(3)
    return line


def apply_emphasis(line):
    line = apply_emphasis_style(STRONG_PATTERN, 'strong', line)
    line = apply_emphasis_style(EM_PATTERN, 'em', line)
    return line


def format_paragraph(i):
    return make_element('p', apply_emphasis(i))


def format_list(items):
    formatted_items = [make_element('li', apply_emphasis(i)) for i in items]
    return make_element('ul', ''.join(formatted_items))


def parse(markdown):
    result = ''
    list_items = []
    for line in markdown.split('\n'):
        if _match := re.match(LIST_ITEM_PATTERN, line):
            list_items.append(_match.group(1))
        else:
            if list_items:
                result += format_list(list_items)
                list_items = []
            if is_heading(line):
                result += format_heading(line)
            else:
                result += format_paragraph(line)
    if list_items:
        result += format_list(list_items)
    return result
