class Asteroid extends GameObject {

  Asteroid(PVector position, PVector velocity) {
    pos = position;
    vel = velocity;
    angle = 0;
    model = loadShape("asteroid2.obj");
    model.scale(10);
  }
  void move() {
    pos = pos.add(vel);
  }
  void spin() {
    model.rotateX(PI / 64);
    model.rotateY(PI / 64);
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
      focus1 = new PVector((pos.x + 20), pos.y);
      focus2 = new PVector((pos.x + 20), pos.y);
      distance = 40;
    }

    float distanceFrom() {
      return 0.0;
    }
  }
}