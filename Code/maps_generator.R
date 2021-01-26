# Required Packages -------------------------------------------------------

library(tidyverse)
library(here)

source("geometry_functions.R")
source("processing_func.R")
source("plotting_map.R")


# Parameter Setting -------------------------------------------------------
pixel.wide = 3000
pixel.high = 3000

map.par <- list(
    gen.point = 15,
    seed = 33,
    start.length = 15,
    start.angle = 35,
    streets.prop = c(0.5, 0.7, 0.85, 0.95, 1.5, 2, 2.5),
    max.branches = 4,
    repetitions = 400
)

set.seed(map.par$seed)

# Create map  -------------------------------------------------------------
x <- create_map(map.par)
pic <- lay.fundation(x)

# Save map in folder ------------------------------------------------------

# This comes from Dr. Danielle Navarro Youtube series:
# https://www.youtube.com/watch?v=qxgzUWMhI4o&list=PLRPB0ZzEYegNYW3ksiK3dvd6S4HMfKj1n&index=6
# It save the image with the name specifying the parameters.
filename <- map.par %>% 
    str_c(., collapse = "-") %>% 
    str_c("map_", ., ".tiff", collapse = "")


ggsave(
    filename = filename,
    path = here("img"),
    plot = pic,
    width = pixel.wide/300,
    height = pixel.high/300,
    dpi = 300
)






