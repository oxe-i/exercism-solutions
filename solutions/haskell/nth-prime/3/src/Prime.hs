module Prime (nth) where

nth :: Int -> Maybe Integer
nth n
  |  n < 1     = Nothing
  |  otherwise = Just (nth' n 2 [x | x <- [3..], x `mod` 2 /= 0])

nth' :: Int -> Integer -> [Integer] -> Integer
nth' n lastPrime possiblePrimes
  |  n == 1    = lastPrime
  |  otherwise = nth' (n - 1) nextPrime [x | x <- possiblePrimes, x `mod` nextPrime /= 0]
                  where nextPrime = head possiblePrimes
