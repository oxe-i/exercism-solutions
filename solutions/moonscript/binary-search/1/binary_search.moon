{
  find: (list, target) ->
    low = 1
    high = #list
    while low <= high
      mid = (low + high) // 2
      value = list[mid]
      return mid if value == target
      if value > target
        high = mid - 1
      else
        low = mid + 1
    error "value not in array"
}
