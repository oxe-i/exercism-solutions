module Grains (square, total) where

square :: Integer -> Maybe Integer
square n
 | (n < 1) || (n > 64) = Nothing
 | otherwise           = Just (2 ^ (n - 1))

total :: Integer
-- sum of a geometric progression from 2^0 to 2^64
total = gpSum 1 2 64

gpSum :: Integer -> Integer -> Integer -> Integer
gpSum a r n = div (a * (r ^ n - 1)) (r - 1)
