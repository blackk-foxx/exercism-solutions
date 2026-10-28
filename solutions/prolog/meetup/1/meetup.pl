:- use_module(library(date_time)).

meetup(Year, Month, Category, WeekDay, date(Year, Month, Day)) :-
    category_day_range(Category, Year, Month, MinDay, MaxDay),
    between(MinDay, MaxDay, Day),
    week_day(date(Year, Month, Day), WeekDay),
    !.

category_day_range(first, _, _, 1, 7).
category_day_range(second, _, _, 8, 14).
category_day_range(third, _, _, 15, 21).
category_day_range(fourth, _, _, 22, 28).
category_day_range(teenth, _, _, 13, 19).
category_day_range(last, Year, Month, MinDay, MaxDay) :-
    days_in_month(Year, Month, MaxDay),
    MinDay is MaxDay - 6.

days_in_month(_, 12, 31) :- !.
days_in_month(Year, Month, DaysInMonth) :-
    NextMonth is Month + 1,
    Begin = date(Year, Month, 1),
    End = date(Year, NextMonth, 1),
    date_interval(End, Begin, DaysInMonth days).
