counter = (strand) ->
  nucleotides = 'ACGT'
  acc = A: 0, C: 0, G: 0, T: 0
  for n in strand\gmatch '.'
    assert nucleotides\find(n, 1, true) != nil, 'Invalid nucleotide in strand'
    acc[n] += 1
  acc

return counter
