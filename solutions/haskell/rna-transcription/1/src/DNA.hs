module DNA (toRNA) where

import Data.Char (toUpper)

complement :: Char -> Maybe Char
complement x = case toUpper x of
                'A' -> Just 'U'
                'T' -> Just 'A'
                'C' -> Just 'G'
                'G' -> Just 'C'
                _   -> Nothing

toRNA :: String -> Either Char String
toRNA dna = case dna of
              []       -> Right ""
              (x : xs) -> case complement x of
                            Nothing   -> Left x
                            Just nucl -> case toRNA xs of
                                           Left _    -> toRNA xs
                                           Right str -> Right (nucl : str)
