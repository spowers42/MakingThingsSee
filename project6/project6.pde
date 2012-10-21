//Making Things See
//Project 6
//Invisible Pencil
import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;

float previousX;
float previousY;

void setup()
{
  size(640,480);
  kinect=new SimpleOpenNI(this);
  kinect.enableDepth();
  background(0); 
}

void draw()
{
  closestValue = 8000;
  kinect.update();
  int[] depthValues = kinect.depthMap();
  
  for(int y=0; y<480; y++)
  {
    for(int x=0; x<640; x++)
    {
      int reversedX = 640-x-1;
      int i = reversedX+y*640;
      int currentDepthValue = depthValues[i];
      if (currentDepthValue>610 && currentDepthValue<1525 && currentDepthValue<closestValue)
      {
        closestValue = currentDepthValue;
        closestX = x;
        closestY = y;
      }
    }
  }
  
  float interpolatedX = lerp(previousX, closestX, 0.3f);
  float interpolatedY = lerp(previousY, closestY, 0.3f);
  float colorValue = map(closestValue, 610, 1525, 0, 255);
  stroke(0+colorValue, 0, 255-colorValue);
  strokeWeight(3);
  line(previousX, previousY, interpolatedX, interpolatedY);
  previousX = interpolatedX;
  previousY = interpolatedY;
}

void mousePressed(){
  save("drawing.png");
  background(0);
}
