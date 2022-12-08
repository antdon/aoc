main = do
  content <- readFile "input"
  print $ part1 content
  print $ part2 content

parse :: String -> [Int]
parse [] = []
parse input
  | y == [] = [readInt x]
  | otherwise = (readInt x) : parse (tail y)
  where (x,y) = span (\a -> (a/=',') && (a/='-')) input

readInt :: String -> Int
readInt = read

encompass [a,b,c,d]
   | a >= c && b <= d = True
   | a <= c && b >= d = True
   | otherwise = False

overlap [a,b,c,d]
  | b >= c && d >= a = True
  | otherwise = False

part1 input = length $ filter encompass $ map parse (lines input)
part2 input = length $ filter overlap $ map parse (lines input)
