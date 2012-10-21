//Making Things See
//Project 4
//Wireless tape measure

import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup()
{
  size(640, 480);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
}

void draw()
{
  kinect.update();
  PImage depthImage = kinect.depthImage();
  image(depthImage, 0, 0);
}

void mousePressed(){
  int[] depthValues = kinect.depthMap();
  int clickPosition = mouseX + (mouseY * 640);
  int clickDepth = depthValues[clickPosition];
  
  float inches = clickDepth / 25.4;
  println("inches: " + inches);
}
