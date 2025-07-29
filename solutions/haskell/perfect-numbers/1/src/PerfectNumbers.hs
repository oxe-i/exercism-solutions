module PerfectNumbers (classify, Classification(..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

getFactors :: Int -> [Int]
getFactors num = [factor | factor <- [1 .. num - 1] , num `mod` factor == 0]

classify :: Int -> Maybe Classification
classify num
     | num < 1                      =  Nothing
     | sum (getFactors num) == num  =  Just Perfect
     | sum (getFactors num) <  num  =  Just Deficient
     | otherwise                    =  Just Abundant
