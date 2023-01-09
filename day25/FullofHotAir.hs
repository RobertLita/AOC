import Data.Char

main :: IO()
main = do

       l <- readFile "input.txt"
       print . partOne $ l
      Your puzzle answer was 2-02===-21---2002==0.
       -- print . partTwo $ l
      -- Your puzzle answer was 268912.

parse :: String -> [String]
parse i = words i

mapDigits :: Char -> Int
mapDigits '1' = 1
mapDigits '2' = 2
mapDigits '0' = 0
mapDigits '-' = (-1)
mapDigits '=' = (-2)

toDecimal :: String -> Int
toDecimal number = transformToDecimal (reverse number) 1

transformToDecimal :: String -> Int -> Int
transformToDecimal "" _ = 0
transformToDecimal (x : xs) p = p * mapDigits x + transformToDecimal xs pp
  where pp = p * 5
  
toSNAFU :: Int -> String
toSNAFU number = reverse . transformToSNAFU $ number

transformToSNAFU :: Int -> String
transformToSNAFU 0 = ""
transformToSNAFU x 
  | x `mod` 5 == 3 = '=' : transformToSNAFU (x `div` 5 + 1 )
  | x `mod` 5 == 4 = '-' : transformToSNAFU (x `div` 5 + 1 )
  | otherwise = intToDigit (x `mod` 5) : transformToSNAFU (x `div` 5)

partOne :: String -> String
partOne input = toSNAFU . sum . map toDecimal $ numbers
  where numbers = parse input
