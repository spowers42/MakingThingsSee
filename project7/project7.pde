//Making Things See
//Project 7

import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX, closestY;
float lastX, lastY;

MovableImage image1, image2, image3;
int currentImage = 1;

void setup()
{
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();

  image1 = new MovableImage("image1.jpg", true);
  image2 = new MovableImage("image2.jpg", false);
  image3 = new MovableImage("image3.jpg", false);
  background(0);
}

void draw()
{
  closestValue = 8000;
  kinect.update();
  
  int[] depthValues = kinect.depthMap();
  for (int y=0; y<480; y++){
    for (int x=0; x<640; x++){
      int reversedX = 640-x-1;
      int i = reversedX+y*640;
      int currentDepthValue = depthValues[i];
      
      if(currentDepthValue>610 &&
         currentDepthValue<1525 &&
         currentDepthValue<closestValue){
           closestValue = currentDepthValue;
           closestX = x;
           closestY = y;
         }
    }
  }
  float interpolatedX = lerp(lastX, closestX, 0.3);
  float interpolatedY = lerp(lastY, closestY, 0.3);
  background(0);
  image1.update(interpolatedX, interpolatedY, map(closestValue, 610, 1525, 0,4));
  image2.update(interpolatedX, interpolatedY, map(closestValue, 610, 1525, 0,4));
  image3.update(interpolatedX, interpolatedY, map(closestValue, 610, 1525, 0,4));
  image1.draw();
  image2.draw();
  image3.draw();
  lastX = interpolatedX;
  lastY = interpolatedY;
}

void mousePressed(){
  switch(currentImage){
    case 1:
      image1.switchMoving();
      image2.switchMoving();
      currentImage = 2;
      break;
    case 2:
      image2.switchMoving();
      image3.switchMoving();
      currentImage = 3;
      break;
    case 3:
      image3.switchMoving();
      image1.switchMoving();
      currentImage=1;
  }
}

class MovableImage{
  float x, y, scale;
  int imgHeight=100;
  int imgWidth=100;
  PImage img;
  boolean isMoving;
  
  MovableImage(String name, boolean moving)
  {
    img = loadImage(name);
    isMoving = moving;
    scale = 1;
  }
  
  void update(float newX, float newY, float newScale)
  {
    if (isMoving)
    {
      x = newX;
      y = newY;
      scale = newScale;
    }
  }
  
  void switchMoving()
  {
    isMoving = ! isMoving;
  }
  
  void draw(){
    image(img, x, y, imgWidth*scale, imgHeight*scale);
  }
}
