"""
    BankAccount exercise solution.
"""

class BankAccount:
    """
        Bank account.
    """
    def __init__(self) -> None:
        self.balance = 0
        self.is_open = False

    def get_balance(self) -> int:
        """
            Get the current balance.
        """
        self._assert_is_open()
        return self.balance

    def open(self) -> None:
        """
            Open the account.
        """
        if self.is_open:
            raise ValueError("account already open")
        self.balance = 0
        self.is_open = True

    def deposit(self, amount: int) -> None:
        """
            Deposit money.
        """
        self._assert_is_open()
        self._validate_amount(amount)
        self.balance += amount

    def withdraw(self, amount: int) -> None:
        """
            Withdraw money.
        """
        self._assert_is_open()
        self._validate_amount(amount)
        if amount > self.balance:
            raise ValueError("amount must be less than balance")
        self.balance -= amount

    def close(self) -> None:
        """
            Close the account.
        """
        self._assert_is_open()
        self.is_open = False

    def _assert_is_open(self) -> None:
        if not self.is_open:
            raise ValueError("account not open")

    @staticmethod
    def _validate_amount(amount) -> None:
        if amount <= 0:
            raise ValueError("amount must be greater than 0")
            
