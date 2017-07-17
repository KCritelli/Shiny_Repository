percent_map = function(var, color, legend.title, min = 0, max = 100) {
  
  shades = colorRampPalette(c('white', color))(100)
  
  var = pmax(var, min)
  var = pmin(var, max)
  percents = as.integer(cut(var, 100,
                            include.lowest = TRUE, ordered = TRUE))
  fills = shades[percents]
} 