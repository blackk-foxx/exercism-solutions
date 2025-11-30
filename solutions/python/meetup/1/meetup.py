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


def advance_to_weekday(date_: date, day_of_week: str):
    result = date_
    while result.weekday() != value_for_weekday[day_of_week]:
        result += timedelta(days=1)
    return result


def meetup(year, month, week, day_of_week) -> date:
    match week:
        case "teenth":
            return advance_to_weekday(date(year, month, 13), day_of_week)
        case "first":
            return advance_to_weekday(date(year, month, 1), day_of_week)
        case "second":
            return meetup(year, month, "first", day_of_week) + timedelta(weeks=1)
        case "third":
            return meetup(year, month, "first", day_of_week) + timedelta(weeks=2)
        case "fourth":
            return meetup(year, month, "first", day_of_week) + timedelta(weeks=3)
        case "fifth":
            first = meetup(year, month, "first", day_of_week)
            four_weeks = timedelta(weeks=4)
            if first.day + four_weeks.days > get_days_in_month(year, month):
                raise MeetupDayException()
            return first + four_weeks
        case "last":
            result = date(year, month, get_days_in_month(year, month))
            while result.weekday() != value_for_weekday[day_of_week]:
                result -= timedelta(days=1)
            return result
        case _:
            return date()
        
