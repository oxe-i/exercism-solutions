module Luhn (isValid) where

import Data.Char(digitToInt)

isValid :: String -> Bool
isValid xs = (numD > 1) && (sumD `mod` 10) == 0
   where
      (_, sumD, numD) = foldr go (False, 0, 0) xs
      go ' ' acc = acc
      go x (False, s, n) = (True, s + (digitToInt x), n + 1)
      go x (True, s, n) = (False, s + d + m, n + 1)
         where
            double = digitToInt x * 2
            (d, m) = double `divMod` 10
        