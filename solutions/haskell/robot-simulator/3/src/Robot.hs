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
             deriving (Eq, Ord, Enum, Show)

data Robot = Robot {bearing :: Bearing, coordinates :: (Integer, Integer)}

offset_for_bearing = fromList [
  (North, (0, 1)), (West, (-1, 0)), (South, (0, -1)), (East, (1, 0))]

offset_for_turn_dir = fromList [('L', -1), ('R', 1)]

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot heading position = Robot heading position

move :: Robot -> String -> Robot
move robot [] = robot
move robot (x:xs) = move (do_instruction x) xs
  where
  do_instruction 'A' = advance robot
  do_instruction dir = turn robot dir
  turn (Robot heading (x, y)) dir = Robot (rotate heading dir) (x, y)
    where
    rotate bearing dir = toEnum . (flip mod 4) $ fromEnum bearing + offset
      where
      offset = offset_for_turn_dir ! dir
  advance (Robot heading (x, y)) = Robot heading (x + dx, y + dy)
    where
    (dx, dy) = offset_for_bearing ! heading
