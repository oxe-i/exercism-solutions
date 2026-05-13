square = (n) ->  
  assert n >= 1 and n <= 64, "square must be between 1 and 64"
  2 ^ (n - 1)

total = -> 2 ^ 64 - 1

{ :square, :total }