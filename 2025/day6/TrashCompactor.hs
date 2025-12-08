import Data.Char
import Data.Function
import Data.List

data Operator = Add | Mul deriving (Enum, Show)

data Equation = Equation
  { operator :: Operator,
    operands :: [Int]
  }
  deriving (Show)

type Dialect = ([String] -> [[String]])

getOperation :: Operator -> ([Int] -> Int)
getOperation Add = sum
getOperation Mul = product

parse :: String -> Dialect -> [Equation]
parse input dialect =
  let allLines = lines input
      operands = map parseOperands $ dialect $ init allLines
      operators = map parseOperator $ words $ last allLines
   in zipWith Equation operators operands

regularNotation :: Dialect
regularNotation = transpose . map words

isSpaceBlock :: String -> Bool
isSpaceBlock = all isSpace

cephalopodNotation :: Dialect
cephalopodNotation =
  filter (not . null)
    . map (filter (not . isSpaceBlock))
    . groupBy (\a b -> isSpaceBlock a == isSpaceBlock b)
    . transpose

parseOperands :: [String] -> [Int]
parseOperands = map read

parseOperator :: String -> Operator
parseOperator "+" = Add
parseOperator "*" = Mul
parseOperator _ = error "Could not parse Operator"

solveEquation :: Equation -> Int
solveEquation Equation {operator, operands} = getOperation operator operands

solveEquations :: String -> Dialect -> Int
solveEquations input notation = sum $ map solveEquation $ parse input notation

main :: IO ()
main = do
    content <- readFile "input.txt"

    print $ solveEquations content regularNotation
    -- Your puzzle answer was 6891729672676.

    print $ solveEquations content cephalopodNotation
    -- Your puzzle answer was 9770311947567.