class Bimap
  @_colors: { "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white" }
  @_encoding: { c, i - 1 for i, c in ipairs @_colors }
    
  @colors: -> [ c for c in *@_colors ]
  @value: (color) -> @_encoding[color]

color_code = Bimap.value
colors = Bimap.colors

{ :colors, :color_code }

