flatten = (xs, acc = {}) -> with acc
  for x in *xs
    continue if x == "null"
    if type(x) == "table" then flatten x, acc
    else table.insert acc, x

{ :flatten }
