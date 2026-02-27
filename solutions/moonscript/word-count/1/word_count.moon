count_words = (sentence) ->
    with words = {}
      for word in sentence\lower!\gmatch "%w+'?%w*%f[%W]"
        words[word] = (words[word] or 0) + 1

{ :count_words }