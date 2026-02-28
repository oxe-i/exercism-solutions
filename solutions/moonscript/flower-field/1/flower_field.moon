sub_fn = (i, g) -> (j) ->
  ns = 0
  for k = i - 1, i + 1
    row = g[k]
    continue unless row
    for z = j - 1, j + 1
      ns += 1 if row\sub(z, z) == "*"
  if ns > 0 then "#{ns}" else " "

annotate = (garden) ->
  [ garden[i]\gsub "()%s", sub_fn(i, garden) for i = 1, #garden ]

{ :annotate }
