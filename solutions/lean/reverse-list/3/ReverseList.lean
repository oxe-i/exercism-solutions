import Extra

namespace ReverseList

@[csimp]
theorem custom_reverse_eq_spec_reverse : @Extra.custom_reverse = @List.reverse := by
  funext _ xs
  induction xs with
  | nil           => rfl
  | cons _ _ hr => simpa [Extra.custom_reverse, List.reverse_cons] using hr

end ReverseList
