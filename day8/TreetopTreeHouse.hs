import Data.List (transpose)

main :: IO()
main = do
       l <- readFile "input.txt"
       print . partOne $ l
      -- Your puzzle answer was 1803.
      
       print . partTwo $ l
      -- Your puzzle answer was 268912. 

parse :: String -> [[Int]]
parse input = map(\row -> map (\tree -> read [tree]::Int) row) $ lines input

partOne :: String -> Int
partOne input = solveOne matrix 
  where matrix = parse input

partTwo :: String -> Int
partTwo input = solveTwo matrix 
  where matrix = parse input

solveOne :: [[Int]] -> Int
solveOne matrix = count $ (funcOnMatrix (funcOnMatrix m1 r2 (||)) (funcOnMatrix r3 r4 (||)) (||))
  where m1 = visibleOnMatrix matrix
        m2 = visibleOnMatrix $ map reverse matrix
        m3 = visibleOnMatrix . transpose $ matrix
        m4 = visibleOnMatrix $ map reverse $ transpose matrix
        r2 = map reverse m2
        r3 = transpose m3
        r4 = transpose $ map reverse m4

solveTwo :: [[Int]] -> Int 
solveTwo matrix = maximum $ map(\row -> maximum row) (funcOnMatrix (funcOnMatrix m1 r2 (*)) (funcOnMatrix r3 r4 (*)) (*))
  where m1 = scoreOnMatrix matrix
        m2 = scoreOnMatrix $ map reverse matrix
        m3 = scoreOnMatrix . transpose $ matrix
        m4 = scoreOnMatrix $ map reverse $ transpose matrix
        r2 = map reverse m2
        r3 = transpose m3
        r4 = transpose $ map reverse m4

visibleOnRow :: Int -> [Int] -> [Bool]
visibleOnRow _ [] = []
visibleOnRow mx (tree : xs)
 | tree > mx = True : visibleOnRow tree xs
 | otherwise = False : visibleOnRow mx xs

visibleOnMatrix :: [[Int]] -> [[Bool]]
visibleOnMatrix matrix =  map (\row -> visibleOnRow (-1) row) matrix

scoreOnRow :: [Int] -> Int -> [Int]
scoreOnRow trees pos 
  | pos /= (length trees) = (score (trees !! pos) (reverse $ take pos trees)) : (scoreOnRow trees (pos + 1))
  | otherwise = []

score :: Int -> [Int] -> Int
score _ [] = 0
score tree (x:xs) 
  | x >= tree = 1
  | otherwise = 1 + score tree xs

scoreOnMatrix :: [[Int]] -> [[Int]]
scoreOnMatrix matrix = map (\row -> scoreOnRow row 0) matrix

funcOnList :: [a] -> [a] -> (a -> a -> a) -> [a]
funcOnList [] [] _= []
funcOnList (x1:xs1) (x2:xs2) f = (f x1 x2) : funcOnList xs1 xs2 f

funcOnMatrix :: [[a]] -> [[a]] -> (a -> a -> a) -> [[a]]
funcOnMatrix [] [] _= []
funcOnMatrix (row1:xs1) (row2:xs2) f = (funcOnList row1 row2 f) : funcOnMatrix xs1 xs2 f

count :: [[Bool]] -> Int
count m = sum $ map(length . filter(== True)) m

