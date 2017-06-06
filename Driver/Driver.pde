import java.util.*;

//player references
Player player;
PFont scre;

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
long nextIncrease; //next time to increase cap
boolean isDead;

void setup() {
  size(1200, 800, P3D);
  background(0);
  frameRate(24);
  ortho();

  //set references
  player = new Player();
  scre = createFont("Arial", 16, true);
  
  asteroids = new ArrayList<Asteroid>();
  shots = new LinkedList<Player.Shot>();
  vfxs = new ArrayList<VFX>();
  toSpawn = new PriorityQueue<Asteroid>();
  
  maxAst = 2;
  nextIncrease = System.currentTimeMillis() + 15000;
  

  explosion = preLoad("exp", 9, 133, 250);
  playDeath = preLoad("play", 11, 150, 300);

  //spawn first wave
  spawnAsteroids();
}

void draw() {
  if (!isDead) {
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
  }

  //check if player died
  for (Asteroid ast : asteroids) {
    if (ast.getCollider().intersects(player.pos, 30))
      isDead = true;
  }

  // hide model when player dies
  if (player.model.isVisible() && isDead) {
    player.model.setVisible(false);
    vfxs.add(new VFX(playDeath, player.pos));
  }

  background(0);
  
  player.render();

  moveAsteroids();

  //check collisions
  moveShots();

  spawnAsteroids();

  renderAsteroids();
  renderVFXS();
  
  if (!isDead)
    displayScore();
  else
    displayDeath();


  if (maxAst < 10 && System.currentTimeMillis() > nextIncrease ) {
    maxAst += 1;
    nextIncrease += 15000;
  }
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
          if (ast.getCollider().intersects(sht.shotLoc, 0.0)) {
            it.remove();
            vfxs.add(new VFX(explosion, ast.pos));
            asteroids.remove(i);
            removed = true;
            player.score += 10;
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

void displayScore(){
  textFont(scre, 16);
  fill(255);
  text("Score: " + player.score, 10, 30);
}

void displayDeath(){
  textFont(scre, 42);
  fill(255);
  text("GAME OVER", width / 2 - 110, height / 2);
  
  textFont(scre, 16);
  fill(255);
  text("Final Score: " + player.score, width / 2 - 30, height / 2 + 40);
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

public PImage[] preLoad(String imagePrefix, int count, int w, int h) {
  PImage[] imagez = new PImage[count];

  for (int i = 0; i < count; i++) {
    String filename = "animations/" + imagePrefix + i + ".png";
    imagez[i] = loadImage(filename);
    imagez[i].resize(w, h);
  }

  return imagez;
}