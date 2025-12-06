import Data.List (sortOn)

parseInterval :: String -> (Int, Int)
parseInterval s =
    let (a, _ : b) = span (/= '-') s
    in (read a, read b)

isInside :: [(Int, Int)] -> Int -> Bool
isInside [] _ = False
isInside ((left, right) : rest) id 
    | left <= id && id <= right = True
    | otherwise = isInside rest id

partOne :: [(Int, Int)] -> [Int] -> Int
partOne intervals ids = sum $ map (\x -> if isInside intervals x then 1 else 0) ids

intervalToEvents :: (Int, Int) -> [(Int, Int)]
intervalToEvents (l, r) = [(l, 1), (r + 1, -1)]

makeEvents :: [(Int, Int)] -> [(Int, Int)]
makeEvents intervals = sortOn fst (concatMap intervalToEvents intervals)

sweepEvents :: [(Int, Int)] -> Int
sweepEvents [] = 0
sweepEvents events = go (fst (events !! 1)) 0 0 events
  where
    go :: Int -> Int -> Int -> [(Int, Int)] -> Int
    go _ _ acc [] = acc
    go prev active acc ((pos, delta):rest)
        | active > 0  = go pos (active + delta) (acc + (pos - prev)) rest
        | otherwise   = go pos (active + delta) acc rest

partTwo :: [(Int, Int)] -> Int
partTwo intervals = sweepEvents (makeEvents intervals)

main :: IO ()
main = do
    content <- readFile "input.txt"
    let input = lines content
    let (intervalLines, rest) = span (/= "") input

    let ids = map read (drop 1 rest) :: [Int]
    let intervals = map parseInterval intervalLines

    print $ partOne intervals ids
    -- Your puzzle answer was 520.

    print $ partTwo intervals
    -- Your puzzle answer was 347338785050515.
