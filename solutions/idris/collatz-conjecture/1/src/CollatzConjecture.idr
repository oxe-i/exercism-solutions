module CollatzConjecture

export
steps : Int -> Maybe Int
steps number = if number <= 0 then Nothing
               else Just $ go number 0
    where
        go : Int -> Int -> Int
        go 1 acc = acc
        go n acc = if n `mod` 2 == 0 then go (n `div` 2) (acc + 1)
                   else go (3*n + 1) (acc + 1)
