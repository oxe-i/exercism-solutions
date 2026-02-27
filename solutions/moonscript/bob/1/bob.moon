response = (input) ->
  is_question = input\match "%?%s*$"
  is_yell = input\match("%a") and not input\match "%l" 
  is_silence = #input == 0 or not input\match "%S"
  return "Calm down, I know what I'm doing!" if is_yell and is_question
  return "Sure." if is_question
  return "Whoa, chill out!" if is_yell
  return "Fine. Be that way!" if is_silence
  "Whatever."
  
{ hey: response }
