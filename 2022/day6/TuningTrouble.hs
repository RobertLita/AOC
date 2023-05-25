import Data.List

main :: IO()
main = do
       l <- readFile "input.txt"
       print . partOne $ l
      -- Your puzzle answer was 1034.

       print . partTwo $ l
      -- Your puzzle answer was 2472.

partOne :: String -> Int
partOne s = solve s 4

partTwo :: String -> Int
partTwo s = solve s 14

solve :: String -> Int -> Int
solve s x 
  | (length . nub $ take x s) == x = x
  | otherwise = 1 + solve (drop 1 s) x