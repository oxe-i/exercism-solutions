is_anagram_for = (target) -> 
  target_lower = target\lower!
  
  target_map = {}
  for char in target_lower\gmatch '.'
    target_map[char] = (target_map[char] or 0) + 1
  
  (candidate) -> 
    candidate_lower = candidate\lower!
    return false if candidate_lower == target_lower or #candidate_lower != #target_lower
    
    counts = { char, count for char, count in pairs target_map }

    for char in candidate_lower\gmatch '.'
      count = counts[char]
      return false if not count or count == 0
      counts[char] = count - 1
      
    true
 
find_anagrams = (subject, candidates) ->
  is_anagram = is_anagram_for subject
  [ c for c in *candidates when is_anagram c ]

return find_anagrams
