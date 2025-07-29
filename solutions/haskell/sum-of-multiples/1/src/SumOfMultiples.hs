module SumOfMultiples (sumOfMultiples) where

import qualified Data.List as DList

maxMultiple :: Integer -> Integer -> Integer
maxMultiple limit num
  |  num == 0               = 0
  |  limit `mod` num == 0   = quotient - 1
  |  otherwise              = quotient
    where quotient = limit `div` num

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit = 
  (sum . DList.nub) [x*y | x <- factors, y <- [1..(maxMultiple limit x)]]
    
