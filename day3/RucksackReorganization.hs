module Main where

import System.IO
import Data.Char

getItemScore :: Char -> Int
getItemScore item
  | isLower item = ord item - ord 'a' + 1
  | isUpper item = ord item - ord 'A' + 27
  | otherwise = 0


splitHalves :: String -> Int -> ([Char], [Char])
splitHalves (item : rest) totalLen
  | length rest == totalLen `div` 2 = ([item], rest)
  | otherwise = (item : fst half, snd half)
  where half = splitHalves rest totalLen


getCommonItem :: String -> String -> Char
getCommonItem (firstItem : rest) secondHalf
  | firstItem `elem` secondHalf = firstItem
  | otherwise = getCommonItem rest secondHalf

getTriples :: [String] -> [(String, String, String)]
getTriples (h1 : h2 : h3: rest) 
  | rest == [] = [(h1, h2, h3)]
  | otherwise = (h1, h2, h3) : getTriples rest

getCommonItem3 :: String -> String -> String -> Char
getCommonItem3 (firstItem : rest) secondStr thirdStr
  | firstItem `elem` secondStr && firstItem `elem` thirdStr = firstItem
  | otherwise = getCommonItem3 rest secondStr thirdStr


main = do
  handle <- openFile "input.txt" ReadMode
  contents <- hGetContents handle
  let 
    rucksacks = (lines contents)

  print $ sum $ map(\(h1, h2) -> getItemScore $ getCommonItem h1 h2) $ map(\x -> splitHalves x $ length x )rucksacks
  -- Your puzzle answer was 8085.

  print $ sum $ map (\(x, y, z) -> getItemScore $ getCommonItem3 x y z) $ getTriples rucksacks
  -- Your puzzle answer was 2515.
  
