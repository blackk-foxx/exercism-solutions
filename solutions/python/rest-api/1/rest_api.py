from collections import defaultdict
import json
from typing import Iterable, Optional


class RestAPI:
    def __init__(self, database: dict):
        self.tracker = IouTracker()
        for user in database['users']:
            self.tracker.add_user(user['name'])
        for user in database['users']:
            for lender, amount in user['owes'].items():
                self.tracker.add_debt(user['name'], lender, amount)

    def get(self, url: str, payload: Optional[str] = None) -> str:
        if url != "/users":
            raise ValueError
        result = []
        if payload:
            arg = json.loads(payload)
            result = self._get_user_data(arg['users'])
        return json.dumps({'users': result})

    def post(self, url: str, payload: Optional[str] = None) -> str:
        arg = json.loads(payload or "{}")
        match url:
            case "/add":
                self.tracker.add_user(arg['user'])
                return json.dumps(self._get_user_data([arg['user']])[0])
            case "/iou":
                lender = arg['lender']
                borrower = arg['borrower']
                amount = arg['amount']
                self.tracker.add_debt(borrower, lender, amount)
                result = self._get_user_data(sorted([lender, borrower]))
                return json.dumps({'users': result})
            case _:
                raise ValueError

    def _get_user_data(self, users: list[str]) -> list[dict]:
        result = []
        for user in users:
            owes = {}
            owed_by = {}
            for other in self.tracker.get_users():
                amount = self.tracker.get_debt_amount(user, other)
                if amount > 0:
                    owes[other] = amount
                elif amount < 0:
                    owed_by[other] = -amount
            result.append({
                'name': user, 'owes': owes, 'owed_by': owed_by, 'balance': self.tracker.get_user_balance(user)
            })
        return result


class IouTracker:

    def __init__(self):
        self._users = {}

    def get_users(self) -> Iterable[str]:
        return self._users.keys()
    
    def add_user(self, name: str) -> None:
        self._users[name] = defaultdict(float, {})

    def get_user_balance(self, name: str) -> float:
        return -sum(v for v in self._users[name].values())

    def get_debt_amount(self, borrower: str, lender: str) -> float:
        return self._users[borrower][lender]
    
    def add_debt(self, borrower: str, lender: str, amount: float) -> None:
        self._users[borrower][lender] += amount
        self._users[lender][borrower] -= amount

