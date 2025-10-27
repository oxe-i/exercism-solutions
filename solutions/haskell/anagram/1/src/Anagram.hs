module Anagram (anagramsFor) where

import Data.Char (toLower)
import qualified Data.IntMap as Map

mapLower :: String -> String
mapLower = map toLower

mapFromEnum :: String -> [Int]
mapFromEnum = map fromEnum

createKeyValueList :: [Int] -> [(Int, Int)]
createKeyValueList = (flip zip) (repeat 1) 

generateMap :: String -> Map.IntMap Int
generateMap = Map.fromListWith (+) . createKeyValueList . mapFromEnum

isAnagram :: String -> Map.IntMap Int -> String -> Bool
isAnagram straw count y = straw /= candidate && count == (generateMap candidate)
  where
    candidate = mapLower y

anagramsFor :: String -> [String] -> [String]
anagramsFor xs ys = filter (isAnagram straw count) ys
  where
    straw = mapLower xs
    count = generateMap straw