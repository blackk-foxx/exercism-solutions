from dataclasses import dataclass
from typing import Iterator


@dataclass
class Record:
    record_id: int
    parent_id: int


class Node:
    def __init__(self, node_id: int) -> None:
        self.node_id = node_id
        self.children = []


def validate(records: list[Record]) -> None:
    if records:
        if records[-1].record_id != len(records) - 1:
            raise ValueError('Record id is invalid or out of order.')
    for r in records:
        if r.record_id < r.parent_id:
            raise ValueError("Node parent_id should be smaller than it's record_id.")
        if r.record_id == r.parent_id and r.record_id != 0:
            raise ValueError("Only root should have equal record and parent id.")


def get_child_records(parent_id: int, records: list[Record]) -> Iterator[Record]:
    return filter(lambda r: r.parent_id == parent_id, records)


def get_nonzero_ids(records: list[Record]) -> list[int]:
    return [r.record_id for r in records if r.record_id != 0]


def BuildTree(records: list[Record]) -> Node:
    records.sort(key=lambda x: x.record_id)
    validate(records)
    tree_for_id = {r.record_id: Node(r.record_id) for r in records}
    for parent_id, parent_node in tree_for_id.items():
        child_ids = get_nonzero_ids(get_child_records(parent_id, records))
        parent_node.children = [tree_for_id[id] for id in child_ids]
    return tree_for_id.get(0, None)
