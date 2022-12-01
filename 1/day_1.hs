numberify = map (map readInt)

-- toBeProcessed currentCalorie currentElf SeenSoFar
elves :: String -> String -> [String] -> [[String]]
elves "" _ _ = []
elves (x:xs) currentCalorie currentElf
  | x == '\n' && currentCalorie /= "" = elves xs "" (currentCalorie : currentElf)
  | x == '\n' = currentElf : elves xs "" []
  | otherwise = elves xs (currentCalorie ++ [x]) currentElf

readInt :: String -> Int
readInt = read


topThree :: [Int] -> [Int]
topThree list
  | length list == 3 = list
  | otherwise = topThree (remove (minimum list) list)

remove :: Int -> [Int] -> [Int]
remove _ [] = []
remove a (x:xs)
  | x == a = xs
  | otherwise = x : remove a xs

func :: [Int] -> [Int]
func [] = []
func (x:xs) = x + 1 : func xs
