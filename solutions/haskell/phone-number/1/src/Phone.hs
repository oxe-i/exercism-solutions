module Phone (number) where

import Data.Char(isDigit)

number :: String -> Maybe String
number xs = case formatNumber xs of
             Nothing -> Nothing
             Just digitString -> if check digitString then Just digitString else Nothing
            where check str = all (>= '2') $ head str : (take 1 $ drop 3 str)

formatNumber :: String -> Maybe String
formatNumber str = case length digitString of
                    10 -> Just digitString
                    11 -> if head digitString == '1' then Just (tail digitString) else Nothing
                    _  -> Nothing
                   where digitString = filter isDigit str