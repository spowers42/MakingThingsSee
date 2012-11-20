import processing.opengl.*;
import SimpleOpenNI.*;

SimpleOpenNI kinect;

void setup(){
  size(1024, 768, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
}

void draw(){
  background(0);
  kinect.update();
  
  translate(width/2, height/2, -750);
  rotateX(radians(180));
  translate(0,0, 750);
  
  float mouseRotation;
  mouseRotation = map(mouseX, 0, width, -180, 180);
  rotateY(radians(mouseRotation));
  
  stroke(255);
  
  PVector[] depthPoints = kinect.depthMapRealWorld();
  for (int i=0; i<depthPoints.length; i+=10){
    PVector currentPoint = depthPoints[i];
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
}
