class VFX {  
  
  //instance variables
  PImage[] images;
  int imageCount;
  int frame;
  PVector pos;
  
  //constructor
  VFX(PImage[] ray, PVector Pos) {
    imageCount = ray.length;
    images = ray;
    frame = 0;
    pos = Pos;
  } 

  //image rendering
  boolean render() {
    imageMode(CENTER);
    image(images[frame], pos.x, pos.y);
    if (frame + 1 > imageCount - 1)
       return true; 
    else{
      frame += 1;
      return false;
    }
  }
}