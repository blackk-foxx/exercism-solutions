module Robot
    ( Bearing(East,North,South,West)
    , bearing
    , coordinates
    , mkRobot
    , move
    ) where

import Data.Map

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Ord, Show)

data Robot = Robot {bearing :: Bearing, coordinates :: (Integer, Integer)}

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot heading position = Robot heading position

turn_right :: Bearing -> Bearing
turn_right North = East
turn_right East = South
turn_right South = West
turn_right West = North

turn_left :: Bearing -> Bearing
turn_left North = West
turn_left West = South
turn_left South = East
turn_left East = North

move :: Robot -> String -> Robot
move (Robot heading position) "L" = Robot (turn_left heading) position
move (Robot heading position) "R" = Robot (turn_right heading) position
move (Robot heading (x, y)) "A" = Robot heading (x + dx, y + dy)
  where
    (dx, dy) = offset_for_bearing ! heading
    offset_for_bearing = fromList [
      (North, (0, 1)), (West, (-1, 0)), (South, (0, -1)), (East, (1, 0))]
move robot (x:xs) = move (move robot [x]) xs

