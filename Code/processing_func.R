## These are the functions that generates the streets and the map



# Generate first street(segment), using the parameters passed by the users in the map.par list.
# The gen.point is the point of origin, considered as the center point of the street, eg: gen.point = 10 --> C(10, 10)
# It returns a tibble containing the coordinates of the entrance and exit points of the street.
found_city <- function(parameters){
    
    # Creates a tibble containing the parameters of the extremes of the first street
    position <- tibble(
        entrance.x = map.par$gen.point - (map.par$start.length / 2) * cos(to_radians(map.par$start.angle)),
        entrance.y = map.par$gen.point - (map.par$start.length / 2) * sin(to_radians(map.par$start.angle)),
        exit.x = map.par$gen.point + (map.par$start.length / 2) * cos(to_radians(map.par$start.angle)),
        exit.y = map.par$gen.point + (map.par$start.length / 2) * sin(to_radians(map.par$start.angle))
        
    )
    
    return(position)
    
}



## Generates new roads from the origin: This function creates a random number of roads from a starting segment.
## The position of each new road is random 
## The possible maximum number of new road can be defined by the user
## Origin is the tibble containing the coordinates of the first segment
lay_roads <- function(origin){
    
    # find slope of segment of origin
    slope <- find_slope(segment = origin)
    
    # Select a random x coordinate for origin of new segment.
    # runif requires that min is lower than max, so we need to check this first
    if(origin$entrance.x < origin$exit.x){
        new.entrance.x <- runif(n = 1,
                                min = origin$entrance.x,
                                max = origin$exit.x)
    } 
    
    else{
        new.entrance.x <- runif(n = 1,
                                min = origin$exit.x, 
                                max = origin$entrance.x)
    }
    

    # Find new y coordinate of point laying on the segment of origin
    # It uses the point-slope formula 
    new.entrance.y <- slope * (new.entrance.x - origin$entrance.x) + origin$entrance.y

    # find coordinates of new segment exit
    new.exit <- find_perp(origin = origin, x = new.entrance.x, y = new.entrance.y)

    # Save the coordinates in a tibble
    result <- (tibble(entrance.x = new.entrance.x,
                      entrance.y = new.entrance.y,
                      exit.x = new.exit[["new.exit.x"]],
                      exit.y = new.exit[["new.exit.y"]]))
    return(result)
}



# Repeating functions -----------------------------------------------------
# These functions create a map by reiterating the creation processes.


# Select a number of new road and create them from the original road. It save the output in two tibbles:
# They will be used by the create_map function to store all the roads and to work on them.
repeat_road <- function(origin){
    
    hist <- tibble()
    work <- tibble()

    # Select a random of new road to brach off the origin-road
    for(i in 1:sample(map.par$max.branches, size = 1)){
        
        # Create a new road
        roadi <- lay_roads(origin = origin)
        
        # Store the new road in the two dataframes
        hist <- hist %>% bind_rows(roadi)
        work <- work %>% bind_rows(roadi)
    }
    return(list(log = hist, 
                working = work))
}


# create the map
stop.map <- FALSE

create_map <- function(par){
    
    # The street.log is a tibble that stores all the created roads and it is used to plot the map.
    # The working.df is a tibble that stores all the new roads and is used to select the road to work on
    # Once the road has been processed(i.e new roads are created from it), the road is removed from this dataframe
    street.log <- tibble()
    working.df <- tibble()
    
    
    # Start the creation of the map: lay the first road and store it for next steps. 
    while (stop.map == FALSE) {
        
        first.road <- found_city(par)
        street.log <- street.log %>% bind_rows(first.road)
        working.df <- working.df %>% bind_rows(first.road)
        
    # start to grow streets: reiterate the process for the number of time specified by the user.
        for(rep in 1:par$repetitions){

            # Select the first road to work on from working.df
            rd <- working.df[1, ]
            
            # Create branching roads from the selected road
            new.rds <- repeat_road(rd)
            
            # Store the new created roads in street.log for plotting and in working.df for further processing
            street.log <- street.log %>% bind_rows(new.rds[["log"]])
            working.df <- working.df %>% bind_rows(new.rds[["working"]])

        # Eliminate the road from the working data set
            working.df <- working.df[-1, ]

        
    }
    
    # stop creating
    stop.map <- TRUE
    
    }
    return(street.log)
}
    
    
    
    