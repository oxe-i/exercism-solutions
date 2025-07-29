module ReverseString (reverseString) where

reverseString :: String -> String
reverseString str = reverseString' str []

reverseString' :: String -> String -> String
reverseString' [] acc = acc
reverseString' (x : xs) acc = reverseString' xs (x : acc)
