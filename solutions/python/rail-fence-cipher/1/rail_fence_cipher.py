import itertools

def encode(message, rails):
    encoding_rails = build_rails(message, rails)
    cipher = itertools.chain(*encoding_rails)
    return "".join(cipher)


def decode(encoded_message, rails):
    message_index_range = range(len(encoded_message))
    decoding_rails = build_rails(message_index_range, rails)
    mapping = dict(zip(itertools.chain(*decoding_rails), encoded_message))
    result = [mapping[i] for i in message_index_range]
    return "".join(result)


def build_rails(items, rails):
    result = [[] for _ in range(rails)]
    direction = 1
    rail_index = 0
    for i in items:
        result[rail_index].append(i)
        rail_index += direction
        if rail_index >= rails:
            direction = -1
            rail_index = rails - 2
        elif rail_index < 0:
            direction = 1
            rail_index = 1
    return result
    