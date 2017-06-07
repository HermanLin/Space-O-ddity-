import java.util.*;

//player references
Player player;
PFont scre;

//player input references
boolean upPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean zedPressed = false;

//data structure references
LinkedList<Player.Shot> shots;
GameObject[] objs;
Asteroid.Collider col;
LinkedList<Asteroid> asteroids;
ArrayList<VFX> vfxs;
PriorityQueue<Asteroid> toSpawn;

//animation references
PImage[] explosion;
PImage[] playDeath;
PImage[] background;

//other variables
int maxAst; //cap on asteroids spawned
long nextIncrease; //next time to increase cap
boolean isDead; //if player is dead or not
int currentFrame; //loop background animation
PShape astModel; // preload asteroid model

void setup() {
  //setup screen
  size(1200, 800, P3D);
  background(0);
  frameRate(24);
  ortho();

  //set player reference
  player = new Player();
  scre = createFont("Arial", 16, true);
  
  //set asteroid references
  astModel = loadShape("asteroid2.obj");
  astModel.scale(8);
  
  //set data structure references
  asteroids = new LinkedList<Asteroid>();
  shots = new LinkedList<Player.Shot>();
  vfxs = new ArrayList<VFX>();
  toSpawn = new PriorityQueue<Asteroid>();
  
  queueAst(); //start game with one asteroid enqueued
  
  maxAst = 2; //way of increasing difficulty
  nextIncrease = System.currentTimeMillis() + 15000;
  currentFrame = 0;

  //load animations for when needed
  explosion = preLoad("exp", 9, 133, 250);
  playDeath = preLoad("play", 11, 150, 300);
  background = preLoad("space", 7, width, height);

  //spawn first wave
  spawnAsteroids();
}

void draw() {
  //player movement
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
    //player shooting
    if (zedPressed) {
      shots.addLast(player.shoot());
      zedPressed = false; //ensures player cannot spam shots
    }
  }

  //check if player collides with an asteroid
  for (Asteroid ast : asteroids) {
    if (ast.getCollider().intersects(player.pos, 30))
      isDead = true;
  }

  // hide model when player dies
  if (player.model.isVisible() && isDead) {
    player.model.setVisible(false);
    vfxs.add(new VFX(playDeath, player.pos));
  }

  //animate background
  if (currentFrame % 7 == 0)
    currentFrame = 0;
  background(background[currentFrame]);
  currentFrame += 1;

  player.render();
  
  moveAsteroids();
  moveShots();

  spawnAsteroids();

  renderAsteroids();
  renderVFXS();

  //if player dies, display death screen, otherwise display score
  if (!isDead)
    displayScore();
  else
    displayDeath();
  
  //increase "difficulty/level" every 15 seconds
  if (maxAst < 10 && System.currentTimeMillis() > nextIncrease ) {
    maxAst += 1;
    nextIncrease += 15000; 
    queueAst(); //enqueue a new asteroid to increase difficulty
  }

  if (asteroids.size() == 0) {
    spawnAsteroids();
  }
}

//asteroid movement for each asteroid within the queue
void moveAsteroids() {
  for (int i = asteroids.size() - 1; i  >= 0; i--) {
    Asteroid ast = asteroids.get(i);
    if (ast.move()){
      asteroids.remove(i);
      queueAst();
    }
  }
}

//shot movement withing the LinkedList
void moveShots() {
  if (shots.size() > 0) {
    //iterate through each Shot
    Iterator it = shots.iterator();
    while (it.hasNext()) {
      boolean removed = false;
      Player.Shot sht = (Player.Shot) it.next();
      if (sht.move()) {
        it.remove();
        removed = true;
      } else if (! removed) {
        Iterator as = asteroids.iterator();
        while (as.hasNext()) {
          Asteroid ast = (Asteroid) as.next();
          //check if shot has collided with an asteroid
          if (ast.getCollider().intersects(sht.shotLoc, 0.0)) { 
            it.remove();
            vfxs.add(new VFX(explosion, ast.pos));
            as.remove();
            removed = true;
            player.score += 10;
            queueAst();
          }
        }
      }
      if (! removed)
        sht.render();
    }
  }
}

//helper for rendering asteroids within the queue
void spawnAsteroids() {
  //dequeue asteroids
  for (int i = 0; i < toSpawn.size(); i++) {
    asteroids.add(toSpawn.poll());
  }
}

//enqueue a new asteroid to the queue
void queueAst() {
  //enqueue asteroids
  int x = ((int) random(0, width));
  //set x offscreen
  if (x >= width / 2)
    x += width/2;
  else
    x -= width/2;
  //set y offscreen
  int y = ((int) random(0, height));
  if (y >= height / 2)
    y += height/2;
  else
    y -= height/2;

  //orient vector towards center
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

  Asteroid ast = new Asteroid(new PVector(x, y), new PVector(vx, vy), astModel);
  toSpawn.add(ast);
}

//render asteroids within the queue
void renderAsteroids() {
  for (Asteroid ast : asteroids) {
    ast.spin();
    ast.render();
  }
}

//render images 
void renderVFXS() {
  for (int i = vfxs.size() - 1; i  >= 0; i--) {
    if (vfxs.get(i).render()) {
      vfxs.remove(i);
    }
  }
}

//display player score
void displayScore() {
  textFont(scre, 16);
  fill(255);
  text("Score: " + player.score, 10, 30);
}

//display player death screen
void displayDeath() {
  textFont(scre, 42);
  fill(255);
  text("GAME OVER", width / 2 - 110, height / 2);

  textFont(scre, 16);
  fill(255);
  text("Final Score: " + player.score, width / 2 - 30, height / 2 + 40);
}

//mothods for recording player inputs
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
  } else if (key == 'z' || key == 'Z') {
    zedPressed = true;
  }
}

//preloader for images to create animations
public PImage[] preLoad(String imagePrefix, int count, int w, int h) {
  PImage[] imagez = new PImage[count];

  for (int i = 0; i < count; i++) {
    String filename = "animations/" + imagePrefix + i + ".png";
    imagez[i] = loadImage(filename);
    imagez[i].resize(w, h);
  }

  return imagez;
}