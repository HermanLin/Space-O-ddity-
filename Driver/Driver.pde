import java.util.*;

Player player;
Asteroid ast;
boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean zedPressed = false;
LinkedList<Player.Shot> shots;
BST colliders;
GameObject[] objs;
Asteroid.Collider col;
ArrayList<Asteroid> asteroids;

void setup() {
  size(1200, 800, P3D);
  background(0);
  player = new Player();
  frameRate(24);
  ortho();
  asteroids = new ArrayList<Asteroid>();
  asteroids.add(new Asteroid(new PVector(random(0, width), random(0, height), 0), 
    new PVector(random(0, 0), random(0, 0), 0)));  
  colliders = new BST();
  shots = new LinkedList<Player.Shot>();
  colliders.insert(ast.getCollider());
}

void draw() {
  if (upPressed) {
    player.vel = new PVector(10 * cos(player.angle), 10 * sin(player.angle), 0);
    player.move();
  } else {
    player.vel = new PVector(0, 0, 0);
    player.move();
  }

  if (leftPressed) {
    player.rotate(-1 * PI / 16);
  }
  if (rightPressed) {
    player.rotate(PI / 16);
  }
  if (zedPressed) {
    shots.addLast(player.shoot());
  }

  background(0);
  player.render();

  if (ast != null) {
    moveAsteroids();
    renderAsteroids();
    //col.render();
  }

  moveShots();
}

void moveAsteroids() {
  ast.move();
}

void moveShots() {
  if (shots.size() > 0) {
    Iterator it = shots.iterator();
    while (it.hasNext()) {
      Player.Shot sht = (Player.Shot) it.next();
      if (sht.move()) 
        it.remove();
      else {
        for (int i = asteroids.size();  i  < 0; i--) {
          Asteroid ast = asteroids.get(i);
          if (ast.getCollider().intersects(sht.shotLoc)){
            it.remove();
            asteroids.remove(ast.getCollider());
            asteroids.remove(i);
          }
        }
      } else
        sht.render();
    }
  }
}

void renderAsteroids() {
  ast.spin();
  ast.render();
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
  } else if (key == 'z' || key == 'Z') {
    zedPressed = true;
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
  } else if (key == 'z' || key == 'Z') {
    zedPressed = false;
  }
}