class School(dict):
    def __init__(self) -> None:
        self.newly_added = []

    def add_student(self, name: str, grade: int) -> None:
        if name in self:
            self.newly_added.append(False)
        else:
            self[name] = grade
            self.newly_added.append(True)

    def roster(self) -> list[str]:
        def inverted(item):
            return item[1], item[0]
        return [
            name for name, _ in 
            sorted(self.items(), key = inverted)
        ]

    def grade(self, grade_number: int) -> list[str]:
        return sorted(
            name for name, grade in self.items()
            if grade == grade_number
        )

    def added(self) -> list[bool]:
        return self.newly_added
