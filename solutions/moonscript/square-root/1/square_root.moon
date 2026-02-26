within_delta = (delta) -> (n1, n2) ->
  math.abs(n1 - n2) < delta

square_root = (radicand) ->
  guess = 1
  check = within_delta 0.0001
  while not check(radicand, guess*guess)
    guess = (guess + radicand / guess) / 2
  math.floor guess
  
{ sqrt: square_root }
