"""
    Satellite exercise solution.
"""

def tree_from_traversals(preorder: list[str], inorder: list[str]) -> dict:
    """
        Generate a tree from the given pre-order and in-order traversals.
        Raise a ValueError if a tree cannot be built from the given inputs.
    """
    if len(set(preorder)) != len(preorder):
        raise ValueError("traversals must contain unique items")
    if len(preorder) != len(inorder):
        raise ValueError("traversals must have the same length")
    if set(preorder) != set(inorder):
        raise ValueError("traversals must have the same elements")
    return build_tree(preorder, inorder)


def build_tree(preorder: list[str], inorder: list[str]) -> dict:
    """
        Generate a tree from the given pre-order and in-order traversals, in the form
        {"v": value, "l": left, "r": right}.
    """
    if len(preorder) == 0: 
        return {}
    root = preorder[0]
    root_pos = inorder.index(root)
    right_start_pos = root_pos + 1
    left = tree_from_traversals(preorder[1:right_start_pos], inorder[:root_pos])
    right = tree_from_traversals(preorder[right_start_pos:], inorder[right_start_pos:])
    return {"v": root, "l": left, "r": right}
