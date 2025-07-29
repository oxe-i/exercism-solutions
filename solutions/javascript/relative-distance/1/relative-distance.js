export const degreesOfSeparation = (familyTree, personA, personB) => {
  const hashFN = (a, b) => (a <= b ? `${a}+${b}` : `${b}+${a}`);
  const relativesMap = Object.entries(familyTree).reduce(
    (acc, [parent, children]) => {
      const parentRelatives = acc.get(parent) ?? [];
      const updatedMap = children.reduce((crt, child) => {
        const childRelatives = crt.get(child) ?? [];
        parentRelatives.push(child);
        childRelatives.push(parent);
        children.forEach((sibling) => {
          if (sibling !== child) childRelatives.push(sibling);
        });
        crt.set(child, childRelatives);
        return crt;
      }, acc);
      updatedMap.set(parent, parentRelatives);
      return updatedMap;
    },
    new Map()
  );

  const targetHash = hashFN(personA, personB);
  const memo = [...relativesMap.entries()].reduce(
    (acc, [person, relatives]) => {
      acc.set(hashFN(person, person), 0);
      relatives.forEach((relative) => {
        acc.set(hashFN(relative, relative), 0);
        acc.set(hashFN(person, relative), 1);
      });
      return acc;
    },
    new Map()
  );

  while (!memo.has(targetHash)) {
    let circular = true;

    const crtPaths = [...memo.entries()].map(([hash, value]) => [
      hash.split("+"),
      value,
    ]);

    crtPaths.forEach(([[p1, p2], value]) => {
      const relatives1 = relativesMap.get(p1);
      const relatives2 = relativesMap.get(p2);

      const circular1 = relatives1.reduce((acc, relative) => {
        const hash = hashFN(p2, relative);
        if (memo.has(hash)) return acc && true;
        const min = Math.min(value + 1, memo.get(hash) ?? Infinity);
        memo.set(hash, min);
        return false;
      }, true);
      const circular2 = relatives2.reduce((acc, relative) => {
        const hash = hashFN(p1, relative);
        if (memo.has(hash)) return acc && true;
        const min = Math.min(value + 1, memo.get(hash) ?? Infinity);
        memo.set(hash, min);
        return false;
      }, true);

      circular = circular && circular1 && circular2;
    });

    if (circular) break;
  }

  return memo.get(targetHash) ?? -1;
};
