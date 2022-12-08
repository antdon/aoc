import Data.Set

main = do
  content <- readFile "input"
  print $ part1 content
  print $ part2 content

detect :: String -> Int
detect (a:b:c:d:rest)
  | size (fromList elements) == length elements = 4
  | otherwise = 1 + detect (b:c:d:rest)
  where elements = [a,b,c,d]

detect' :: String -> Int
detect' rest
  | size (fromList elements) == length elements = 14
  | otherwise = 1 + (detect' (Prelude.drop 1 rest))
  where elements = Prelude.take 14 rest

part1 = detect
part2 = detect'
