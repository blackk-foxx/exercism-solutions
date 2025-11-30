VOWELS = 'aeiou'


def translate(text):
    return ' '.join(map(translate_word, text.split()))


def translate_word(word):
    if word[0] in VOWELS or word[:2] in ['xr', 'yt']:
        result = word
    else:
        head, tail = separate_leading_consonants(word)
        result = tail + head
    return result + 'ay'


def separate_leading_consonants(word):
    if word.startswith('y'):
        tail_index = 1
    else:
        tail_index = find_first_vowel(word)
        if word[tail_index-1 : tail_index+1] == 'qu':
            tail_index += 1
    return word[:tail_index], word[tail_index:]


def find_first_vowel(word):
    for i, c in enumerate(word):
        if c in VOWELS + 'y':
            return i
