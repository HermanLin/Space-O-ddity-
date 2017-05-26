Player player;
boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
Asteroid ass;

void setup() {
  size(1200, 800, P3D);
  background(0);
  player = new Player();
  frameRate(24);
  ortho();
  ass = new Asteroid(new PVector(random(0, width), random(0, height), 0),
                       new PVector(random(0, 10), random(0, 10), 0));
  
}

void draw() {
  if (upPressed) {
    player.vel = new PVector(10 * cos(player.angle), 10 * sin(player.angle), 0);
  } else {
    player.vel = new PVector(0, 0, 0);
  }

  if (leftPressed) {
    player.rotate(-1 * PI / 16);
  }
  if (rightPressed) {
    player.rotate(PI / 16);
  }
  background(0);
  player.move();
  player.render();
  ass.move();
  ass.render();
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = true;
    } else if (keyCode == LEFT) {
      leftPressed = true;
    } else if (keyCode == RIGHT) {
      rightPressed = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = false;
    } else if (keyCode == LEFT) {
      leftPressed = false;
    } else if (keyCode == RIGHT) {
      rightPressed = false;
    }
  }
}