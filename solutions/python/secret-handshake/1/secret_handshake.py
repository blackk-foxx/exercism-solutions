GESTURE_FOR_BIT = {
    1: "wink",
    2: "double blink",
    4: "close your eyes",
    8: "jump",
}

def commands(binary_str):
    binary = int(binary_str, 2)
    result = [
        gesture
        for bit, gesture in GESTURE_FOR_BIT.items()
        if binary & bit
    ]
    if binary & 16:
        return result[::-1]        
    return result
