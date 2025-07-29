module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)


expectedMinutesInOven = 40

preparationTimeInMinutes numLayers = 2 * numLayers

elapsedTimeInMinutes numLayers timeInOven = (preparationTimeInMinutes numLayers) + timeInOven
