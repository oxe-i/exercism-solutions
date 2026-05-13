rows = (n) -> with dp = {}
  p = {1}
  for i = 1, n
    table.insert dp, p
    p = [(p[j - 1] or 0) + (p[j] or 0) for j = 1, #p + 1]

{ :rows }