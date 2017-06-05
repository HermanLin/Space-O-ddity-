class VFX {
  PImage[] images;
  int imageCount;
  int frame;
  PVector pos;
  
  VFX(PImage[] ray, PVector Pos) {
    imageCount = ray.length;
    images = ray;
    frame = 0;
    pos = Pos;
  }

  boolean render() {
    image(images[frame], pos.x, pos.y);
    if (frame + 1 > imageCount - 1)
       return true; 
    else{
      frame += 1;
      return false;
    }
  }
}