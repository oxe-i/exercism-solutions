export const getFirstCard = ([f,]) => f;
export const getSecondCard = ([,s,]) => s;
export const swapTopTwoCards = ([f,s,...r]) => [s,f,...r];
export const discardTopCard = ([f,...r]) => [f, r];

const FACE_CARDS = ['jack', 'queen', 'king'];
export const insertFaceCards = ([f,...r]) => [f,...FACE_CARDS,...r];
