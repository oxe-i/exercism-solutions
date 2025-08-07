module GameOfLife (tick) where

data State = Dead | Alive deriving Eq

toState :: Int -> State
toState 0 = Dead
toState _ = Alive

fromState :: State -> Int
fromState Dead = 0
fromState _ = 1

tick :: [[Int]] -> [[Int]]
tick matrix = fmap (fmap (fromState . change)) indexed
  where
      indexed = fmap (\(rI, r) -> fmap (\(cI, c) -> (rI, cI, toState c)) $ zip [0..] r) $ zip [0..] matrix
      flattened = concat indexed
      
      neighbours :: (Int, Int, State) -> [(Int, Int, State)]
      neighbours (r1, c1, _) = filter (\(r2, c2, _) -> abs (r1 - r2) <= 1 && abs (c1 - c2) <= 1 && (r1 /= r2 || c1 /= c2)) flattened
      
      change :: (Int, Int, State) -> State
      change x@(_, _, s1)
        | numAliveNeighbours == 3 = Alive
        | numAliveNeighbours == 2 && s1 == Alive = Alive
        | otherwise = Dead
        where 
          numAliveNeighbours = length $ filter (\(_, _, s2) -> s2 == Alive) $ neighbours x
