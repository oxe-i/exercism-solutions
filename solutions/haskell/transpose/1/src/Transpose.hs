module Transpose (transpose) where

transpose :: [String] -> [String]
transpose [] = []
transpose (x:xs) = zipWith (:) (take len lft) rht
  where trp = transpose xs
        len = max (length x) (length trp)
        lft = x <> repeat ' '
        rht = trp <> repeat mempty
        
        