module Acronym (abbreviate) where

import Data.Char(toUpper, isAlpha, isSpace, isLower, isUpper)

abbreviate :: String -> String
abbreviate = go True
  where 
    go _ [] = []
    go True (x:xs)
      | isAlpha x = toUpper x : go False xs
      | otherwise = go True xs
    go False (_:[]) = []
    go False (x:y:xs)
      | isSpace x || x == '-' = go True (y:xs)
      | isLower x && isUpper y = y : go False xs
      | otherwise = go False (y:xs)
      
      
      
      
