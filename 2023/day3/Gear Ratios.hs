import Data.Char (isDigit)

main :: IO ()
main = do
    l <- readFile "input.txt"
    print $ partOne l
    -- Your puzzle answer was 517021.

    -- print $ partTwo l

type Position = (Int, Int)
type Matrix = [String]

insideMatrix :: Position -> Matrix -> Bool
insideMatrix (x, y) matrix
  | x >= 0 && x < numRows && y >= 0 && y < numCols = True
  | otherwise = False
  where
    numRows = length matrix
    numCols = length (head matrix)

isSymbol :: Position -> Matrix -> Bool
isSymbol (x, y) m
  | isDigit (m !! x !! y) || (m !! x !! y) == '.' = False
  | otherwise = True

checkSymbolNearby :: Position -> Matrix -> Bool
checkSymbolNearby (x, y) m
  | insideMatrix (x + 1, y) m && isSymbol (x + 1, y) m || insideMatrix (x - 1, y) m && isSymbol (x - 1, y) m
  || insideMatrix (x, y + 1) m && isSymbol (x, y + 1) m || insideMatrix (x, y - 1) m && isSymbol (x, y - 1) m 
  || insideMatrix (x + 1, y + 1) m && isSymbol (x + 1, y + 1) m || insideMatrix (x - 1, y + 1) m && isSymbol (x - 1, y + 1) m
  || insideMatrix (x - 1, y - 1) m && isSymbol (x - 1, y - 1) m || insideMatrix (x + 1, y - 1) m && isSymbol (x + 1, y - 1) m = True
  | otherwise = False


isValidNumber :: Matrix -> Position -> Bool
isValidNumber m (x, y)
  | y < length (head m) && isDigit (m !! x !! y) = checkSymbolNearby (x, y) m || isValidNumber m (x, y + 1)
  | otherwise = False


getValidNumbers :: Matrix -> Position -> [Int]
getValidNumbers m (x, y)
  | x < length m && y < length (head m) && isDigit (m !! x !! y) = if isValidNumber m (x, y)
                                                    then read (takeWhile isDigit $ drop y (m !! x)) : getValidNumbers m (x, y + length (takeWhile isDigit $ drop y (m !! x)))
                                                    else getValidNumbers m (x, y + 1)
  | x < length m && y < length (head m) && not(isDigit (m !! x !! y)) = getValidNumbers m (x, y + 1)
  | x < length m && y == length (head m) = getValidNumbers m (x + 1, 0)
  | x == length m = []

partOne :: String -> Int
partOne m = sum $ getValidNumbers (lines m) (0, 0)

