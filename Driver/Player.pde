class Player extends GameObject {
  //INSTANCE VARIABLES
  int shotCooldown;
  int score = 0;
  int lives = 3;

  Player() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    angle = 0;
    //shapeMode(CENTER);
    model = loadShape("ship.obj");
    model.scale(7);
    
    model.rotateX(PI / 2);
    model.rotateY(PI / 2);
    //model.rotateZ(PI / 2);
    //model.translate(-30, -30);
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

  void rotate (float theta) {
    angle += theta;
    //model.rotateZ(theta);
    //model.rotateX(theta);
  }
  
  void render() {
    pushMatrix();
    lights();
    noFill();
    stroke(255);
    translate(pos.x, pos.y);
    rotateZ(angle);
    shape(model);
    popMatrix();
  }

  class Shot {
    //VFX look;
    PVector shotLoc;
    PVector shotVelocity;
    float shotAngle;
    PImage vfx;
    
    Shot(){
      shotLoc = new PVector(int(pos.x + 20 * cos(angle)), int(pos.y + 40 * sin(angle)), 0);
       shotVelocity = new PVector(30 * cos(angle), 30 * sin(angle), 0);
       shotAngle = angle;
       vfx = loadImage("shot.png");
       vfx.resize(60, 40);
       
    }

    boolean contact() {
      return true;
    }

    void move() {
      shotLoc = shotLoc.add(shotVelocity);
    }
    
    void render(){
      pushMatrix();
      translate(shotLoc.x, shotLoc.y);
      rotateZ(shotAngle + PI / 2);
      image(vfx, 0,0);
      popMatrix();
    }
  }
}