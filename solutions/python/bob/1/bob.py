class Prompt:

    def __init__(self, hey_bob: str) -> None:
        self.prompt = "".join(hey_bob.split())

    def is_silence(self) -> bool:
        return not self.prompt

    def is_yelling(self) -> bool:
        return self.prompt.isupper()

    def is_question(self) -> bool:
        return self.prompt.endswith("?")


def response(hey_bob: str) -> str:
    prompt = Prompt(hey_bob)
    if prompt.is_silence():
        return "Fine. Be that way!"
    if prompt.is_yelling() and prompt.is_question():
        return "Calm down, I know what I'm doing!"
    if prompt.is_yelling():
        return "Whoa, chill out!"
    if prompt.is_question():
        return "Sure."
    return "Whatever."
