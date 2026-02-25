opening = { "{": true, "[": true, "(": true }
pairs = { "}": "{", "]": "[", ")": "(" }

{
  is_paired: (input) ->
    stack = {}    
    for bracket in input\gmatch "[%[%]{()}]"
      if opening[bracket]
        table.insert stack, bracket
      else
        return false if table.remove(stack) != pairs[bracket]          
    #stack == 0   
}
