module Knapsack (maximumValue) where

type Weight = Int
type Value  = Int

maximumValue :: Weight -> [(Weight, Value)] -> Value
maximumValue _ [] = 0
maximumValue n ((w, v):xs)
 | w > n = maximumValue n xs
 | otherwise = max 
                (v + maximumValue (n - w) xs) 
                (maximumValue n xs)
