# -*- coding: utf-8 -*-
from datetime import datetime
from dataclasses import dataclass
from typing import Iterable, Literal


Locale = Literal["en_US"] | Literal["nl_NL"]
Currency = Literal["USD"] | Literal["EUR"]

@dataclass
class LedgerEntry:
    date: datetime
    description: str
    change: int


def create_entry(date: str, description: str, change: int) -> LedgerEntry:
    return LedgerEntry(datetime.strptime(date, '%Y-%m-%d'), description, change)


def format_entries(currency: Currency, locale: Locale, entries: Iterable[LedgerEntry]):
    formatter = Formatter(currency, locale)
    entries = sorted(entries, key=lambda e: (e.date, e.change, e.description))
    header_row = formatter.format_header_row()
    entry_rows = map(formatter.format_entry_row, entries)
    return '\n'.join((header_row, *entry_rows))


class Formatter:

    def __init__(self, currency: Currency, locale: Locale):
        self.symbol = {'USD': '$', 'EUR': u'€'}[currency]
        if locale == 'en_US':
            self.date_format = "%m/%d/%Y"
            self.gain_format = '{}{} '
            self.loss_format = '({}{})'
            self.thousands_sep = ','
            self.decimal_sep = '.'
            self.dictionary = {
                "date": "Date",
                "description": "Description",
                "change": "Change",
            }
        elif locale == 'nl_NL':
            self.date_format = "%d-%m-%Y"
            self.gain_format = '{} {} '
            self.loss_format = '{} -{} '
            self.thousands_sep = '.'
            self.decimal_sep = ','
            self.dictionary = {
                "date": "Datum",
                "description": "Omschrijving",
                "change": "Verandering",
            }

        self.columns = {
            "date": (10, self.format_date),
            "description": (25, self.format_description),
            "change": (13, self.format_change),
        }

    def format_header_row(self):
        return ' | '.join(
            self.dictionary[heading].ljust(width) for heading, (width, _) in self.columns.items()
        )

    def format_entry_row(self, entry: LedgerEntry) -> str:
        return ' | '.join(
            format(entry, width) for width, format in self.columns.values()
        )

    def format_date(self, entry: LedgerEntry, width: int) -> str:
        return entry.date.strftime(self.date_format).ljust(width)

    @staticmethod
    def format_description(entry: LedgerEntry, width: int) -> str:
        description = entry.description
        if len(description) > width:
            return description[:width-3] + '...'
        return description.ljust(width)

    def format_change(self, entry: LedgerEntry, width) -> str:
        change = entry.change
        amount = self.format_amount(change)
        result_format = self.loss_format if change < 0 else self.gain_format
        return result_format.format(self.symbol, amount).rjust(width)
    
    def format_amount(self, change: int) -> str:
        dollars, cents = divmod(abs(change), 100)
        dollar_parts = self.split_into_thousands(dollars)
        dollars_str = self.thousands_sep.join(dollar_parts) or '0'
        return f"{dollars_str}{self.decimal_sep}{cents:02}"

    @staticmethod
    def split_into_thousands(amount: int) -> Iterable[str]:
        result = []
        while amount > 0:
            amount, part = divmod(amount, 1000)
            result.append(str(part))
        return result[::-1]
