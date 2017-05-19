class Player extends GameObject {
  //INSTANCE VARIABLES
  private int shotCooldown;
  private int score;
  private int lives;
  //private VFX boosters;

  boolean isDead() {
  }

  Shot shoot() {
  }

  void move() {
  }

  void rotate (double theta) {
  }

  boolean contact() {
  }

  class Shot {
    //VFX look;
    PVector shotLoc = new PVector(location.x + 20 * cos(angle), location.y + 40 * sin(angle), 0);
    PVector shotVelocity = new PVector(30 * cos(angle), 30 * sin(angle), 0);

    boolean contact() {
    }

    void move() {
    }
  }
}