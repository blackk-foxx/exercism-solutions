module TreeBuilding

open TreeBuildingTypes

type Node = { id: int; children: Node list }

type Tree = Node

let recordId n  = n.id

let isBranch n = n.children.Length > 0

let children n = n.children

let validateRecords (sorted_records: Record list): Record list =
    let root = sorted_records.[0]
    if (root.ParentId <> 0 || root.RecordId <> 0) then
        failwith "Root node is invalid"

    sorted_records[1..] |> List.iteri (
        fun i r ->
            let expectedId = i + 1
            if (r.ParentId > r.RecordId || r.ParentId = r.RecordId) then
                failwith "Nodes with invalid parents"
            if r.RecordId <> expectedId then
                failwith "Non-continuous list"
    )
    sorted_records

let recordIdOfRecord r = r.RecordId

let parentIdOfRecord r =
    match r.RecordId with
    | 0 -> -1
    | _ -> r.ParentId

let buildTree (records: Record list): Tree =
    let reduceChildRecordsToIds (parentId, childRecords) =
        (parentId, childRecords |> List.map recordIdOfRecord)

    let childIdsForParent =
        records 
        |> List.sortBy recordIdOfRecord
        |> validateRecords
        |> List.groupBy parentIdOfRecord
        |> List.map reduceChildRecordsToIds
        |> Map.ofSeq

    let rec buildTree parentId =
        match childIdsForParent |> Map.tryFind parentId with
        | Some childIds -> { id = parentId; children = childIds |> List.map buildTree }
        | None -> { id = parentId; children = [] }

    buildTree 0
