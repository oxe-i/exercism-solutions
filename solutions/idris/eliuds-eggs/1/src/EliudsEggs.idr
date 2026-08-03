module EliudsEggs

import Data.Bits

export
eggCount : Int -> Int
eggCount number = (z * 0x0101010101010101) `shiftR` 56
    where
        x = (number .&. 0x5555555555555555) + ((number `shiftR` 1) .&. 0x5555555555555555)
        y = (x .&. 0x3333333333333333) + ((x `shiftR` 2) .&. 0x3333333333333333)
        z = ((y + (y `shiftR` 4)) .&. 0x0F0F0F0F0F0F0F0F)