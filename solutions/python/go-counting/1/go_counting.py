from itertools import product, chain


WHITE = "W"
BLACK = "B"
NONE = ""

class Region:

    def __init__(self):
        self.area = set()
        self.border = set()

    def get_owner(self, board):
        border_owners = set(board[y][x] for x, y in self.border)
        if len(border_owners) == 1:
            return border_owners.pop()
        return NONE
    

class Board:
    """Count territories of each player in a Go game

    Args:
        board (list[str]): A two-dimensional Go board
    """

    def __init__(self, board):
        self.board = board
        self.width = len(board[0])
        self.height = len(board)
        self.regions = self.find_regions()

    def find_regions(self):
        regions = []
        all_locations = set(self.get_all_locations())
        available_locations = set(filter(self.has_no_stone, all_locations))
        occupied_locations = all_locations - available_locations
        while available_locations:
            regions.append(self.gather_next_region(available_locations, occupied_locations))
        return regions

    def gather_next_region(self, available_locations, occupied_locations):
        region = Region()
        new_members = set([available_locations.pop()])
        while new_members:
            region.area |= new_members
            available_neighbors = self.find_neighbors_for_group(new_members, available_locations)
            occupied_neighbors = self.find_neighbors_for_group(new_members, occupied_locations)
            available_locations -= available_neighbors
            new_members = available_neighbors
            region.border |= occupied_neighbors
        return region
    
    def find_neighbors_for_group(self, locations, pool):
        return set(chain(*(self.find_neighbors(loc, pool) for loc in locations)))

    @staticmethod
    def find_neighbors(loc, pool):
        result = set()
        x, y = loc
        for dx, dy in ((1, 0), (0, 1), (-1, 0), (0, -1)):
            if (x + dx, y + dy) in pool:
                result.add((x + dx, y + dy))
        return result
    
    def has_no_stone(self, location):
        x, y = location
        return self.board[y][x] == " "

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
        for owner in (WHITE, BLACK, NONE):
            owned_regions = self.get_owned_regions(owner)
            for region in owned_regions:
                if (x, y) in region.area:
                    return owner, region.area
        return NONE, set()

    
    def territories(self):
        """Find the owners and the territories of the whole board

        Args:
            none

        Returns:
            dict(str, set): A dictionary whose key being the owner
                        , i.e. "W", "B", "".  The value being a set
                        of coordinates owned by the owner.
        """
        return {owner: set(chain(*(r.area for r in self.get_owned_regions(owner)))) 
                for owner in (WHITE, BLACK, NONE)}

    def get_owned_regions(self, owner):
        return (r for r in self.regions if r.get_owner(self.board) == owner)

    def get_all_locations(self):
        return product(range(self.width), range(self.height))
    
    def validate(self, x, y):
        if not (0 <= x < self.width and 0 <= y < self.height):
            raise ValueError("Invalid coordinate")
