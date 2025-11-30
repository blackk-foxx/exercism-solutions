module RobotSimulator

type Direction = 
    | North = 0 
    | East  = 1 
    | South = 2 
    | West  = 3

let offsetForDirection = Map.ofList [
    (Direction.North, (0, 1)); 
    (Direction.East, (1, 0)); 
    (Direction.South, (0, -1)); 
    (Direction.West, (-1, 0))
]

type Position = int * int
type Robot = { Direction: Direction; Position: Position }

let create direction position = { Direction = direction; Position = position }

let rotate increment direction = 
    let dirInt = (int direction + increment) % 4
    enum<Direction> dirInt

let turnLeft (robot: Robot) : Robot =
    { robot with Direction = rotate 3 robot.Direction }

let turnRight (robot: Robot) : Robot =
    { robot with Direction = rotate 1 robot.Direction }

let advance robot = 
    let x, y = robot.Position
    let dx, dy = offsetForDirection[robot.Direction]
    { robot with Position = (x + dx, y + dy)}

let rec move instructions robot = 
    match instructions with
    | "" -> robot
    | _ -> 
        let movedRobot = 
            match instructions[0] with
            | 'L' -> turnLeft robot
            | 'R' -> turnRight robot
            | 'A' -> advance robot
            | _ -> robot
        move instructions[1..] movedRobot
