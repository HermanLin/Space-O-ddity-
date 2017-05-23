Player player;
boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup() {
  size(1000, 600);
  background(0);
  player = new Player();
  frameRate(24);
}

void draw() {
  player.render();
  player.rotate(0.1);
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