import Data.Char (isDigit, digitToInt, isAlpha, toLower)
import Data.Maybe ( isNothing, fromMaybe )
import Data.Bifunctor ( Bifunctor(first) ) 

main :: IO()
main = do
      l <- readFile "input.txt"
      print $ partOne l
      -- Your puzzle answer was 54644.

      print $ partTwo l
      -- Your puzzle answer was 53348.

firstDigit :: String -> Int
firstDigit [] = 0
firstDigit (h : t)
  | isDigit h = digitToInt h
  | otherwise = firstDigit t

calibrationValuePartOne :: String -> Int
calibrationValuePartOne x = firstDigit x * 10 + firstDigit (reverse x)

partOne :: String -> Int
partOne x = sum $ map calibrationValuePartOne (lines x)

wordsAndDigits :: [(String, Int)]
wordsAndDigits = [("one", 1), ("two", 2), ("three", 3), ("four", 4), ("five", 5), ("six", 6), ("seven", 7), ("eight", 8), ("nine", 9)]


checkWord :: String -> String -> [(String, Int)] -> Maybe Int
checkWord _ [] _ = Nothing
checkWord x (h : t) wd
 | isNothing $ lookup currentPath wd = checkWord currentPath t wd
 | otherwise = lookup currentPath wd
 where currentPath = x ++ [h]

firstDigitOnLetters :: String -> [(String, Int)] -> Maybe Int
firstDigitOnLetters _ [] = Just 0
firstDigitOnLetters [] _ = Nothing
firstDigitOnLetters (x : xs) wd
 | isDigit x = Just $ digitToInt x
 | isNothing $ checkWord [x] xs wd = firstDigitOnLetters xs wd
 | otherwise = checkWord [x] xs wd

calibrationValuePartTwo :: String -> Int
calibrationValuePartTwo x = 10 * fromMaybe 0 (firstDigitOnLetters x wordsAndDigits) + fromMaybe 0 (firstDigitOnLetters (reverse x) (map (first reverse) wordsAndDigits))

partTwo :: String -> Int
partTwo x = sum $ map calibrationValuePartTwo (lines x)