"""
    Camicia exercise solution
"""

from collections import deque

PENALTY_FOR_FACE_CARD = {
    "J": 1,
    "Q": 2,
    "K": 3,
    "A": 4,
}


class GameSimulator:
    """
        Camicia game simulator
    """

    class StateTracker:
        """
            Keeps track of the game states and detects when a duplicate state was found.
        """
        
        def __init__(self):
            self.states = set()
            self._duplicate_found = False

        @property
        def duplicate_found(self):
            """
                True when a duplicate state was attempted to be added.
            """
            return self._duplicate_found

        def add_state(self, decks):
            """
                Add a game state to the tracker.
            """
            state = tuple(
                self._normalized_deck(deck) for deck in decks
            )
            if state in self.states:
                self._duplicate_found = True
            else:
                self.states.add(state)

        @staticmethod
        def _normalized_deck(deck):
            return tuple(
                PENALTY_FOR_FACE_CARD.get(card) for card in deck
            )

    def __init__(self, player_a, player_b):
        self.players = [deque(player_a), deque(player_b)]
        self.pile = deque()
        self.next_player = 0
        self.tricks = 0
        self.cards = 0
        self.penalty_owed = 0
        self.state_tracker = self.StateTracker()
        self.state_tracker.add_state(self.players)

    @property
    def is_over(self):
        """
            True when the game is complete.
        """
        return len(self.pile) == 0 and any(
            len(deck) == 0 for deck in self.players
        )
    
    @property
    def loop_found(self):
        """
            True when a loop has been discovered.
        """
        return self.state_tracker.duplicate_found
    
    def complete_next_turn(self):
        """
            Simulate the next turn in the game.
        """
        if len(self.players[self.next_player]) == 0:
            self._bump_next_player()
            self._complete_trick()
        else:
            self._complete_play()

    def get_stats(self):
        """
            Get the stats for the game.
        """
        status = "loop" if self.state_tracker.duplicate_found else "finished"
        return {
            "status": status,
            "cards": self.cards,
            "tricks": self.tricks
        }

    def _complete_trick(self):
        self.players[self.next_player].extend(self.pile)
        self.pile.clear()
        self.tricks += 1
        self.state_tracker.add_state(self.players)

    def _complete_play(self):
        card = self.players[self.next_player].popleft()
        self.pile.append(card)
        self.cards += 1
        if penalty := PENALTY_FOR_FACE_CARD.get(card):
            self.penalty_owed = penalty
            self._bump_next_player()
        elif self.penalty_owed:
            self.penalty_owed -= 1
            if self.penalty_owed == 0:
                self._bump_next_player()
                self._complete_trick()
        else:
            self._bump_next_player()

    def _bump_next_player(self):
        self.next_player = (self.next_player + 1) % 2


def simulate_game(player_a, player_b):
    """
        Simulate a Camicia game given card decks for two players.
    """
    game = GameSimulator(player_a, player_b)
    while not game.is_over and not game.loop_found:
        game.complete_next_turn()
    return game.get_stats()
