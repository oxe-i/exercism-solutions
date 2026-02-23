score = (x, y) ->
  squared = x ^ 2 + y ^ 2
  if squared > 100 then 0
  else if squared > 25 then 1
  else if squared > 1 then 5
  else 10

{ :score }
