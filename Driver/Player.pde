class Player {
  //INSTANCE VARIABLES
  PVector pos;
  PVector vel;
  PVector acc;
  float r = 10;
  float angle;
  PShape model;
  int shotCooldown;
  int score = 0;
  int lives = 3;

  Player() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    angle = 0.2;
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
    rotate(angle);
    translate(pos.x, pos.y);
    triangle(-r, r, r, r, 0, -r);
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