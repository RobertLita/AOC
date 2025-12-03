import Data.List.Split (splitOn)
import qualified Data.Set as Set

parseInput :: String -> [(Integer, Integer)]
parseInput x = [(read l, read r) | item <- splitOn "," x, let [l, r] = splitOn "-" item]

isInside :: [(Integer, Integer)] -> Integer -> Integer
isInside [] elem = 0
isInside ((l, d) : xs) elem
    | l <= elem && elem <= d = elem
    | otherwise = isInside xs elem

doubleUntil :: Integer -> [Integer]
doubleUntil n = takeWhile (<= 10^11) $ tail $ iterate (\x -> read (show x ++ show n)) n

partOne :: [(Integer, Integer)] -> Integer
partOne intervals = sum $ map (isInside intervals) $ map (\x -> read (show x ++ show x)) [1..100000] 

partTwo :: [(Integer,Integer)] -> Integer
partTwo intervals = sum $ map (isInside intervals) uniqueDoubles
  where
    allDoubles = concatMap doubleUntil [1..100000]
    uniqueDoubles = Set.toList $ Set.fromList allDoubles


main :: IO ()
main = do
    content <- readFile "input.txt"
    print $ partOne $ parseInput content
    -- Your puzzle answer was 13108371860.

    print $ partTwo $ parseInput content
    -- Your puzzle answer was 22471660255.
