module Prime (nth) where

import qualified Data.IntSet as S

trimSet :: S.IntSet -> Int -> Int -> S.IntSet
trimSet set m n | n > 1000000 = set
                | otherwise = trimSet (S.delete n set) m (n + m)

primes :: S.IntSet
primes = go initial
    where
        initial = S.fromDistinctAscList [2..1000000]
        go set | S.null nxt = S.singleton p
               | otherwise = S.insert p $ go (trimSet nxt p (p + p))
            where (p, nxt) = S.deleteFindMin set

nth :: Integer -> Maybe Integer
nth n | n < 1 = Nothing
      | otherwise = case primeList of
                      [] -> Nothing
                      (x:_) -> Just $ toInteger x
      where
        primeList = drop (fromInteger (n - 1)) $ S.toAscList primes
