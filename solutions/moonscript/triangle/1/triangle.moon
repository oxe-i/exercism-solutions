check = (p) -> (a, b, c) ->
  s = { a, b, c }
  table.sort s
  s[1] > 0 and s[1] + s[2] >= s[3] and p(s)

is_equilateral = check((s) -> s[1] == s[3])
is_isosceles = check((s) -> s[1] == s[2] or s[2] == s[3])
is_scalene = check((s) -> s[1] != s[2] and s[2] != s[3])
  
{ :is_equilateral, :is_isosceles, :is_scalene }
