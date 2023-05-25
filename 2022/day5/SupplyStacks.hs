-- painful experience :/

import Data.Char (isDigit, isLetter)
import Data.List (transpose)

main :: IO()
main = do
       l <- readFile "input.txt"
       print . partOne $ l
      -- Your puzzle answer was GRTSWNJHH.

       print . partTwo $ l
      -- Your puzzle answer was QLFQDBBHM.
    

parseMoves :: [String] -> [(Int, Int, Int)]
parseMoves (x : xs)
  | x == "" = []
  | otherwise = parseInts x : parseMoves xs


parseInts :: String -> (Int, Int, Int)
parseInts xs = (n, f-1, s-1)
    where (n:f:s:_) = map read [x | x <- words xs, isDigit (x !! 0)]


parseStacks :: [String] -> [String]
parseStacks ((_ : '1' : _) : _) = []
parseStacks (h : t) = (parseStack h) : parseStacks t
  where parseStack :: String -> String
        parseStack (p1 : x : p2 : "") = x : ""
        parseStack (p1 : x : p2 : s : xs) = x : parseStack xs 


move :: (String -> String) -> [(Int, Int, Int)] -> [String] -> [String]
move f [] ss = ss
move f ((k, i1, i2) : xs) ss = move f xs elemMoved
  where s1 = ss !! i1
        s2 = ss !! i2 
        newS2 = f (take k s1) ++ s2 
        newS1 = drop k s1 
        elemMoved = map(\(i, s) -> 
            if i == i1 then newS1
            else if i == i2 then newS2
            else s) $ zip [0..] ss


partOne :: String -> String
partOne x = map head $ move reverse m s
  where m = reverse . parseMoves . reverse . lines $ x
        s = map(\x -> filter(\y -> y /= ' ') x) . transpose . parseStacks . lines $ x


partTwo :: String -> String
partTwo x = map head $ move (\x -> x) m s
  where m = reverse . parseMoves . reverse . lines $ x
        s = map(\x -> filter(\y -> y /= ' ') x) . transpose . parseStacks . lines $ x
