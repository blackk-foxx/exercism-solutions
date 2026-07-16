add_gigasecond(Date, GigasecondDate) :-
    date_time_stamp(Date, TimeStamp),
    date_time_value(time_zone, Date, Zone),
    NewTimeStamp is TimeStamp + 10^9,
    stamp_date_time(NewTimeStamp, GigasecondDate, Zone).
