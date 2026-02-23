is_armstrong = (num) ->
  return true if num == 0
  power = 1 + math.floor (math.log num, 10)
  n = num
  sum = 0
  while n > 0
    sum += (n % 10) ^ power
    n = math.floor (n / 10)
  sum == num

{ :is_armstrong }

