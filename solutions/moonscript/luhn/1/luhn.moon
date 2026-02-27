is_valid = (input) ->
  double = false
  total, count = 0, 0
  for i = #input, 1, -1
    char = input\sub i, i
    if char\match "%d"
      count += 1
      digit = tonumber char
      if double
        digit *= 2
        digit -= 9 if digit > 9
      total += digit
      double = not double
    else return false unless char\match "%s"
  count > 1 and total % 10 == 0  
  
{ :is_valid }
