class Player extends GameObject {
  //INSTANCE VARIABLES
  float r = 10;
  int shotCooldown;
  int score = 0;
  int lives = 3;

  Player() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    angle = 0;
    model = loadShape("ship.obj");
    model.scale(7);
    model.rotateY(PI / 2);
    model.rotateZ(PI / 2);
  }

  boolean isDead() {
    return lives == 0;
  }

  boolean contact() {
    return true;
  }
  
  Shot shoot() {
    return new Shot(); 
  }
  
  void move() {
    if (pos.x < 0 || pos.x > 1200)
      vel = new PVector(0, 0, 0);
    if (pos.y < 0 || pos.y > 800)
      vel = new PVector(0, 0, 0);
    pos = pos.add(vel);
  }

  void rotate (float theta) {
    angle += theta;
    model.rotateZ(theta);
  }

  void render() {
    lights();
    noFill();
    stroke(255);
    translate(pos.x, pos.y);
    background(0);
    shape(model);
  }

  class Shot {
    //VFX look;
    PVector shotPos;
    PVector shotVel;
    
    Shot(){
      shotPos = new PVector(pos.x + 20 * cos(angle), pos.y + 40 * sin(angle), 0);
      shotVel = new PVector(30 * cos(angle), 30 * sin(angle), 0);
    }

    boolean contact() {
      return true;
    }

    void move() {
      shotPos = shotPos.add(shotVel);
    }
  }
}