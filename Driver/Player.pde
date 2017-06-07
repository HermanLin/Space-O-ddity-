class Player extends GameObject {
  
  //instance variables
  int shotCooldown;
  int score = 0;
  int lives = 3;
  float yAngle = 0;
  
  //constructor
  Player() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    angle = 0;

    model = loadShape("ship.obj");
    model.scale(7);

    //Ubuntu rotation
    model.rotateX(PI / 2);
    model.rotateY(PI / 2);

    //Windows rotation
    /*
    model.rotateX(PI / 2);
     model.rotateZ(PI / 2);
     */
    //model.translate(-30, -30);
  }
  
  //returns a shot
  Shot shoot() {
    return new Shot();
  }
  
  //player movement
  void move() {
    if (pos.x < 10)
      pos.x = width - 10;
    if (pos.x > width - 10)
      pos.x = 10;
    if (pos.y < 10)
      pos.y = height - 10;
    if (pos.y > height - 10)
      pos.y = 10;
    pos = pos.add(vel);
  }
  
  //player rotation
  void rotate (float theta) {
    angle += theta;
    //model.rotateZ(theta);
    //model.rotateX(theta);
  }
  
  //player rendering
  void render() {
    /* From web:
     (1) Translate space so that the rotation axis passes through the origin.     
     (2) Rotate space about the z axis so that the rotation axis lies in the xz plane.    
     (3) Rotate space about the y axis so that the rotation axis lies along the z axis.    
     (4) Perform the desired rotation by θ about the z axis.   
     (5) Apply the inverse of step (3).     
     (6) Apply the inverse of step (2).     
     (7) Apply the inverse of step (1).  */
    pushMatrix();
    lights();
    noFill();
    stroke(255);
    translate(pos.x, pos.y);
    rotateZ(angle);
    shape(model);
    popMatrix();
  }
  
  //shot class
  class Shot {
  
    //instance variables
    PVector shotLoc;
    PVector shotVelocity;
    float shotAngle;
    PImage vfx;
  
    //constructor
    Shot() {
      shotLoc = new PVector(int(pos.x + 20 * cos(angle)), int(pos.y + 40 * sin(angle)), 0);
      shotVelocity = new PVector(30 * cos(angle), 30 * sin(angle), 0);
      shotAngle = angle;
      vfx = loadImage("shot.png");
      vfx.resize(60, 40);
    }
    
    //shot movement
    boolean move() {
      shotLoc = shotLoc.add(shotVelocity);
      if (shotLoc.x < 0 || shotLoc.x > width
        || shotLoc.y < 0 || shotLoc.y > height)
        return true;
      else
        return false;
    }
    
    //shot rendering
    void render() {
      imageMode(CENTER);
      pushMatrix();
      translate(shotLoc.x, shotLoc.y);
      rotateZ(shotAngle + PI / 2);
      image(vfx, 0, 0);
      popMatrix();
    }
  }
}