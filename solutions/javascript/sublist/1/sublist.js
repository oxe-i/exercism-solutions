export class List {
  list;
  
  constructor(values) {
    this.list = [... (values ?? [])];
  }

  compare(other) {
    if (this.list.length == other.list.length) {
      if (this.list.every((elem, idx) => elem === other.list[idx])) return "EQUAL";
      return "UNEQUAL";
    }

    if (!this.list.length) return "SUBLIST";
    if (!other.list.length) return "SUPERLIST";

    const [smaller, greater] = this.list.length >= other.list.length ? 
                                             [other.list, this.list] : 
                                             [this.list, other.list];

    for (const [idxGreater, valGreater] of greater.entries()) {
      if (valGreater != smaller[0]) continue;
      
      let comparison;      
      for (const [idxSmaller, valSmaller] of smaller.entries()) {
        comparison = valSmaller === greater.at(idxGreater + idxSmaller);
        if (!comparison) break;
      }
      
      if (comparison) return smaller === this.list ? "SUBLIST" : "SUPERLIST";
    }

    return "UNEQUAL";
  }
}
