# -*- coding: utf-8 -*-
from datetime import datetime


class LedgerEntry:
    def __init__(self):
        self.date = None
        self.description = None
        self.change = None


def create_entry(date, description, change):
    entry = LedgerEntry()
    entry.date = datetime.strptime(date, '%Y-%m-%d')
    entry.description = description
    entry.change = change
    return entry



class Formatter:

    def __init__(self, locale, currency):
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
        self.symbol = {'USD': '$', 'EUR': u'€'}[currency]

    def generate_header_row(self):
        if self.locale == 'en_US':
            return self.format_header_row('Date', 'Description', 'Change')
        return self.format_header_row('Datum', 'Omschrijving', 'Verandering')

    @staticmethod
    def format_header_row(*headings):
        return ' | '.join(heading.ljust(width) for heading, width in zip(headings, (10, 25, 13)))

    def format_entry(self, entry):
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
        change_dollar = abs(int(change / 100.0))
        dollar_parts = []
        while change_dollar > 0:
            dollar_parts.insert(0, str(change_dollar % 1000))
            change_dollar = change_dollar // 1000
        result = ''
        if len(dollar_parts) == 0:
            result += '0'
        else:
            result += self.thousands_sep.join(dollar_parts)
        result += self.decimal_sep
        change_cents = abs(change) % 100
        result += str(change_cents).rjust(2, '0')
        return result

    @staticmethod
    def format_us_date(date):
        return f"{date.month:02}/{date.day:02}/{date.year:04}"

    @staticmethod
    def format_euro_date(date):
        return f"{date.day:02}-{date.month:02}-{date.year:04}"


def format_entries(currency, locale, entries):
    formatter = Formatter(locale, currency)
    entries = sorted(entries, key=lambda e: (e.date, e.change, e.description))
    rows = (formatter.generate_header_row(), *map(formatter.format_entry, entries))
    return '\n'.join(rows)
