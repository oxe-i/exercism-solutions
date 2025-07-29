export const getFirstCard = ([f,]) => f;
export const getSecondCard = ([,s,]) => s;
export const swapTwoCards = ([f,s,...r]) => [s,f,...r];
export const shiftThreeCardsAround = ([f,s,t]) => [s,t,f];
export const pickNamedPile = ({ chosen }) => chosen;
export const swapNamedPile = ({chosen, disregarded}) => {
  [disregarded, chosen] = [chosen, disregarded];
  return { chosen, disregarded };
}
