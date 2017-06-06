import java.util.*;

//player reference
Player player;

//input references
boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean zedPressed = false;

//data structure references
LinkedList<Player.Shot> shots;
GameObject[] objs;
Asteroid.Collider col;
ArrayList<Asteroid> asteroids;
ArrayList<VFX> vfxs;

PriorityQueue<Asteroid> toSpawn;

//animation references
PImage[] explosion;
PImage[] playDeath;

//other variables
int maxAst; //cap on asteroids spawned

void setup() {
  size(1200, 800, P3D);
  background(0);
  frameRate(24);
  ortho();

  //set references
  player = new Player();
  asteroids = new ArrayList<Asteroid>();
  shots = new LinkedList<Player.Shot>();
  vfxs = new ArrayList<VFX>();
  toSpawn = new PriorityQueue<Asteroid>();
  maxAst = 1;
  spawnAsteroids();

  explosion = preLoad("exp", 9);
  playDeath = preLoad("play", 11);
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
    zedPressed = false;
  }

  background(0);
  player.render();

  moveAsteroids();
  renderAsteroids();
  renderVFXS();

  moveShots();

  spawnAsteroids();
}

void moveAsteroids() {
  for (int i = asteroids.size() - 1; i  >= 0; i--) {
    Asteroid ast = asteroids.get(i);
    if (ast.move())
      asteroids.remove(i);
  }
}

void moveShots() {
  if (shots.size() > 0) {
    Iterator it = shots.iterator();
    while (it.hasNext()) {
      boolean removed = false;
      Player.Shot sht = (Player.Shot) it.next();
      if (sht.move()) {
        it.remove();
        removed = true;
      } else if (! removed) {
        for (int i = asteroids.size() - 1; i  >= 0; i--) {
          Asteroid ast = asteroids.get(i);
          if (ast.getCollider().intersects(sht.shotLoc)) {
            it.remove();
            vfxs.add(new VFX(explosion, ast.pos));
            asteroids.remove(i);
            removed = true;
          }
        }
      }
      if (! removed)
        sht.render();
    }
  }
}

void spawnAsteroids() {
  
  for (int i = 0; i < maxAst - asteroids.size(); i++) {
   int x = ((int) random(0, width));
   if (x >= width / 2)
   x += width/2;
   else
   x -= width/2;
   int y = ((int) random(0, height));
   if (y >= height / 2)
   y += height/2;
   else
   y -= height/2;
  //int x = 630;
  //int y = 630;

  int vx = 5;
  int vy = 5;
  if (x > width/2) {
    if (y < height/2) {
      vx *= -1;
    } else {
      vx *= -1;
      vy *= -1;
    }
  } else {
    if (y > height/2) {
      vy *= -1;
    }
  }
  

  Asteroid ast = new Asteroid(new PVector(x, y), new PVector(vx, vy));
  //toSpawn.add(ast);

  asteroids.add(ast);
}
}



void renderAsteroids() {
  for (Asteroid ast : asteroids) {
    ast.spin();
    ast.render();
  }
}

void renderVFXS() {
  for (int i = vfxs.size() - 1; i  >= 0; i--) {
    if (vfxs.get(i).render()) {
      vfxs.remove(i);
    }
  }
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
  //else if (key == 'z' || key == 'Z') {
  //zedPressed = true;
  //}
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
    zedPressed = true;
  }
}

public PImage[] preLoad(String imagePrefix, int count) {
  PImage[] imagez = new PImage[count];

  for (int i = 0; i < count; i++) {
    String filename = "animations/" + imagePrefix + i + ".png";
    imagez[i] = loadImage(filename);
  }

  return imagez;
}