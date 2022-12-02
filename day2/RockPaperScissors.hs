module Main where

import System.IO


losingShape :: Char -> Char
losingShape 'X' = 'Y'
losingShape 'Y' = 'Z'
losingShape 'Z' = 'X'

winningShape :: Char -> Char
winningShape 'X' = 'Z'
winningShape 'Y' = 'X'
winningShape 'Z' = 'Y'

scoreShape :: Char -> Int
scoreShape 'X' = 1
scoreShape 'Y' = 2
scoreShape 'Z' = 3

mapShape :: Char -> Char
mapShape 'A' = 'X'
mapShape 'B' = 'Y'
mapShape 'C' = 'Z'

scoreGame :: [Char] -> Int
scoreGame (player1 : space : player2 : _)
    | mappedp1 == winningShape(player2) = 6 + scoreShape player2
    | player2 == mappedp1 = 3 + scoreShape player2
    | otherwise = scoreShape player2
      where mappedp1 = mapShape player1

scoreChoice :: [Char] -> Int
scoreChoice (player1 : space : result : _)
  | result == 'X' = scoreShape (winningShape mappedp1)
  | result == 'Y' = 3 + scoreShape mappedp1
  | result == 'Z' = 6 + scoreShape (losingShape mappedp1)
    where mappedp1 = mapShape player1  


main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let 
    scores_1 = map(\game -> scoreGame game) (lines contents)
  let 
    scores_2 = map(\game -> scoreChoice game) (lines contents)

  print $ sum scores_1   -- Your puzzle answer was 12740.
  print $ sum scores_2   -- Your puzzle answer was 11980.
