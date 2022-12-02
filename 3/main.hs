import Data.Set
import Data.Char

main = do
  content <- readFile "input"
  print $ part1 content
  print $ part2 content

getDuplicate :: Set Char -> String -> Char
getDuplicate firstHalf (x:xs)
  | member x firstHalf = x
  | otherwise = getDuplicate firstHalf xs
getDuplicate _ [] = ' '

singleBag :: String -> Char
singleBag bag = getDuplicate (fromList (Prelude.take halfIndex bag)) (Prelude.drop halfIndex bag)
        where halfIndex = div (length bag) 2

getPriority :: Char -> Int
getPriority character
  | character >= 'a' && character <= 'z' = 1 + ord character - ord 'a'
  | character >= 'A' && character <= 'Z' = 27 + ord character - ord 'A'

part1 :: String -> Int
part1 input = sum(Prelude.map getPriority (Prelude.map singleBag (lines input)))

threeBags :: Set Char -> Set Char -> String -> Char
threeBags a b (c:cs)
  | member c a && member c b = c
  | otherwise = threeBags a b cs

allTheBags :: [String] -> Int
allTheBags (a:b:c:rest) = (getPriority (threeBags (fromList a) (fromList b) c)) + allTheBags rest
allTheBags _ = 0

part2 = allTheBags.lines
