module Sieve (primesUpTo) where

import Prelude hiding (div, mod, divMod, rem, quotRem, quot, (/))

primesUpTo :: Integer -> [Integer]
primesUpTo n = go [2 .. n]
    where
      go :: [Integer] -> [Integer]
      go [] = []
      go (x:xs) = x : go (filter (\y -> y `notElem` [x, x + x .. n]) xs)
