from itertools import pairwise, permutations, product

Tile = tuple[int, int]

def can_chain(dominoes: list[Tile]) -> None | list[Tile]:
    '''
        If the given set of dominoes can be arranged in a complete chain,
        then return the chain; otherwise return None.
    '''
    if not dominoes:
        return []

    # For search simplicity, treat each combination of tile orientations 
    # as a different set of tiles. For example, [(1, 2), (2, 2)] and
    # [(2, 1), (2, 2)] are counted as distinct tile sets.
    orientations_per_tile = [get_orientations(d) for d in dominoes]
    for tile_set in product(*orientations_per_tile):
        for chain in permutations(tile_set, len(tile_set)):
            if is_complete_chain(chain):
                return chain
    return None


def get_orientations(tile: Tile) -> list[Tile]:
    '''
        Return the set of possible orientations for the given tile.
    '''
    return set([(tile[0], tile[1]), (tile[1], tile[0])])
    

def is_complete_chain(chain: list[Tile]) -> bool:
    '''
        Tell whether the given chain is complete.
    '''
    if chain[0][0] != chain[-1][1]:
        return False
    for link1, link2 in pairwise(chain):
        if link1[1] != link2[0]:
            return False
    return True
