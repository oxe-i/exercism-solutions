module CollatzConjecture (collatz) where

collatzHelper  ::  Integer -> Integer
collatzHelper  n
  |  n == 1          =  0
  |  n `mod` 2 == 0  =  1 + collatzHelper (n `div` 2)
  |  otherwise       =  1 + collatzHelper (3*n + 1)

collatz :: Integer -> Maybe Integer
collatz n
  |  n <= 0          =  Nothing
  |  otherwise       =  Just (collatzHelper n)
