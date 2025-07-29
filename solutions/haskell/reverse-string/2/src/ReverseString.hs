module ReverseString (reverseString) where

reverseString :: String -> String
reverseString str = foldr (\x y -> y ++ [x]) [] str
