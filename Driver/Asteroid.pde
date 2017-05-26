class Asteroid extends GameObject {

  Asteroid(PVector position, PVector velocity){
     pos = position;
     vel = velocity;
     model = loadShape("asteroid2.obj");
     model.scale(10);
  }
  void move() {
    pos = pos.add(vel);
  }
  void spin() {
    rotate(random(PI/64, PI/32));
  }
  
  void render() {
    lights();
    translate(pos.x, pos.y);
    shape(model);
  }
  void offScreenDestroy() {
  }
  Collider getCollider() {
    return new Collider();
  }

  class Collider {
    PVector focus1;
    PVector focus2;
    int distance;

    Collider() {
    }

    float distanceFrom() {
      return 0.0;
    }
  }
}