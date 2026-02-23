distance = (strand1, strand2) ->
  assert #strand1 == #strand2, 'strands must be of equal length'
  dist = 0
  for i = 1, #strand1
    if strand1\sub(i, i) != strand2\sub(i, i)
      dist += 1
  dist
    
{ :distance }
