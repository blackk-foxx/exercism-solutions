from calendar import Calendar
from datetime import date, timedelta

# subclassing the built-in ValueError to create MeetupDayException
class MeetupDayException(ValueError):
    """Exception raised when the Meetup weekday and count do not result in a valid date.

    message: explanation of the error.

    """
    def __init__(self):
        super().__init__("That day does not exist.")

value_for_weekday = {
    "Monday": 0,
    "Tuesday": 1,
    "Wednesday": 2,
    "Thursday": 3,
    "Friday": 4,
    "Saturday": 5,
    "Sunday": 6,
}


def get_days_in_month(year, month):
    calendar = Calendar().monthdayscalendar(year, month)
    return [d for d in calendar[-1] if d][-1]


def advance_to_weekday(start: date, day_of_week: str, step: int) -> date:
    result = start
    while result.weekday() != value_for_weekday[day_of_week]:
        result += timedelta(days=step)
    return result


def validate_date_extension(first, delta, year, month):
    if first.day + delta.days > get_days_in_month(year, month):
        raise MeetupDayException()


ORDINALS = ["first", "second", "third", "fourth", "fifth"]

def meetup(year, month, week, day_of_week) -> date:
    match week:
        case "teenth":
            thirteenth = date(year, month, 13)
            return advance_to_weekday(thirteenth, day_of_week, 1)
        case w if w in ORDINALS:
            first = date(year, month, 1)
            first_day_of_week = advance_to_weekday(first, day_of_week, 1)
            delta = timedelta(weeks=ORDINALS.index(w))
            validate_date_extension(first_day_of_week, delta, year, month)
            return first_day_of_week + delta
        case "last":
            last = date(year, month, get_days_in_month(year, month))
            return advance_to_weekday(last, day_of_week, -1)
        case _:
            pass
        
