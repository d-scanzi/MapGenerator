# MapGenerator
Generative Art program that produces modern-looking city maps. All the created streets are perpendicular to each other by default, hence all the streets have 90 degrees angle. New streets are created from existing one, according to a reiterative process that:

1. selects the street of origin
2. selects a random point on this street
3. selects a random length for the new street (see section below)
4. creates the new streets 

Therefore this program is so created to ensure the highest variability possible. 

![scrawl_0-30-15-45-c(0.5, 0.7, 0.85, 0.95, 1.5, 2, 2.5)-5-600.jpeg](https://github.com/d-scanzi/MapGenerator/blob/main/images/scrawl_0-30-15-45-c(0.5%2C%200.7%2C%200.85%2C%200.95%2C%201.5%2C%202%2C%202.5)-5-600.jpeg)

![scrawl_130-30-10-35-c(0.5, 0.7, 0.85, 0.95, 1.5, 2, 2.5)-5-600.jpeg](https://github.com/d-scanzi/MapGenerator/blob/main/images/scrawl_130-30-10-35-c(0.5%2C%200.7%2C%200.85%2C%200.95%2C%201.5%2C%202%2C%202.5)-5-600.jpeg)

![scrawl_5-30-15-45-c(0.2, 0.4, 0.5, 0.7, 0.85, 0.95, 2)-5-500.png](https://github.com/d-scanzi/MapGenerator/blob/main/images/scrawl_5-30-15-45-c(0.2%2C%200.4%2C%200.5%2C%200.7%2C%200.85%2C%200.95%2C%202)-5-500.png)

![scrawl_30-30-10-35-c(0.5, 0.7, 0.85, 0.95, 1.5, 2, 2.5)-5-600.png](https://github.com/d-scanzi/MapGenerator/blob/main/images/scrawl_30-30-10-35-c(0.5%2C%200.7%2C%200.85%2C%200.95%2C%201.5%2C%202%2C%202.5)-5-600.png)

![scrawl_red15-2-15-68-c(0.5, 0.7, 0.85, 0.95, 1.5, 2, 2.5)-4-400.png](https://github.com/d-scanzi/MapGenerator/blob/main/images/scrawl_red15-2-15-68-c(0.5%2C%200.7%2C%200.85%2C%200.95%2C%201.5%2C%202%2C%202.5)-4-400.png)

![scrawl_red15-4-15-68-c(0.5, 0.7, 0.85, 0.95, 1.5, 2, 2.5)-4-400.png](https://github.com/d-scanzi/MapGenerator/blob/main/images/scrawl_red15-4-15-68-c(0.5%2C%200.7%2C%200.85%2C%200.95%2C%201.5%2C%202%2C%202.5)-4-400.png)




## Selecting lenght of new streets
To create a new street two input are considered:

1. the point-slope system with center in the new origin
2. the point-slope system with center in the "entrance" of the existing street

Because the point-slope formula is: y-y0 = m(x-x0) requires a slope, the slope for the first system is set to be perpendicular to the slope of the existing road (-1/m). While the second slope is computed as the tangent of the angle between the entrance of the first road and the street of origin. Because this angle is selected randomly, the length of the new road (which exit point is the solution of the system) is random too. 


## NOTES
While this programs works fine, it has some limits. In particular, because most of the variable values are selected randomly, some computations might end up with an error. I tried to take care of most of these problems. Two main problem is the slope and the length of new street. If a street has an angle of 90 or 270 degrees the slope would be +/- Infinite. This program tries to catch this and in these cases it modifies the slope, selecting a random value between 0.1 and 1 (arbitrary choice, however 0 is excluded to not introduce other errors). As explained above, the length of a street is obtained trough the random selection of and angle. By default this selection is limited to the range [-10, 10]. Other ranges would be possible, but this specific one seems to not produce errors and to produce the best maps. 

plotting
Feel free to tweak the code and to try different options. The colours for the map can be changed in the plotting_map.R file, inside the ggplot function. 
