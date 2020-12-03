import qualified Data.Text as T
import System.IO

type ValidityCheck = Int -> Int -> Char -> String -> Bool

countOccurences :: Char -> String -> Int
countOccurences c str = length $ filter (== c) str

checkValid1 :: ValidityCheck
checkValid1 lo hi c str = occurences >= lo && occurences <= hi
    where occurences = countOccurences c str

checkValid2 :: ValidityCheck
checkValid2 lo hi c str = (a == c || b == c) && a /= b
    where a = str!!(lo-1)
          b = str!!(hi-1)

checkStringValid :: ValidityCheck -> String -> Bool
checkStringValid val str = val lo hi c pass
    where parts = split " " str
          nums = split "-" (parts!!0)
          lo = read $ nums!!0
          hi = read $ nums!!1
          c = parts!!1!!0
          pass = parts!!2

countValid :: ValidityCheck -> [String] -> Int
countValid val strs = length $ filter (checkStringValid val) strs

split d str = map (T.unpack) (T.splitOn (T.pack d) (T.pack str))

main = do
    handle <- openFile "input.txt" ReadMode  
    contents <- hGetContents handle
    print $ countValid checkValid1 $ split "\n" contents
    print $ countValid checkValid2 $ split "\n" contents
    hClose handle  