triangle(Side1, Side2, Side3) :-
    Side1 =\= 0, Side2 =\= 0, Side3 =\= 0,
    Side1 + Side2 > Side3,
    Side2 + Side3 > Side1,
    Side3 + Side1 > Side2.

triangle(Side1, Side2, Side3, "equilateral") :-
    triangle(Side1, Side2, Side3),
    Side1 =:= Side2, Side2 =:= Side3.

triangle(Side1, Side2, Side3, "isosceles") :-
    triangle(Side1, Side2, Side3),
    (Side1 =:= Side2; Side2 =:= Side3; Side3 =:= Side1).
    
triangle(Side1, Side2, Side3, "scalene") :-
    triangle(Side1, Side2, Side3),
    \+ triangle(Side1, Side2, Side3, "equilateral"),
    \+ triangle(Side1, Side2, Side3, "isosceles").
