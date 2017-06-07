# Space O(ddity)

## Herman Lin, Ricky Chen, Victor Teoh


#### Asteroids3D


###### What is it?
Our game Asteroids3D is a tribute to the retro Asteroids game but with
additional features. We implemented 3D models into the game in order to
create a sort of pseudo 3D world while still keeping the main goal of
the game to protect your ship from incoming asteroids.
###### How does it work?
The game first sets the variables needed to run the game such as a new
Player and creating new data structures used to process the asteroids.
Everytime the draw function is run, the basics of the game checks for
player movement, shot spawning, and asteroid spawning. It also goes 
through each object, rendering it when necessary. 


The models for the player and asteroids are made using .obj and .mtl 
files. Obj files are 3D image formats that use several coordinates to 
create 3D objects. Mtl files map textures and colors onto the obj files
to give the 3D objects more than a blank surface. The animations created
are rendered through the use of PImage and arrays.


###### Controls
Up Arrow - move player forward		

Left/Right Arrow - rotate the player		

Z - shoots bullets to destroy asteroids		

###### Launch Instructions
1) Open the game in Processing
2) Click the 'Run' button or press 'ctrl + r'
