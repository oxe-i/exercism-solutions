module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, fromList)
import Data.Map.Strict (insertWith)

data Nucleotide = A | C | G | T deriving (Eq, Read, Show, Ord)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts [] = Right (fromList [(x, 0) | x <- [A,C,G,T]])
nucleotideCounts (x : xs) = 
 case nucleotideCounts xs of
  Left msg    -> Left msg
  Right strand -> if elem x "ACGT" then
                   Right (insertWith (+) (read [x]) 1 strand)
                  else
                   Left "Invalid Strand"
