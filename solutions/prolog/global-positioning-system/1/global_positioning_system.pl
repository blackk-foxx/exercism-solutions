:- use_module(library(dcg/basics)).

comma --> ",", !.
space --> (" "; "\t"), !.

latitude_hemisphere(Hemisphere) --> "N", { Hemisphere = north }.
latitude_hemisphere(Hemisphere) --> "S", { Hemisphere = south }.

longitude_hemisphere(Hemisphere) --> "E", { Hemisphere = east }.
longitude_hemisphere(Hemisphere) --> "W", { Hemisphere = west }.

degrees(Degrees) --> float(Degrees), !.

latitude_degrees(Degrees) --> 
    degrees(Degrees), {  0 =< Degrees, Degrees =< 90 }, !.

longitude_degrees(Degrees) -->
    degrees(Degrees), { 0 =< Degrees, Degrees =< 180 }, !.

latitude(Degrees, Hemisphere) -->
    latitude_degrees(Degrees), 
    space, 
    latitude_hemisphere(Hemisphere), 
    !.

longitude(Degrees, Hemisphere) -->
    longitude_degrees(Degrees), 
    space, 
    longitude_hemisphere(Hemisphere), 
    !.

coordinate(Latitude, LatitudeHemisphere, Longitude, LongitudeHemisphere) -->
    latitude(Latitude, LatitudeHemisphere), 
    comma,
    space, 
    longitude(Longitude, LongitudeHemisphere), 
    !.
