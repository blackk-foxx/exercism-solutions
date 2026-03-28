import json

from collections import defaultdict
from typing import Iterable, Optional


class RestAPI:
    """
        REST API implementation
    """
    def __init__(self, database: dict) -> None:
        self.tracker = DebtTracker()
        for user in database["users"]:
            for lender, amount in user["owes"].items():
                self.tracker.add_debt(user["name"], lender, amount)

    def get(self, url: str, payload: Optional[str] = None) -> str:
        if url != "/users":
            raise ValueError
        arg = json.loads(payload or "{}")
        return json.dumps({
            "users": [
                self._get_user_data(user) for user in arg.get("users", [])
            ]
        })

    def post(self, url: str, payload: Optional[str] = None) -> str:
        arg = json.loads(payload or "{}")
        match url:
            case "/add":
                user = arg["user"]
                return json.dumps(self._get_user_data(user))
            case "/iou":
                lender = arg["lender"]
                borrower = arg["borrower"]
                amount = arg["amount"]
                self.tracker.add_debt(borrower, lender, amount)
                return json.dumps({
                    "users": [
                        self._get_user_data(user)
                        for user in sorted([lender, borrower])
                    ]
                })
            case _:
                raise ValueError

    def _get_user_data(self, user: str) -> dict:
        owes = {}
        owed_by = {}
        for other in self.tracker.get_users():
            amount = self.tracker.get_debt_amount(user, other)
            if amount > 0:
                owes[other] = amount
            elif amount < 0:
                owed_by[other] = -amount
        return {
            "name": user,
            "owes": owes,
            "owed_by": owed_by,
            "balance": self.tracker.get_user_balance(user)
        }


class DebtTracker(defaultdict):
    """
        Tracks the amounts owed by each user to another
    """
    def __init__(self) -> None:
        super().__init__(lambda: defaultdict(float))

    def get_users(self) -> Iterable[str]:
        return self.keys()
    
    def get_user_balance(self, name: str) -> float:
        return -sum(self[name].values())

    def get_debt_amount(self, borrower: str, lender: str) -> float:
        return self[borrower][lender]
    
    def add_debt(self, borrower: str, lender: str, amount: float) -> None:
        self[borrower][lender] += amount
        self[lender][borrower] -= amount
