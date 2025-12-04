-- brutal brute force

getCell :: Int -> Int -> [String] -> Maybe Char
getCell x y grid
    | x < 0 || x >= n = Nothing
    | y < 0 || y >= m = Nothing
    | otherwise       = Just ((grid !! x) !! y)
  where
    n = length grid
    m = length (head grid)


canAccess :: [String] -> Int -> Int -> Bool
canAccess grid xpos ypos =
    let n = length grid
        m = length (head grid)
        
        neighbors = [(xpos-1, ypos-1), (xpos-1, ypos), (xpos-1, ypos+1), (xpos, ypos-1), 
                    (xpos, ypos+1), (xpos+1, ypos-1), (xpos+1, ypos), (xpos+1, ypos+1)]

        countAt = length [ (x, y) | (x, y) <- neighbors, getCell x y grid == Just '@' ]
    in countAt < 4  

removeCell :: [String] -> Int -> Int -> [String]
removeCell grid xpos ypos = take xpos grid ++ [replaceChar (grid !! xpos) ypos 'x'] ++ drop (xpos + 1) grid
  where
    replaceChar :: String -> Int -> Char -> String
    replaceChar row i c = take i row ++ [c] ++ drop (i + 1) row

removeAccessible :: [String] -> ([String], Int)
removeAccessible grid =
    let n = length grid
        m = length (head grid)

        positions = [ (x, y) 
                    | x <- [0..n-1]
                    , y <- [0..m-1]
                    , (grid !! x) !! y == '@'
                    , canAccess grid x y ]
                    
        newGrid = foldl (\g (x,y) -> removeCell g x y) grid positions

        removedCount = length positions
    in (newGrid, removedCount)

partOne :: [String] -> Int
partOne grid = 
    let n = length grid
        m = length (head grid)
        accessedElements = [canAccess grid x y | x <- [0..n-1], y <- [0..m-1], (grid !! x) !! y == '@']
    in length $ filter (==True) accessedElements

partTwo :: [String] -> Int
partTwo grid =
    let (nextGrid, removed) = removeAccessible grid
    in if removed == 0
       then 0
       else removed + partTwo nextGrid

main :: IO ()
main = do
    content <- readFile "input.txt"
    let grid = lines content
    print $ partOne grid
    -- Your puzzle answer was 1393.

    print $ partTwo grid
    -- Your puzzle answer was 8643.