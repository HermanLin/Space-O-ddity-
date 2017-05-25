
class GameController {
  LList shots;
  Player player;

  void GameController() {
    player = new Player();
  }
  
  void playerInput(int state){
    if (state == 1)
      player.vel = new PVector(10 * cos(player.angle), 10 * sin(player.angle), 0);
      if (state == 2)
      player.vel = new PVector(0, 0, 0);
      if (state == 3)
      player.rotate(-1 * PI / 16);
      if (state == 4)
      player.rotate(PI / 16);
  }
  
  void move(){
      player.move();
  }
  void render(){
     player.render(); 
  }
  
  boolean playerShoot() {

    //shots.add(player.shoot()); 
    return true;
  }
}