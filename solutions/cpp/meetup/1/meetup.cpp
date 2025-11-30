#include "meetup.h"

namespace meetup {

using namespace boost::gregorian;

date advance_to_weekday(date start_date, greg_weekday weekday) {
    day_iterator it(start_date);
    while (it->day_of_week() != weekday)
        ++it;
    return *it;    
}

date get_teenth_kday_of_month(greg_weekday weekday, greg_year year, greg_month month) {
    return advance_to_weekday({year, month, 13}, weekday);
}

date_duration weeks(int n) {
    return days(n * 7);
}

date scheduler::monteenth() const {
    return get_teenth_kday_of_month(Monday, year, month);
}

date scheduler::tuesteenth() const {
    return get_teenth_kday_of_month(Tuesday, year, month);
}
    
date scheduler::wednesteenth() const {
    return get_teenth_kday_of_month(Wednesday, year, month);
}

date scheduler::thursteenth() const {
    return get_teenth_kday_of_month(Thursday, year, month);
}

date scheduler::friteenth() const {
    return get_teenth_kday_of_month(Friday, year, month);
}

date scheduler::saturteenth() const {
    return get_teenth_kday_of_month(Saturday, year, month);
}

date scheduler::sunteenth() const {
    return get_teenth_kday_of_month(Sunday, year, month);
}

date scheduler::first_monday() const {
    return first_kday_of_month(Monday, month).get_date(year);
}

date scheduler::first_tuesday() const {
    return first_kday_of_month(Tuesday, month).get_date(year);
}
    
date scheduler::first_wednesday() const {
    return first_kday_of_month(Wednesday, month).get_date(year);
}

date scheduler::first_thursday() const {
    return first_kday_of_month(Thursday, month).get_date(year);
}
    
date scheduler::first_friday() const {
    return first_kday_of_month(Friday, month).get_date(year);
}

date scheduler::first_saturday() const {
    return first_kday_of_month(Saturday, month).get_date(year);
}

date scheduler::first_sunday() const {
    return first_kday_of_month(Sunday, month).get_date(year);
}

date scheduler::second_monday() const {
    return first_monday() + weeks(1);
}

date scheduler::second_tuesday() const {
    return first_tuesday() + weeks(1);
}

date scheduler::second_wednesday() const {
    return first_wednesday() + weeks(1);
}

date scheduler::second_thursday() const {
    return first_thursday() + weeks(1);
}

date scheduler::second_friday() const {
    return first_friday() + weeks(1);
}

date scheduler::second_saturday() const {
    return first_saturday() + weeks(1);
}

date scheduler::second_sunday() const {
    return first_sunday() + weeks(1);
}

date scheduler::third_monday() const {
    return first_monday() + weeks(2);
}

date scheduler::third_tuesday() const {
    return first_tuesday() + weeks(2);
}

date scheduler::third_wednesday() const {
    return first_wednesday() + weeks(2);
}

date scheduler::third_thursday() const {
    return first_thursday() + weeks(2);
}

date scheduler::third_friday() const {
    return first_friday() + weeks(2);
}

date scheduler::third_saturday() const {
    return first_saturday() + weeks(2);
}

date scheduler::third_sunday() const {
    return first_sunday() + weeks(2);
}

date scheduler::fourth_monday() const {
    return first_monday() + weeks(3);
}

date scheduler::fourth_tuesday() const {
    return first_tuesday() + weeks(3);
}

date scheduler::fourth_wednesday() const {
    return first_wednesday() + weeks(3);
}

date scheduler::fourth_thursday() const {
    return first_thursday() + weeks(3);
}

date scheduler::fourth_friday() const {
    return first_friday() + weeks(3);
}

date scheduler::fourth_saturday() const {
    return first_saturday() + weeks(3);
}

date scheduler::fourth_sunday() const {
    return first_sunday() + weeks(3);
}

date scheduler::last_monday() const {
    return last_kday_of_month(Monday, month).get_date(year);
}

date scheduler::last_tuesday() const {
    return last_kday_of_month(Tuesday, month).get_date(year);
}

date scheduler::last_wednesday() const {
    return last_kday_of_month(Wednesday, month).get_date(year);
}

date scheduler::last_thursday() const {
    return last_kday_of_month(Thursday, month).get_date(year);
}

date scheduler::last_friday() const {
    return last_kday_of_month(Friday, month).get_date(year);
}

date scheduler::last_saturday() const {
    return last_kday_of_month(Saturday, month).get_date(year);
}

date scheduler::last_sunday() const {
    return last_kday_of_month(Sunday, month).get_date(year);
}

}  // namespace meetup
