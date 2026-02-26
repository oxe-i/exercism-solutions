sum = (factors, limit) ->
  multiples = { m, true for f in *factors when f > 0 for m = f, limit - 1, f }
  with acc = 0
    acc += m for m in pairs multiples

{ :sum }