import re


def is_heading(line):
    return line.startswith("#") and not line.startswith("#" * 7)


def format_heading(line):
    _match = re.match('(#+) (.*)', line)
    level = len(_match.group(1))
    line = f'<h{level}>' + _match.group(2) + f'</h{level}>'
    return line


def apply_emphasis_style(pattern, tag, line):
    if _match := re.match(pattern, line):
        return _match.group(1) + f'<{tag}>' + _match.group(2) + f'</{tag}>' + _match.group(3)
    return line


def apply_emphasis(line):
    line = apply_emphasis_style('(.*)__(.*)__(.*)', 'strong', line)
    line = apply_emphasis_style('(.*)_(.*)_(.*)', 'em', line)
    return line


def format_paragraph(i):
    return '<p>' + apply_emphasis(i) + '</p>'


def format_list(items):
    formatted_items = ['<li>' + apply_emphasis(i) + '</li>' for i in items]
    return ''.join(['<ul>', *formatted_items, '</ul>'])

    
def parse(markdown):
    lines = markdown.split('\n')
    res = ''
    list_items = []
    for line in lines:
        if _match := re.match(r'\* (.*)', line):
            list_items.append(_match.group(1))
        else:
            if list_items:
                res += format_list(list_items)
                list_items = []
            if is_heading(line):
                res += format_heading(line)
            else:
                res += format_paragraph(line)
    if list_items:
        res += format_list(list_items)
    return res
