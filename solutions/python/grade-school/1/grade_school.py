class School(dict):
    def __init__(self):
        self.added_status = []

    def add_student(self, name, grade):
        if name in self:
            self.added_status.append(False)
        else:
            self[name] = grade
            self.added_status.append(True)

    def roster(self):
        def inverted(item):
            a, b = item
            return b, a
        return [
            name for (name, grade) in 
            sorted(self.items(), key = inverted)
        ]

    def grade(self, grade_number):
        return sorted([
            name for (name, grade) in self.items()
            if grade == grade_number
        ])

    def added(self):
        return self.added_status
