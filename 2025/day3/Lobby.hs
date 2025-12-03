-- painful experience :/

largestBattery :: [(Char, Int)] -> (Char, Int)
largestBattery [_] = ('0', 0)
largestBattery (rating : rest) = max rating (largestBattery rest)

secondLargestBattery :: [(Char, Int)] -> Int -> Char
secondLargestBattery [] _ = '0'
secondLargestBattery ((rating, currentPos) : rest) pos
    | currentPos < pos = max rating (secondLargestBattery rest pos)
    | otherwise = secondLargestBattery rest pos

getLargestJoltage :: String -> Int
getLargestJoltage ratings =
    let pairs = zip ratings [100, 99..0]
        (firstMaxBattery, pos) = largestBattery pairs
        maxBattery = read [firstMaxBattery] :: Int
        secondMaxBattery = read [secondLargestBattery pairs pos] :: Int
    in maxBattery * 10 + secondMaxBattery

digitsFromPair :: Int -> [Int]
digitsFromPair x = map (read . (:[])) (show x)

removeUsedDigits :: String -> [Int] -> String
removeUsedDigits s [] = s
removeUsedDigits [] _ = []
removeUsedDigits (c:cs) (x:xs)
  | read [c] == x = removeUsedDigits cs xs       
  | otherwise     = removeUsedDigits cs (x:xs) 


largestSubsequence :: String -> Integer
largestSubsequence k = read result
  where
    window remaining i
      | i < 6     = take (length remaining - (12 - 2*i)) remaining
      | otherwise = remaining  

    w1 = window k 1
    x1 = getLargestJoltage w1
    k1 = removeUsedDigits k (digitsFromPair x1)

    w2 = window k1 2
    x2 = getLargestJoltage w2
    k2 = removeUsedDigits k1 (digitsFromPair x2)

    w3 = window k2 3
    x3 = getLargestJoltage w3
    k3 = removeUsedDigits k2 (digitsFromPair x3)

    w4 = window k3 4
    x4 = getLargestJoltage w4
    k4 = removeUsedDigits k3 (digitsFromPair x4)

    w5 = window k4 5
    x5 = getLargestJoltage w5
    k5 = removeUsedDigits k4 (digitsFromPair x5)

    w6 = window k5 6
    x6 = getLargestJoltage w6

    result = show x1 ++ show x2 ++ show x3 ++ show x4 ++ show x5 ++ show x6

partOne :: [String] -> Int
partOne batteryRatings = sum $ map getLargestJoltage batteryRatings

partTwo :: [String] -> Integer
partTwo batteryRatings = sum $ map largestSubsequence batteryRatings

main :: IO ()
main = do
    content <- readFile "input.txt"
    let batteryRatings = lines content
    print $ partOne batteryRatings
    -- Your puzzle answer was 17324.

    print $ partTwo batteryRatings
    -- Your puzzle answer was 171846613143331.
