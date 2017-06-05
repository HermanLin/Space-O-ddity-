class VFX {
  PImage[] images;
  int imageCount;
  int frame;
  PVector pos;
  
  VFX(String imagePrefix, int count, PVector Pos) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      String filename = "animations/" + imagePrefix + i + ".png";
      images[i] = loadImage(filename);
    }
    
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