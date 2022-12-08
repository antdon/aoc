main = do
  content <- readFile "input"
  print $ part1 content
  --print $ part2 content

  print "y0o"

  -- a tree is visible if it's bigger than the max of the tree's in the row so far
  -- trees -> max -> count
visible :: [Int] -> Int -> Int
visible [] _ = 0
visible (x:xs) max
  | x > max = 1 + visible xs x
  | otherwise = visible xs max

part1 input =  map (map readInt) input

readInt :: Char -> Int
readInt input = read [input]
