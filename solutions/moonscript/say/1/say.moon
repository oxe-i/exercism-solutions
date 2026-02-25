local numbers, process_multiples, say

numbers = {
  [0]: "zero"
  [1]: "one"
  [2]: "two"
  [3]: "three"
  [4]: "four"
  [5]: "five"
  [6]: "six"
  [7]: "seven"
  [8]: "eight"
  [9]: "nine"
  [10]: "ten"
  [11]: "eleven"
  [12]: "twelve"
  [13]: "thirteen"
  [14]: "fourteen"
  [15]: "fifteen"
  [16]: "sixteen"
  [17]: "seventeen"
  [18]: "eighteen"
  [19]: "nineteen"
  [20]: "twenty"
  [30]: "thirty"
  [40]: "forty"
  [50]: "fifty"
  [60]: "sixty"
  [70]: "seventy"
  [80]: "eighty"
  [90]: "ninety"
}

process_multiples = (number, multiple, separator) ->
  whole = math.floor number / multiple
  remainder = number % multiple
  prefix = "#{say whole}#{separator}"
  return prefix if remainder == 0
  "#{prefix} #{say remainder}"
  
say = (number) ->   
  val = numbers[number]
  return val if val

  assert number >= 0 and number < 1e12, "input out of range"

  return process_multiples(number, 1e9, " billion") if number >= 1e9
  return process_multiples(number, 1e6, " million") if number >= 1e6
  return process_multiples(number, 1e3, " thousand") if number >= 1e3
  return process_multiples(number, 1e2, " hundred") if number >= 1e2

  digit = number % 10
  tens = number - digit
  "#{say tens}-#{say digit}"

{  
  in_english: say
}
