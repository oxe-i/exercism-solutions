steps = (number) ->
  assert number > 0, 'Only positive integers are allowed'
  steps = 0
  while number != 1
    steps += 1
    number = if (number & 1) != 0 then 3*number + 1  else number >> 1
  steps

{ :steps }
