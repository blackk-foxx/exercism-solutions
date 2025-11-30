from functools import partial

class SpaceAge:

    SECONDS_PER_YEAR = 31_557_600

    ORBITAL_PERIOD_FOR_PLANET = {
        'mercury': 0.2408467,
        'venus': 0.61519726,
        'earth': 1.0,
        'mars': 1.8808158,
        'jupiter': 11.862615,
        'saturn': 29.447498,
        'uranus': 84.016846,
        'neptune': 164.79132,
    }
    
    def __init__(self, seconds):
        self.seconds = seconds
        for planet in self.ORBITAL_PERIOD_FOR_PLANET:
            setattr(self, f'on_{planet}', partial(self.calculate_age, planet))

    def calculate_age(self, planet):
        period = self.ORBITAL_PERIOD_FOR_PLANET[planet]
        return round(self.seconds / (self.SECONDS_PER_YEAR * period), 2)        
