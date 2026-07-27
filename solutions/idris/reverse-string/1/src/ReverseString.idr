module ReverseString

import Data.String

export
rev : String -> String
rev = go ""
    where
       go : String -> String -> String
       go acc xs with (strM xs)
          go acc ""               | StrNil           = acc
          go acc (strCons c rest) | (StrCons c rest) = go (strCons c acc) rest
