module Darts (score) where

data Circle = Inner | Middle | Outer | External
  deriving Eq

distFromCenter :: Float -> Float -> Float
distFromCenter x y = sqrt (x^2 + y^2)

getPosition :: Float -> Float -> Circle
getPosition x y
  | dist <= 1.0  = Inner
  | dist <= 5.0  = Middle
  | dist <= 10.0 = Outer
  | otherwise    = External
  where dist = sqrt (x^2 + y^2)

score :: Float -> Float -> Int
score x y
  | pos == Outer  = 1
  | pos == Middle = 5
  | pos == Inner  = 10
  | otherwise     = 0
  where pos = getPosition x y
