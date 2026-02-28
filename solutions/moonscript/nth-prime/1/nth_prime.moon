prime = (n) -> 
  assert n > 0, "there is no zeroth prime"
  return 2 if n == 1
  
  ln = math.log n
  upper = 3 + n * (ln + math.log ln)
  sieve = [ true for k = 3, upper ]

  count = 1
  for p = 3, upper, 2
    continue unless sieve[p - 2]
    count += 1
    return p if count == n
    sieve[m - 2] = false for m = p*p, upper, 2*p
  
{ :prime }
