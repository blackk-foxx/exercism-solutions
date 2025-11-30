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
    settings = FormatSettings.create(locale)
    formatter = Formatter(get_symbol(currency), settings)
    entries = sorted(entries, key=lambda e: (e.date, e.change, e.description))
    header_row = formatter.format_header_row()
    entry_rows = map(formatter.format_entry_row, entries)
    return '\n'.join((header_row, *entry_rows))


def get_symbol(currency: Currency) -> str:
    return {'USD': '$', 'EUR': u'€'}[currency]    


@dataclass
class FormatSettings:
    date_format: str
    gain_format: str
    loss_format: str
    thousands_sep: str
    decimal_sep: str
    dictionary: dict[str, str]

    @classmethod
    def create(cls, locale: Locale) -> "FormatSettings":
        if locale == 'en_US':
            return cls(
                date_format = "%m/%d/%Y",
                gain_format = '{}{} ',
                loss_format = '({}{})',
                thousands_sep = ',',
                decimal_sep = '.',
                dictionary = {
                    "date": "Date",
                    "description": "Description",
                    "change": "Change",
                },
            )
        elif locale == 'nl_NL':
            return cls(
                date_format = "%d-%m-%Y",
                gain_format = '{} {} ',
                loss_format = '{} -{} ',
                thousands_sep = '.',
                decimal_sep = ',',
                dictionary = {
                    "date": "Datum",
                    "description": "Omschrijving",
                    "change": "Verandering",
                },
            )
        

class Formatter:

    def __init__(self, symbol: str, settings: FormatSettings):
        self.symbol = symbol
        self.settings = settings
        self.columns = {
            "date": (10, self.format_date),
            "description": (25, self.format_description),
            "change": (13, self.format_change),
        }

    def format_header_row(self):
        return ' | '.join(
            self.settings.dictionary[heading].ljust(width) 
            for heading, (width, _) in self.columns.items()
        )

    def format_entry_row(self, entry: LedgerEntry) -> str:
        return ' | '.join(
            format(entry, width) for width, format in self.columns.values()
        )

    def format_date(self, entry: LedgerEntry, width: int) -> str:
        return entry.date.strftime(self.settings.date_format).ljust(width)

    @staticmethod
    def format_description(entry: LedgerEntry, width: int) -> str:
        description = entry.description
        if len(description) > width:
            return description[:width-3] + '...'
        return description.ljust(width)

    def format_change(self, entry: LedgerEntry, width) -> str:
        change = entry.change
        amount = self.format_amount(change)
        result_format = self.settings.loss_format if change < 0 else self.settings.gain_format
        return result_format.format(self.symbol, amount).rjust(width)
    
    def format_amount(self, change: int) -> str:
        dollars, cents = divmod(abs(change), 100)
        dollar_parts = self.split_into_thousands(dollars)
        dollars_str = self.settings.thousands_sep.join(dollar_parts) or '0'
        return f"{dollars_str}{self.settings.decimal_sep}{cents:02}"

    @staticmethod
    def split_into_thousands(amount: int) -> list[str]:
        result = []
        while amount > 0:
            amount, part = divmod(amount, 1000)
            result.append(str(part))
        return result[::-1]
