import Data.Maybe
import Data.Set

main = do
  content <- readFile "input"
  print $ part1 $ executeMoves (moves (content)) initialState


data Coordinate = Coordinate {
  x :: Int,
  y :: Int
                             } deriving (Ord, Eq)


  -- coordinates are (x,y)
data River = River {
  ropeHead :: Coordinate,
  ropeTail :: Coordinate,
  tailedSpots :: [Coordinate],
  gridSize :: Coordinate
                   }

type Move = String

moveHead :: River -> Move -> Maybe River
moveHead state "R"
  | (x (ropeHead state) + 1) > (x (gridSize state)) = Nothing
  | otherwise = Just River {
      ropeHead = Coordinate {x = x (ropeHead state) + 1, y = y (ropeHead state)},
      ropeTail = ropeTail state,
      tailedSpots = tailedSpots state,
      gridSize = gridSize state
                           }
moveHead state "L"
  | (x (ropeHead state) - 1) > (x (gridSize state)) = Nothing
  | otherwise = Just River {
      ropeHead = Coordinate {x = x (ropeHead state) - 1, y = y (ropeHead state)},
      ropeTail = ropeTail state,
      tailedSpots = tailedSpots state,
      gridSize = gridSize state
                           }
moveHead state "U"
  | (y (ropeHead state) + 1) > (y (gridSize state)) = Nothing
  | otherwise = Just River {
      ropeHead = Coordinate {y = y (ropeHead state) + 1, x = x (ropeHead state)},
      ropeTail = ropeTail state,
      tailedSpots = tailedSpots state,
      gridSize = gridSize state
                           }
moveHead state "D"
  | (y (ropeHead state) - 1) > (y (gridSize state)) = Nothing
  | otherwise = Just River {
      ropeHead = Coordinate {y = y (ropeHead state) - 1, x = x (ropeHead state)},
      ropeTail = ropeTail state,
      tailedSpots = tailedSpots state,
      gridSize = gridSize state
                           }

touching :: Coordinate -> Coordinate -> Bool
touching one two
  | x one == x two && y one == y two = True
  | x one == x two - 1 && y one == y two = True
  | x one == x two + 1 && y one == y two = True
  | x one == x two && y one == y two -1 = True
  | x one == x two && y one == y two + 1 = True
  | x one == x two + 1 && y one == y two -1 = True
  | x one == x two + 1 && y one == y two + 1 = True
  | x one == x two - 1 && y one == y two - 1 = True
  | x one == x two -1 && y one == y two + 1 = True
  | otherwise = False

adjustTail :: River -> River
adjustTail state
  | touching (ropeHead state) (ropeTail state) = state
  | x (ropeHead state) > x (ropeTail state) && y (ropeHead state) == y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state) + 1, y = y (ropeTail state)},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                                }
  | x (ropeHead state) < x (ropeTail state) && y (ropeHead state) == y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state) - 1, y = y (ropeTail state)},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                                }
  | x (ropeHead state) == x (ropeTail state) && y (ropeHead state) > y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state), y = y (ropeTail state) + 1},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                                }
  | x (ropeHead state) == x (ropeTail state) && y (ropeHead state) < y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state), y = y (ropeTail state) - 1},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                                }
  | x (ropeHead state) > x (ropeTail state) && y (ropeHead state) > y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state) + 1, y = y (ropeTail state) + 1},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                               }
  | x (ropeHead state) > x (ropeTail state) && y (ropeHead state) < y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state) + 1, y = y (ropeTail state) - 1},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                               }
  | x (ropeHead state) < x (ropeTail state) && y (ropeHead state) > y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state) - 1, y = y (ropeTail state) + 1},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                               }
  | x (ropeHead state) < x (ropeTail state) && y (ropeHead state) < y (ropeTail state) = River {
      ropeHead = ropeHead state,
      ropeTail = Coordinate {x = x (ropeTail state) - 1, y = y (ropeTail state) + 1},
      tailedSpots = ropeTail state : tailedSpots state,
      gridSize = gridSize state
                                                               }

processMove :: River -> (Int, String) -> River
processMove state (0,_) = state
processMove state (num,move) = processMove (adjustTail $ fromMaybe state (moveHead state move)) ((num - 1),move)

initialState = River {
          ropeHead = Coordinate {x = 0, y = 0},
          ropeTail = Coordinate {x = 0, y = 0},
          tailedSpots = [],
          gridSize = Coordinate {x=10000, y=10000} --I would actually rather not worry about this
             }


parseMove :: String -> (Int, String)
parseMove input = ((read::String->Int) y, x)
       where (x,y) = span (/=' ') input

moves input = Prelude.map parseMove (lines input)

executeMoves [] state = state
executeMoves (move:moves) state = executeMoves moves nextState
  where nextState = processMove state move

part1 state = size $ fromList $ tailedSpots state
