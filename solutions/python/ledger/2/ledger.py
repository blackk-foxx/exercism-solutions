# -*- coding: utf-8 -*-
from datetime import datetime
from dataclasses import dataclass


@dataclass
class LedgerEntry:
    date: datetime
    description: str
    change: int


def create_entry(date, description, change):
    return LedgerEntry(datetime.strptime(date, '%Y-%m-%d'), description, change)


def format_entries(currency, locale, entries):
    formatter = Formatter(currency, locale)
    entries = sorted(entries, key=lambda e: (e.date, e.change, e.description))
    header_row = formatter.format_header_row(*get_headings(locale))
    entry_rows = map(formatter.format_entry_row, entries)
    return '\n'.join((header_row, *entry_rows))


def get_headings(locale):
    if locale == 'en_US':
        return ('Date', 'Description', 'Change')
    return ('Datum', 'Omschrijving', 'Verandering')



class Formatter:

    def __init__(self, currency, locale):
        self.symbol = {'USD': '$', 'EUR': u'€'}[currency]
        if locale == 'en_US':
            self.format_date = self.format_us_date
            self.gain_format = '{}{} '
            self.loss_format = '({}{})'
            self.thousands_sep = ','
            self.decimal_sep = '.'
        elif locale == 'nl_NL':
            self.format_date = self.format_euro_date
            self.gain_format = '{} {} '
            self.loss_format = '{} -{} '
            self.thousands_sep = '.'
            self.decimal_sep = ','
        self.locale = locale

    @staticmethod
    def format_header_row(*headings):
        return ' | '.join(heading.ljust(width) for heading, width in zip(headings, (10, 25, 13)))

    def format_entry_row(self, entry):
        return ' | '.join((
            self.format_date(entry.date),
            self.format_description(entry.description).ljust(25),
            self.format_change(entry.change).rjust(13),
        ))

    @staticmethod
    def format_description(description):
        if len(description) > 25:
            return description[:22] + '...'
        return description

    def format_change(self, change):
        amount = self.format_amount(change)
        result_format = self.loss_format if change < 0 else self.gain_format
        return result_format.format(self.symbol, amount)
    
    def format_amount(self, change):
        dollars, cents = divmod(abs(change), 100)
        dollar_parts = self.split_into_thousands(dollars)
        dollars_str = self.thousands_sep.join(dollar_parts) or '0'
        return f"{dollars_str}{self.decimal_sep}{cents:02}"

    @staticmethod
    def split_into_thousands(amount):
        result = []
        while amount > 0:
            result.append(str(amount % 1000))
            amount //= 1000
        return result[::-1]

    @staticmethod
    def format_us_date(date):
        return f"{date.month:02}/{date.day:02}/{date.year:04}"

    @staticmethod
    def format_euro_date(date):
        return f"{date.day:02}-{date.month:02}-{date.year:04}"
