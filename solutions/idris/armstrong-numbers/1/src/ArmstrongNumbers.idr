module ArmstrongNumbers

export
isArmstrongNumber : Integer -> Bool
isArmstrongNumber number = number == sum (map (\x => pow x len) digits)
    where        
        getDigits : Integer -> List Integer -> List Integer
        getDigits 0 [] = [0]
        getDigits 0 xs = xs
        getDigits n xs = getDigits (n `div` 10) (n `mod` 10 :: xs)

        pow : Integer -> Nat -> Integer
        pow _ 0     = 1
        pow x (S n) = x * pow x n
        
        digits = getDigits number []
        
        len = length digits
