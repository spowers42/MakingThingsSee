import processing.opengl.*;
import saito.objloader.*;
import SimpleOpenNI.*;
import peasy.*;

PeasyCam cam;
SimpleOpenNI kinect;
OBJModel model;

float s = 1;

void setup(){
  size(1024, 768, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  model = new OBJModel(this, "kinect.obj", "relative", TRIANGLES);
  model.translateToCenter();
  noStroke();
  cam = new PeasyCam(this, 0, 0, 0, 1000);
}

void draw(){
  background(0);
  kinect.update();
  rotateX(radians(180));
  
  lights();
  noStroke();
  
  pushMatrix();
    rotateX(radians(-90));
    rotateZ(radians(180));
    scale(0.65*s);
    model.draw();
  popMatrix();
  
  stroke(255);
  PVector[] depthPoints = kinect.depthMapRealWorld();
  for (int i=0; i<depthPoints.length; i+=100){
    PVector currentPoint = depthPoints[i];
    stroke(100, 30);
    line(0, 0, 0, currentPoint.x, currentPoint.y, currentPoint.z);
    stroke(0, 255, 0);
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
}

void keyPressed(){
  if (keyCode == 38){
    s+=0.01;
  }
  else if (keyCode==40){
    s-=0.01;
  }
}

