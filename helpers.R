percent_map<-function(var,color,legend.title,min=0,max=100) {
  shades <- colorRampPalette(c("white", color))(100)
  # constrain gradient to percents that occur between min and max
  var <- pmax(var, min)
  var <- pmin(var, max)
  percents <- as.integer(cut(var, 100,
                             include.lowest = TRUE, ordered = TRUE))
  fills <- shades[percents]
  # plot choropleth map
  map("county", fill = TRUE, col = fills, resolution = 0,
      lty = 0, projection = "polyconic",
      myborder = 0, mar = c(0,0,0,0))
  map("state", col = "white", fill = FALSE, add = TRUE,
      lty = 1, lwd = 1, projection = "polyconic",
      myborder = 0, mar = c(0,0,0,0))
  inc <- (max - min) / 4
  legend.text <- c(paste0(min, " % or less"),
                   paste0(min + inc, " %"),
                   paste0(min + 2 * inc, " %"),
                   paste0(min + 3 * inc, " %"),
                   paste0(max, " % or more"))
  legend("bottomleft",
         legend = legend.text,
         fill = shades[c(1, 25, 50, 75, 100)],
         title = legend.title)
}