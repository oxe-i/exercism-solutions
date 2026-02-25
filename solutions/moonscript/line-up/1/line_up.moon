local ordinal

ordinal = (n) -> 
  return "th" if math.floor(n / 10) % 10 == 1
  ({ [1]: "st", [2]: "nd", [3]: "rd" })[n % 10] or "th"

{
  format: (name, number) ->
    prefix = "#{name}, you are the"
    suffix = "customer we serve today. Thank you!"
    "#{prefix} #{number}#{ordinal number} #{suffix}"
}
