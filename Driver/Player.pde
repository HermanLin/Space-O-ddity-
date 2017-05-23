class Player extends GameObject{
  //INSTANCE VARIABLES
  float r = 10;
  int shotCooldown;
  int score = 0;
  int lives = 3;

  Player() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    model = createShape();
    model.beginShape();
    model.fill(255);
    model.noStroke();
    model.vertex(-r, r);
    model.vertex(r, r);
    model.vertex(0, -r);
    model.endShape(CLOSE);
    angle = PI/64;
  }

  boolean isDead() {
    return lives == 0;
  }

  boolean contact() {
    return true;
  }

  void move() {
  }

  void rotate (float theta) {
    angle += theta;
  }

  void render() {
    noFill();
    stroke(255);
    translate(pos.x, pos.y);
    background(0);
    shape(model);
    model.rotate(angle);
  }

  class Shot {
    //VFX look;
    PVector shotLoc = new PVector(pos.x + 20 * cos(angle), pos.y + 40 * sin(angle), 0);
    PVector shotVelocity = new PVector(30 * cos(angle), 30 * sin(angle), 0);

    boolean contact() {
      return true;
    }

    void move() {
    }
  }
}