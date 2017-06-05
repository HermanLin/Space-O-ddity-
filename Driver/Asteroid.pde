class Asteroid extends GameObject implements Comparable{

  Asteroid(PVector position, PVector velocity) {
    pos = position;
    vel = velocity;
    angle = 0;
    model = loadShape("asteroid2.obj");
    model.scale(8);
  }
  void move() {
    pos = pos.add(vel);
  }
  void spin() {
    model.rotateX(PI / 64);
    model.rotateY(PI / 64);
  }

  void render() {
    pushMatrix();
    lights();
    translate(pos.x, pos.y);
    shape(model);
    popMatrix();
  }
  void offScreenDestroy() {
  }
  Collider getCollider() {
    return new Collider();
  }
  
  int compareTo(Object ast){
   return 0; 
  }

  class Collider {
    PVector focus1;
    PVector focus2;
    int distance;

    Collider() {
      focus1 = new PVector((pos.x - 25), pos.y);
      focus2 = new PVector((pos.x + 25), pos.y);
      distance = 100;
    }

    boolean intersects(PVector other) {
      if (dist(other.x, other.y, focus1.x, focus1.y)
        + dist(other.x, other.y, focus2.x, focus2.y)
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