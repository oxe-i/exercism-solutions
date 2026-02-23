pop = (stack, msg) ->
    assert #stack > 0, msg
    table.remove stack
      
class Forth
  new: =>
    @_stack = {}     
    @custom_op = false
    @parse_op = {}
    @ops = 
      ["+"]: -> 
        {v1, v2} = @binary!
        @_stack[#@_stack + 1] = v2 + v1
      ["-"]: ->
        {v1, v2} = @binary!
        @_stack[#@_stack + 1] = v2 - v1
      ["*"]: -> 
        {v1, v2} = @binary!
        @_stack[#@_stack + 1] = v2 * v1
      ["/"]: ->
        {v1, v2} = @binary!
        assert v1 != 0, 'divide by zero'
        @_stack[#@_stack + 1] = math.floor (v2 / v1)
      ["dup"]: ->
        v1 = @unary!
        @_stack[#@_stack + 1], @_stack[#@_stack + 2] = v1, v1
      ["drop"]: ->
        @unary!
      ["swap"]: ->
        {v1, v2} = @binary!
        @_stack[#@_stack + 1], @_stack[#@_stack + 2] = v1, v2
      ["over"]: ->
        {v1, v2} = @binary!
        @_stack[#@_stack + 1], @_stack[#@_stack + 2], @_stack[#@_stack + 3] = v2, v1, v2
        
  unary: =>
    pop @_stack, "empty stack"
    
  binary: =>
    v1 = @unary!
    v2 = pop @_stack, "only one value on the stack"
    {v1, v2}

  call_op: (instruction) =>
    op = @ops[instruction]
    assert op != nil, "undefined operation"
    op()
  
  check_number: (candidate) =>
    num = tonumber(candidate)
    if num != nil
      @_stack[#@_stack + 1] = num
      return true
    false

  execute_instruction: (instruction) =>
    @check_number(instruction) or @call_op(instruction)
  
  stack: =>
    @_stack

  evaluate: (script) =>
    for instructions in *script
      for instruction in instructions\gmatch "%S+"
        instruction = instruction\lower!
        if @custom_op
          if instruction != ';'
            @parse_op[#@parse_op + 1] = instruction
          else
            key = table.remove @parse_op, 1
            assert tonumber(key) == nil, "illegal operation"
            ops = {}
            for op in *@parse_op
              num = tonumber(op)
              if num != nil
                ops[#ops + 1] = () -> @_stack[#@_stack + 1] = num
              else
                op = @ops[op]
                ops[#ops + 1] = () ->
                  assert op != nil, "undefined operation"
                  op()
            @ops[key] = () -> 
              for op in *ops
                op()
            @custom_op = false
            @parse_op = {}
        else if instruction == ':'
          @custom_op = true
        else
          @execute_instruction(instruction)
          
