class Asteroid extends GameObject {
  
  //instance variables
  float angleX, angleY;

  //constructor
  Asteroid(PVector position, PVector velocity, PShape modl) {
    pos = position;
    vel = velocity;
    angle = angleX = angleY = 0;
    model = modl;
  }
  
  //asteroid movement
  boolean move() {
    pos = pos.add(vel);
    return offScreenDestroy();
  }
  
  //asteroid spin
  void spin() {
    //random spin angles
    angleX += random(PI / 64, PI / 32);
    angleY += random(PI / 64, PI / 32);
  }
  
  //asteroid rendering
  void render() {
    pushMatrix();
    lights();
    translate(pos.x, pos.y);
    rotateX(angleX);
    rotateY(angleY);
    shape(model);
    popMatrix();
  }
  
  //destroy asteroids when off screen
  boolean offScreenDestroy() {
    if (pos.x < - width / 2 - 20 || pos.x > 3 * width / 2 + 20
      || pos.y < - height / 2 - 20 || pos.y > 3 * height / 2 + 20)
      return true;
    else
      return false;
  }
  
  Collider getCollider() {
    return new Collider();
  }

  //Collider class
  class Collider {
    
    //instance variables
    PVector focus1;
    PVector focus2;
    int distance;
    
    //constructor
    Collider() {
      focus1 = new PVector((pos.x - 25), pos.y);
      focus2 = new PVector((pos.x + 25), pos.y);
      distance = 100;
    }
    
    //check to see if Player or Shot collides with asteroid
    boolean intersects(PVector other, float radius) {
      if (dist(other.x, other.y, focus1.x, focus1.y)
        + dist(other.x, other.y, focus2.x, focus2.y)
        + radius
        <= distance)
        return true;
      else
        return false;
    }

    //for dev purposes
    void render() {
      ellipse(pos.x, pos.y, 100, 86);
    }
  }
}