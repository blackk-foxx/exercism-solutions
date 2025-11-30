from datetime import datetime, timedelta, time

THURSDAY = 3
FRIDAY = 4
SATURDAY = 5
SUNDAY = 6

JANUARY = 1

MONTHS_PER_QUARTER = 3
FINAL_QUARTER_IN_YEAR = 4


def delivery_date(start, description):
    start_time = datetime.fromisoformat(start)
    match description:
        case "NOW":
            target = start_time + timedelta(hours=2)
            return target.isoformat()

        case "ASAP" if start_time.time() < time(13, 0):
            target_date = start_time.date()
            target_time = time(17, 0) 
            
        case "ASAP":
            target_date = start_time.date() + timedelta(days=1)
            target_time = time(13, 0)
            
        case "EOW" if start_time.weekday() < THURSDAY:
            target_date = friday_after(start_time.date())
            target_time = time(17, 0)
            
        case "EOW":
            target_date = sunday_after(start_time.date())
            target_time = time(20, 0)
            
        case _:
            target_date = apply_variable_description(start_time.date(), description)
            target_time = time(8, 0)
            
    return datetime.combine(target_date, target_time).isoformat()


def friday_after(date: datetime) -> datetime:
    return date + timedelta(days=(FRIDAY - date.weekday()))


def sunday_after(date: datetime) -> datetime:
    return date + timedelta(days=(SUNDAY - date.weekday()))


def apply_variable_description(start_date: datetime, description: str) -> datetime:
    if description.endswith('M'):
        target_month = int(description[:-1])
        target_year = start_date.year if start_date.month < target_month else (start_date.year + 1)
        result = first_workday_of(year=target_year, month=target_month)
    elif description.startswith('Q'):
        target_quarter = int(description[1:])
        start_quarter = 1 + start_date.month // MONTHS_PER_QUARTER
        target_year = start_date.year if start_quarter <= target_quarter else (start_date.year + 1)
        result = last_workday_before(start_of_quarter_after(target_year, target_quarter))
    else:
        raise ValueError(f"Unknown description {description}")
    return result


def first_workday_of(year: int, month: int) -> datetime:
    date = datetime(year=year, month=month, day=1)
    if date.weekday() < SATURDAY:
        return date
    else:
        return date + timedelta(days=(1 + SUNDAY - date.weekday()))


def last_workday_before(date: datetime) -> datetime:
    previous_date = date - timedelta(days=1)
    if previous_date.weekday() < SATURDAY:
        return previous_date
    else:
        return previous_date - timedelta(days=(previous_date.weekday() - FRIDAY))


def start_of_quarter_after(year: int, quarter: int) -> datetime:
    if quarter < FINAL_QUARTER_IN_YEAR:
        month = 1 + quarter * MONTHS_PER_QUARTER
        return first_day_of(year=year, month=month)
    else:
        return first_day_of(year=year+1, month=JANUARY)


def first_day_of(year: int, month: int) -> datetime:
    return datetime(year=year, month=month, day=1)
    