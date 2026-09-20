module TreeBuilding

open TreeBuildingTypes

type Tree =
    | Node of id: int * children: Tree list

let recordId (Node (id, _)) = id

let isBranch (Node (_, children)) = children.Length > 0

let children (Node (_, children)) = children

let validate (sorted_records: Record list) =
    let root = sorted_records.[0]
    if (root.ParentId <> 0 || root.RecordId <> 0) then
        failwith "Root node is invalid"

    let mutable prev = -1
    sorted_records |> List.iter (
        fun r ->
            if (r.RecordId <> 0 && (r.ParentId > r.RecordId || r.ParentId = r.RecordId)) then
                failwith "Nodes with invalid parents"
            if r.RecordId <> prev + 1 then
                failwith "Non-continuous list"
            prev <- r.RecordId
    )
    sorted_records

let recordIdOfRecord r = r.RecordId

let buildTree records =
    let getParentId r = 
        match r.RecordId with
        | 0 -> -1
        | _ -> r.ParentId

    let convertChildRecordsToIds (parentId, childRecords) =
        (parentId, childRecords |> List.map recordIdOfRecord)

    let childrenForParent =
        records 
        |> List.sortBy recordIdOfRecord
        |> validate
        |> List.groupBy getParentId
        |> List.map convertChildRecordsToIds
        |> Map.ofSeq

    let rec buildTree id =
        match childrenForParent |> Map.tryFind id with
        | Some children -> Node (id, children |> List.map buildTree)
        | None -> Node (id, [])

    buildTree 0
