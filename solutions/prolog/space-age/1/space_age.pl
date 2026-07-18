period("Mercury", 0.2408467).
period("Venus", 0.61519726).
period("Earth", 1.0).
period("Mars", 1.8808158).
period("Jupiter", 11.862615).
period("Saturn", 29.447498).
period("Uranus", 84.016846).
period("Neptune", 164.79132).

space_age(Planet, AgeSec, Years) :-
    period(Planet, Period),
    SecondsPerYear is 60 * 60 * 24 * 365.25,
    Years = AgeSec / (Period * SecondsPerYear).
