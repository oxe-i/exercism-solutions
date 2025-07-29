/// <reference path="./global.d.ts" />
// @ts-check

/**
 * Implement the functions needed to solve the exercise here.
 * Do not forget to export them so they are available for the
 * tests. Here an example of the syntax as reminder:
 *
 * export function yourFunction(...) {
 *   ...
 * }
 */

export const cookingStatus = (remainingTime) => {
  if (remainingTime === 0) {
    return 'Lasagna is done.';
  }
  else if (remainingTime != undefined) {
    return 'Not done, please wait.';
  }

  return 'You forgot to set the timer.';
}

export const preparationTime = (layers, averagePreparationTime) =>
  averagePreparationTime === undefined ? 2 * layers.length :
                     averagePreparationTime * layers.length;

export const quantities = (layers) => {
  return {
  noodles: 50 * layers.filter((layer) => layer === 'noodles')?.length,
  sauce: 0.2 * layers.filter((layer) => layer === 'sauce')?.length
  };
}

export const addSecretIngredient = (friendsList, myList) => {
  myList.push(friendsList.at(-1));
}

export const scaleRecipe = (recipe, numberOfPortions) => {
  const scaledRecipe = {};
  const scaleFactor = numberOfPortions / 2;
  
  for (let key in recipe) {
    scaledRecipe[key] = recipe[key] * scaleFactor;
  }

  return scaledRecipe;
}