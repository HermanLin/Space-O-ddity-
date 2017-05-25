boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean zPressed = false;
GameController gm;

void setup() {
  size(1200, 800, P3D);
  background(0);
  ortho();
  gm = new GameController();
}

void draw() {
  if (upPressed) {
    gm.playerInput(1);
  } else {
   gm.playerInput(2);
  }

  if (leftPressed) {
    gm.playerInput(3);
  }
  if (rightPressed) {
    gm.playerInput(4);
  }
  gm.move();
  gm.render();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = true;
    } else if (keyCode == LEFT) {
      leftPressed = true;
    } else if (keyCode == RIGHT) {
      rightPressed = true;
    } else if (keyCode == Z) {
      zPressed = true;
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
    } else if (keyCode == Z) {
      zPressed = false;
    }
  }
}