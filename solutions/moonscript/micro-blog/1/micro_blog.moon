truncate = (str) ->
    if utf8.len(str) <= 5
      return str
    end_pos = utf8.offset str, 6
    str\sub 1, end_pos - 1
         
{ :truncate }
