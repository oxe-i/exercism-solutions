Allergies = {}

scores = {
  eggs: 1 << 0,
  peanuts: 1 << 1,
  shellfish: 1 << 2,
  strawberries: 1 << 3,
  tomatoes: 1 << 4,
  chocolate: 1 << 5,
  pollen: 1 << 6,
  cats: 1 << 7
}

allergens = {
  'eggs',
  'peanuts',
  'shellfish',
  'strawberries',
  'tomatoes',
  'chocolate',
  'pollen',
  'cats'
}

Allergies.allergic_to = (item, score) ->
  (score & scores[item]) != 0

Allergies.list = (score) ->
  [ a for i, a in ipairs allergens when ((1 << (i - 1)) & score) != 0 ]

  
return Allergies
