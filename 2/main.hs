import Data.List

main = do
  content <- readFile "input"
  print $ part1 content
  print $ part2 content


part1 content = sum $ map processTuple (map splitUp (lines content))
part2 content = sum $ map processTuple' (map splitUp (lines content))

processTuple :: [String] -> Int
processTuple ["A", "X"] = 1 + 3
processTuple ["B", "X"] = 1 + 0
processTuple ["C", "X"] = 1 + 6
processTuple ["A", "Y"] = 2 + 6
processTuple ["B", "Y"] = 2 + 3
processTuple ["C", "Y"] = 2 + 0
processTuple ["A", "Z"] = 3 + 0
processTuple ["B", "Z"] = 3 + 6
processTuple ["C", "Z"] = 3 + 3

processTuple' :: [String] -> Int
processTuple' ["A", "X"] = 3 + 0
processTuple' ["B", "X"] = 1 + 0
processTuple' ["C", "X"] = 2 + 0
processTuple' ["A", "Y"] = 1 + 3
processTuple' ["B", "Y"] = 2 + 3
processTuple' ["C", "Y"] = 3 + 3
processTuple' ["A", "Z"] = 2 + 6
processTuple' ["B", "Z"] = 3 + 6
processTuple' ["C", "Z"] = 1 + 6




splitUp [] = []
splitUp line
  | y /= [] = x : splitUp (tail y)
  | otherwise = [x]
        where (x,y) = span (/=' ') line
