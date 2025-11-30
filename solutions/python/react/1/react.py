from contextlib import suppress

class Cell:
    def __init__(self, initial_value):
        self._value = initial_value
    
    @property
    def value(self):
        return self._value

class InputCell(Cell):
    def __init__(self, initial_value):
        self._value = initial_value
        self._dependents = []

    @Cell.value.setter
    def value(self, v):
        self._value = v
        for d in self._dependents:
            d.update()

    def add_dependent(self, dep):
        self._dependents.append(dep)
    

class ComputeCell(Cell):
    def __init__(self, inputs, compute_function):
        self.inputs = inputs
        self.compute_function = compute_function
        super().__init__(self.compute())
        self.callbacks = []
        for i in inputs:
            i.add_dependent(self)

    def compute(self):
        return self.compute_function([i.value for i in self.inputs])

    def update(self):
        value = self.compute()
        if value != self.value:
            self._value = value
            self.notify()

    def notify(self):
        for c in self.callbacks:
            c(self.value)

    def add_callback(self, callback):
        self.callbacks.append(callback)

    def remove_callback(self, callback):
        with suppress(ValueError):
            self.callbacks.remove(callback)

    def add_dependent(self, dep):
        for i in self.inputs:
            i.add_dependent(dep)
    