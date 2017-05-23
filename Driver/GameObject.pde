abstract class GameObject {
  //INSTANCE VARIABLES
  PVector pos;
  PVector vel;
  PShape model;
  float angle;
  boolean dead;

  //Constructor for a default object
  GameObject() {
    pos = new PVector (0, 0, 0);
    vel = new PVector (0, 0, 0);
    angle = 0;
  }
}