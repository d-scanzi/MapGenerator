# Plot first street of the map
lay.fundation<- function(position, plot2 = FALSE){
    ggplot(data = position,
                   mapping = aes(x = entrance.x,
                                 y = entrance.y,
                                 xend = exit.x,
                                 yend = exit.y)) +
        geom_segment(alpha = 0.7, 
                     lwd = 1,
                     colour = "#c0c0c0") +
        coord_equal() +
        theme_void() + 
        
        theme(plot.background = element_rect(fill = "#800020" ))
        
}

