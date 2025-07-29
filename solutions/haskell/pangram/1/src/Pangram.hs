module Pangram (isPangram) where

import qualified Data.Char as Chr
import qualified Data.Set as Set

mapAlphabet :: Set.Set Char
mapAlphabet = Set.fromList "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

checkLetterFreq :: String -> Set.Set Char
checkLetterFreq text = foldr fillSet Set.empty text where 
    fillSet char crtSet  |  Set.member char mapAlphabet =  Set.insert (Chr.toLower char) crtSet
                         |  otherwise                   =  crtSet

isPangram :: String -> Bool
isPangram text = (Set.size . checkLetterFreq) text == 26
