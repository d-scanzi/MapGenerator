## These are trigonometric and geometric functions which are necessary to compute the length, 
## The angle and the position of the segments.



# Converting degrees to radiant: R sin/cos/tan functions require angles in radiant
# However, it is easier to think in degrees, hence this code uses degrees and then convert them into
# radiant when necessary
to_radians <- function(degree){
    
    prop <- degree / 360
    rads <- prop * 2 * pi
    return(rads)
}



# Computing slope of segment: it uses the classic formula (y2-y1)/(x2-x1)
# Input has to be the tibble containing the coordinates of the street for which the slope has to be computed
find_slope <- function(segment){
    
    # Check whether the angle is 90 or 270 degrees. In this case the two extremes of the segment will have the same x-coordinates
    # In this case the slope is randomly selected to create a less precise output
    if(segment$entrance.x == segment$exit.x){
        
        sl = sample(x = 0.1:1, 
                    size = 1)
    } 
    
    # Compute the slope for all the other angles
    else {
        sl <- (segment$exit.y - segment$entrance.y)/(segment$exit.x - segment$entrance.x)
        return(sl)
    }
    
}




# find distance between two points, that is the length of a street(segment)
find_dist <- function(segment){
    
    dist <- sqrt(((segment$entrance.x - segment$exit.x)^2) + ((segment$entrance.y - segment$exit.y)^2))
    return(dist)
}



# Computing perpendicular segments: provided an input road and a point on it, it returns the coordinates of a point(exit of the new road)
# So that the segment(road) between the two points is perpendicular to the input road.
# It uses two different systems based on whether the input road has slope == 0 (flat line) or not
# It returns the exit point coordinates as a tibble
find_perp <- function(origin, x, y){
    
    # Check if the origin line is flat, if so the new segment exit are obtained by shifting the y-entrance
    if(find_slope(origin) == 0){
        new.x <- x
        
        # the length is randomly modified sampling one of the user-parameters in map.par(street.prop)
        new.y <- y + (find_dist(origin) / sample(x = map.par$streets.prop, size = 1))
    } 
    
    # Otherwise solve the system of point-slope formulas
    else{
        
        # Keep the roads perpendicular to each other
        slope.new <- -1 / find_slope(origin)
        
        alpha <- sample(x = -10:10, 
                        size = 1) 
        
        # Point-Slope system
        new.x <- ((slope.new*x) - y - (tan(to_radians(alpha))*origin$entrance.x) + origin$entrance.y) / 
            (slope.new - tan(to_radians(alpha)))
        
        
        # Because the system develops randomly, sometimes the result of new.x is Inf(because of the combinations of factors)
        # In this case the new length is randomly set between 1 and 100
        if(new.x == Inf){
            new.x <- runif(1:100)
            new.y <- slope.new * (new.x - x) + y
        }
        
        else{
            new.y <- slope.new * (new.x - x) + y
        }
        
    }
    
    # Return the results as a tibble
    new.exit <- tibble(
        new.exit.x = new.x,
        new.exit.y = new.y
    )
    return(new.exit)
    
}