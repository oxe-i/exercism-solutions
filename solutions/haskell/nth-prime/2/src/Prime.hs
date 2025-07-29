module Prime (nth) where

nth :: Int -> Maybe Integer
nth n
  |  n < 1     = Nothing
  |  otherwise = Just (nth' n [2] [x | x <- [3..], x `mod` 2 /= 0])

nth' :: Int -> [Integer] -> [Integer] -> Integer
nth' n primeList possiblePrimes
  |  n == 1    = head primeList
  |  otherwise = nth' (n - 1) (nextPrime : primeList) [x | x <- possiblePrimes, x `mod` nextPrime /= 0]
                  where nextPrime = head possiblePrimes
