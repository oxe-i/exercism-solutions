module Leap

import Data.Bits

export
isLeap : Int -> Bool
isLeap year = let div25 = year `mod` 25 == 0 
              in (div25 && year .&. 15 == 0) || (not div25 && year .&. 3 == 0)
