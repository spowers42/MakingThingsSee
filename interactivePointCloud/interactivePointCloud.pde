//Making Things See
//Interactive Point Cloud

import processing.opengl.*;
import SimpleOpenNI.*;

SimpleOpenNI kinect;

float rotation = 0;
float s = 1;
HotSpotBox theBox;

void setup(){
  size(1024, 768, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  theBox = new HotSpotBox(150, new PVector(0,0,600));
}

void draw(){
  background(0);
  kinect.update();
  
  translate(width/2, height/2, -500);
  rotateX(radians(180));
  translate(0,0,500);
  rotateY(radians(map(mouseX, 0, width, -180, 180)));
  translate(0,0,s*-1000);
  scale(s);
  
  stroke(255);
  PVector[] depthPoints = kinect.depthMapRealWorld();
  
  int depthPointsInBox = 0;
  for (int i=0; i<depthPoints.length; i+=5){
    PVector currentPoint = depthPoints[i];
    if (theBox.isBounded(currentPoint)){
      depthPointsInBox++;
    }
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
  
  theBox.draw(map(depthPointsInBox, 0, 1000, 0, 255));
}

void keyPressed(){
  if (keyCode==38){
    s+=0.01;
  }
  if (keyCode==40){
    s-=0.01;
  }
}

class HotSpotBox{
  int boxSize;
  PVector location;
  
  HotSpotBox(int theSize, PVector theLocation){
    boxSize = theSize;
    location = theLocation;
  }
  
  void draw(float a){
    translate(location.x, location.y, location.z);
    fill(255, 0, 0, a);
    stroke(255,0,0);
    box(boxSize);
  }
  
  boolean isBounded(PVector p){
    int l = boxSize/2;
    if (p.x>location.x-l && p.x<location.x+l){
      if(p.y>location.y-l && p.y<location.y+l){
        if(p.z>location.z-l && p.z<location.z+l){
         return true;
        }
      }
    }
   return false; 
  }
}
    
