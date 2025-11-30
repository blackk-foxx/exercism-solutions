from collections import defaultdict
from itertools import product, chain


WHITE = "W"
BLACK = "B"
NONE = " "


class Board:
    """Count territories of each player in a Go game

    Args:
        board (list[str]): A two-dimensional Go board
    """

    def __init__(self, board):
        self.board = board
        self.width = len(board[0])
        self.height = len(board)

    def find_owner_and_region_containing_loc(self, x, y):
        possible_new_members = set([(x, y)])
        region = set()
        owners = set()
        while possible_new_members:
            x, y = possible_new_members.pop()
            if (owner := self.board[y][x]) == NONE:
                region.add((x, y))
                possible_new_members |= set(self.get_neighbors(x, y)) - region
            else:
                owners.add(owner)
        if len(owners) == 1 and region:
            return owners.pop(), region
        else:
            return NONE, region
    
    def get_neighbors(self, x, y):
        return (
            (x + dx, y + dy)
            for dx, dy in ((1, 0), (0, 1), (-1, 0), (0, -1))
            if self.is_in_bounds(x + dx, y + dy)
        )
    
    def is_in_bounds(self, x, y):
        return 0 <= x < self.width and 0 <= y < self.height
    
    def territory(self, x, y):
        """Find the owner and the territories given a coordinate on
           the board

        Args:
            x (int): Column on the board
            y (int): Row on the board

        Returns:
            (str, set): A tuple, the first element being the owner
                        of that area.  One of "W", "B", "".  The
                        second being a set of coordinates, representing
                        the owner's territories.
        """
        self.validate(x, y)
        return self.find_owner_and_region_containing_loc(x, y)

    
    def territories(self):
        """Find the owners and the territories of the whole board

        Args:
            none

        Returns:
            dict(str, set): A dictionary whose key being the owner
                        , i.e. "W", "B", "".  The value being a set
                        of coordinates owned by the owner.
        """
        regions_for_owner = defaultdict(set)
        unoccupied_locations = filter(self.has_no_stone, self.get_all_locations())
        for x, y in unoccupied_locations:
            owner, region = self.territory(x, y)
            regions_for_owner[owner] |= region

        return {owner: regions_for_owner[owner] for owner in (WHITE, BLACK, NONE)}

    def has_no_stone(self, loc):
        x, y = loc
        return self.board[y][x] == NONE

    def get_all_locations(self):
        return product(range(self.width), range(self.height))
    
    def validate(self, x, y):
        if not self.is_in_bounds(x, y):
            raise ValueError("Invalid coordinate")
