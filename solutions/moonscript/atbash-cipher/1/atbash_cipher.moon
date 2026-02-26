a = 'a'\byte!
z = 'z'\byte!

cipher = (text) ->
  text\gsub(".", (char) ->
    return "" unless char\match "%w"
    return char if char\match "%d"
    code = char\lower!\byte! - a
    string.char(z - code))
    
{
  encode: (phrase) ->
    encoded = cipher phrase
    grouped = encoded\gsub "%w%w%w%w%w", "%0 "
    grouped\gsub "%s+$", ""
      
  decode: (phrase) ->
    cipher phrase
}
