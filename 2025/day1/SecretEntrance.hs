splitTurns :: String -> Int
splitTurns (d:n)
    | d == 'R'  = read n
    | d == 'L'  = - read n
    | otherwise = 0
splitTurns _ = 0

modularAdd :: Int -> Int -> Int
modularAdd x y = mod (x + y) 100

runTurns :: [String] -> [Int]
runTurns l =
    scanl modularAdd 50 (map splitTurns l)

part1 :: [Int] -> Int
part1 l = length [ total | total <- l, total == 0 ]

expand :: String -> [Int]
expand (d:n)
    | d == 'R' = replicate (read n) 1
    | d == 'L' = replicate (read n) (-1)
    | otherwise = [0]
expand _ = [0]

main :: IO ()
main = do
    input <- readFile "input.txt"
    let rotations = lines input  
    let turns = runTurns rotations

    let result1 = part1 turns
    putStrLn $ "Part 1: " ++ show result1

    let result2 = part1 (scanl modularAdd 50 (concatMap expand rotations))
    putStrLn $ "Part 2: " ++ show result2