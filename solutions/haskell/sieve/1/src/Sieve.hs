module Sieve (primesUpTo) where

import Prelude hiding (div, mod, divMod, rem, quotRem, quot, (/))
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

primesUpTo :: Integer -> [Integer]
primesUpTo n = fmap toInteger $ takeWhile (\p -> p <= fromInteger n) primeList
    where
      primeList = S.toAscList primes
