module LeapYear (isLeapYear) where

isDivisible :: Integer -> Integer -> Bool
isDivisible num n = num `mod` n == 0

isLeapYear :: Integer -> Bool
isLeapYear year 
    | isDivisible year 400 = True
    | isDivisible year 100 = False
    | isDivisible year 4   = True
    | otherwise            = False
