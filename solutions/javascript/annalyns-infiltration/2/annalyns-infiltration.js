export function canExecuteFastAttack(knightIsAwake) {
  return !(knightIsAwake);
}

export function canSpy(knightIsAwake, archerIsAwake, prisonerIsAwake) {
  return knightIsAwake || archerIsAwake || prisonerIsAwake;
}

export function canSignalPrisoner(archerIsAwake, prisonerIsAwake) {
  return !archerIsAwake && prisonerIsAwake;
}

export function canFreePrisoner(
  knightIsAwake,
  archerIsAwake,
  prisonerIsAwake,
  petDogIsPresent,
) {
  const dog_escape = petDogIsPresent && !archerIsAwake;
  const sneaky_escape = !petDogIsPresent && prisonerIsAwake && !knightIsAwake && !archerIsAwake;
  return  dog_escape || sneaky_escape;
}
