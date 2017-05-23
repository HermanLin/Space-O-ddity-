abstract class GameObject {
  //INSTANCE VARIABLES
  PVector location;
  PVector velocity;
  PShape model;
  float angle;
  boolean dead;

  //Constructor for a default object
  GameObject() {
    location = new PVector (0, 0, 0);
    velocity = new PVector (0, 0, 0);
    model = createShape (0, 0, 0, 0);
    angle = 0;
  }
}