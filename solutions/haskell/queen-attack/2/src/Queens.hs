module Queens (boardString, canAttack) where

import Data.List (intersperse)

data Color = B | W deriving (Show)

insertPiece :: Maybe (Int, Int) -> Color -> [String] -> [String]
insertPiece Nothing _ board = board
insertPiece (Just (x, y)) color board = insertPiece' bef crt aft y color
                                        where (bef, crt:aft) = splitAt x board

insertPiece' :: [String] -> String -> [String] -> Int -> Color -> [String]
insertPiece' bef row aft pos color = bef ++ ((a ++ show color ++ " " ++ (drop 2 b)) : aft)
                                     where (a, b) = splitAt (2*pos) row

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString white black = unlines $ insertPiece black B $ insertPiece white W $ replicate 8 $ intersperse ' ' $ replicate 8 '_' 

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (wx, wy) (bx, by) = wx == bx || wy == by || abs (wx - bx) == abs (wy - by)
